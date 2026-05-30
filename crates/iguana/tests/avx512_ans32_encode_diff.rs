//! Differential test: the AVX-512 ANS32 *encode* kernel (`asm/ans32_encode_avx512.asm`)
//! must produce byte-identical output to the scalar `ans32_encode` (which is
//! itself Go-byte-validated), and must round-trip through `ans32_decode`. On
//! non-AVX-512 hosts `ans32_encode_simd` falls back to scalar, so this still
//! passes trivially.
use iguana::{ans32_decode, ans32_encode, ans32_encode_simd};

fn check(input: &[u8]) {
    let scalar = ans32_encode(input);
    let simd = ans32_encode_simd(input);
    assert_eq!(
        simd,
        scalar,
        "kernel encode != scalar encode ({} B): lens {} vs {}",
        input.len(),
        simd.len(),
        scalar.len()
    );
    // And the kernel-produced stream must decode back to the input.
    let back = ans32_decode(&simd, input.len()).expect("decode kernel output");
    assert_eq!(
        back,
        input,
        "kernel encode did not round-trip ({} B)",
        input.len()
    );
}

// xorshift32 for deterministic data generation.
struct Rng(u32);
impl Rng {
    fn next(&mut self) -> u32 {
        let mut x = self.0;
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        self.0 = x;
        x
    }
}

#[test]
fn avx512_ans32_encode_matches_scalar() {
    // Sizes around the 32-byte chunk boundary + a partial-remainder sweep.
    for n in [
        0usize, 1, 7, 31, 32, 33, 63, 64, 65, 100, 255, 256, 257, 1000, 4096, 4097,
    ] {
        let data: Vec<u8> = (0..n)
            .map(|i| b"lorem ipsum dolor sit amet "[i % 27])
            .collect();
        check(&data);
    }
    // Skewed distributions (where rANS actually shrinks) of various sizes.
    let mut rng = Rng(0x12345);
    for _ in 0..200 {
        let n = 32 + (rng.next() as usize % 8000);
        // Bias toward a small set of bytes -> non-uniform frequencies.
        let data: Vec<u8> = (0..n)
            .map(|_| {
                let r = rng.next();
                if r % 4 == 0 {
                    (r >> 8) as u8
                } else {
                    (r % 12) as u8
                }
            })
            .collect();
        check(&data);
    }
    // Near-uniform random (frequencies all close) and single-byte runs.
    let uniform: Vec<u8> = (0..5000u64)
        .map(|i| (i.wrapping_mul(2654435761) >> 13) as u8)
        .collect();
    check(&uniform);
    check(&[0xABu8; 3000]);
    check(&[7u8; 33]);
}
