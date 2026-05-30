//! Differential test of the AVX-512 ANS32 kernel against the scalar oracle
//! (`ans32_decode`, itself byte-validated vs Go) over the Go ANS32 fixtures.
//! On a non-AVX-512 host `ans32_decode_simd` falls back to scalar, so this
//! still passes (trivially); on this host it exercises the NASM kernel.

use iguana::{ans32_decode, ans32_decode_simd};

fn unhex(s: &str) -> Vec<u8> {
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}

#[test]
fn avx512_ans32_matches_scalar_and_go() {
    let mut n = 0;
    for line in include_str!("ans32_fixtures.txt").lines() {
        if line.trim().is_empty() {
            continue;
        }
        let t: Vec<&str> = line.split_whitespace().collect();
        let (input, enc) = match t.as_slice() {
            [e] => (Vec::new(), unhex(e)),
            [i, e] => (unhex(i), unhex(e)),
            _ => panic!("bad line"),
        };
        let scalar = ans32_decode(&enc, input.len()).expect("scalar decode");
        let simd = ans32_decode_simd(&enc, input.len()).expect("simd decode");
        assert_eq!(simd, scalar, "simd != scalar ({}B)", input.len());
        assert_eq!(simd, input, "simd != go input ({}B)", input.len());
        n += 1;
    }
    assert!(n >= 6);
}
