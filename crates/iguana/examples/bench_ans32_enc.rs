use iguana::{ans32_encode, ans32_encode_simd};
use std::time::Instant;
fn bench(name: &str, data: &[u8]) {
    assert_eq!(ans32_encode(data), ans32_encode_simd(data));
    let iters = 200;
    let reps = 9;
    let (mut bs, mut bk) = (f64::MAX, f64::MAX);
    for _ in 0..reps {
        let t = Instant::now();
        for _ in 0..iters {
            std::hint::black_box(ans32_encode(std::hint::black_box(data)));
        }
        bs = bs.min(t.elapsed().as_secs_f64());
        let t = Instant::now();
        for _ in 0..iters {
            std::hint::black_box(ans32_encode_simd(std::hint::black_box(data)));
        }
        bk = bk.min(t.elapsed().as_secs_f64());
    }
    let mb = |s: f64| data.len() as f64 * iters as f64 / s / 1e6;
    println!(
        "{name:<10} {:>7} B  scalar {:>6.0}  kernel {:>6.0} MB/s   {:.2}x",
        data.len(),
        mb(bs),
        mb(bk),
        bs / bk
    );
}
fn main() {
    let mut rng = 0x12345u32;
    let mut next = || {
        rng ^= rng << 13;
        rng ^= rng >> 17;
        rng ^= rng << 5;
        rng
    };
    let skewed: Vec<u8> = (0..262144)
        .map(|_| {
            let r = next();
            if r % 4 == 0 {
                (r >> 8) as u8
            } else {
                (r % 16) as u8
            }
        })
        .collect();
    bench("skewed", &skewed);
    let text: Vec<u8> = (0..262144)
        .map(|i| b"the quick brown fox "[i % 20])
        .collect();
    bench("text", &text);
    let uniform: Vec<u8> = (0..262144u64)
        .map(|i| (i.wrapping_mul(2654435761) >> 20) as u8)
        .collect();
    bench("uniform", &uniform);
}
