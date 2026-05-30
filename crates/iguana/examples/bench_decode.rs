// Isolated decode-core benchmark: scalar `decompress_block` vs the AVX-512
// (VBMI2) kernel, with frame-parsing and allocation hoisted OUT of the timed
// loop (reused buffers). This measures the decode cores themselves, not the
// wrapper. Run: cargo run -p iguana --release --example bench_decode
use iguana::{EntropyMode, iguana_compress};

#[cfg(iguana_asm)]
fn bench(name: &str, data: &[u8]) {
    let framed = iguana_compress(data, EntropyMode::None);
    let iters = 300;
    let reps = 9;
    let mut best_s = f64::MAX;
    let mut best_k = f64::MAX;
    let (mut dlen, mut toks) = (0usize, 0usize);
    for _ in 0..reps {
        match iguana::structural_bench_block_cores(&framed, iters) {
            Some((s, k, dl, tk)) => {
                best_s = best_s.min(s);
                best_k = best_k.min(k);
                dlen = dl;
                toks = tk;
            }
            None => {
                println!("{name:<12} (stored raw / not a single None block — skipped)");
                return;
            }
        }
    }
    let mbps = |secs: f64| (dlen as f64 * iters as f64) / secs / 1e6;
    let bpt = dlen as f64 / toks.max(1) as f64;
    println!(
        "{name:<12} {dlen:>8} B  {toks:>7} tok ({bpt:>4.0} B/tok)  scalar {:>6.0}  kernel {:>6.0} MB/s   {:.2}x",
        mbps(best_s),
        mbps(best_k),
        best_s / best_k
    );
}

#[cfg(iguana_asm)]
fn main() {
    // Pathological: one giant overlapped match (scalar uses doubling memcpy).
    bench(
        "giant-match",
        &b"the quick brown fox jumps over the lazy dog. ".repeat(6000),
    );
    // Iguana's sweet spot: MANY short tokens (varied small matches + literals).
    let words: &[&[u8]] = &[
        b"the ",
        b"quick ",
        b"brown ",
        b"fox ",
        b"data ",
        b"value ",
        b"index ",
        b"server ",
        b"request ",
        b"response ",
        b"object ",
        b"field ",
        b"a ",
        b"of ",
    ];
    let mut prose = Vec::new();
    let mut s = 0x1234_5678u32;
    while prose.len() < 1_000_000 {
        s = s.wrapping_mul(1664525).wrapping_add(1013904223);
        prose.extend_from_slice(words[(s >> 28) as usize % words.len()]);
    }
    bench("prose", &prose);
    // JSON-ish records: repeated keys, short varying values -> token dense.
    let mut json = Vec::new();
    let mut i = 0u32;
    while json.len() < 1_000_000 {
        i = i.wrapping_add(1);
        json.extend_from_slice(b"{\"id\":");
        json.extend_from_slice(format!("{},", i % 1000).as_bytes());
        json.extend_from_slice(b"\"name\":\"item\",\"active\":true},");
    }
    bench("json", &json);
    // Medium matches + 24-bit offsets.
    let mut structured = Vec::new();
    for i in 0..200000u32 {
        structured.extend_from_slice(&i.to_le_bytes());
        if i % 5 == 0 {
            structured.extend_from_slice(b"MARK-");
        }
    }
    bench("structured", &structured);
}

#[cfg(not(iguana_asm))]
fn main() {
    println!("bench_decode: AVX-512 kernel is x86_64-windows only");
}
