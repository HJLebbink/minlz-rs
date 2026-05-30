//! Differential test: the SVE2 structural-decode kernel (`asm/decompress_sve2.S`)
//! must produce byte-identical output to the scalar `decompress_block` oracle,
//! over inputs that exercise the LZ token paths (short/long literals, 16- and
//! 24-bit offsets, short/long matches, last-offset reuse, overlapped copies).
//! On non-SVE2 hosts `iguana_decompress_simd` transparently falls back to scalar,
//! so this still passes (trivially) everywhere — the real check runs on SVE2
//! silicon (the GB10 / a Graviton 3).
use iguana::{EntropyMode, iguana_compress, iguana_decompress, iguana_decompress_simd};

fn check(input: &[u8]) {
    // EntropyMode::None keeps the six streams raw, so the kernel (which decodes
    // the structural layer) is exercised directly without the ANS stage.
    let framed = iguana_compress(input, EntropyMode::None);
    let scalar = iguana_decompress(&framed).expect("scalar decode");
    assert_eq!(scalar, input, "scalar round-trip failed ({} B)", input.len());
    let simd = iguana_decompress_simd(&framed).expect("simd decode");
    assert_eq!(simd, input, "SVE2 decode != input ({} B)", input.len());
    assert_eq!(simd, scalar, "SVE2 decode != scalar ({} B)", input.len());
}

#[test]
fn sve2_decompress_matches_scalar() {
    // Text with lots of repeats (16-bit offsets, last-offset reuse).
    check(&b"the quick brown fox jumps over the lazy dog. ".repeat(64));
    // Highly repetitive (short offsets, overlapped copies).
    check(&b"abcabcabcabcabcd".repeat(400));
    // Run-length: offset 1, tiny-chunk overlap copy.
    check(&vec![0u8; 9000]);
    check(&[0x5au8; 1]);
    check(&[0xa5u8; 33]);
    // Long literal runs (pseudo-random, few matches -> long literals + varuints).
    let pseudo: Vec<u8> = (0..20000u32)
        .map(|i| (i.wrapping_mul(2654435761) >> 24) as u8)
        .collect();
    check(&pseudo);
    // Mixed: structured-ish data with medium matches and 24-bit offsets.
    let mut big = Vec::new();
    for i in 0..40000u32 {
        big.extend_from_slice(&i.to_le_bytes());
        if i % 7 == 0 {
            big.extend_from_slice(b"PATTERN-MARKER-");
        }
    }
    check(&big);
    // A spread of sizes to hit the 64-token batch boundary and the remainder
    // path; also exercises empty.
    check(&[]);
    for n in [1usize, 2, 7, 8, 15, 16, 64, 65, 127, 128, 200, 511, 512, 1000, 4096, 4097] {
        let data: Vec<u8> = (0..n).map(|i| b"lorem ipsum dolor sit amet "[i % 27]).collect();
        check(&data);
    }
}
