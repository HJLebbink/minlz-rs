//! Stage-1 cross-validation: the Rust structural (Lizard-LZ) decoder must
//! reproduce inputs from Go Iguana output (`CompressComposite`, `EntropyNone`).
//! `iguana_fixtures.txt` holds `<input_hex> <iguana_encoded_hex>` pairs.

use iguana::{iguana_decompress, iguana_decompress_simd};

fn unhex(s: &str) -> Vec<u8> {
    assert!(s.len() % 2 == 0, "odd hex length");
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}

#[test]
fn go_structural_fixtures() {
    let data = include_str!("iguana_fixtures.txt");
    let mut n = 0;
    for line in data.lines() {
        if line.trim().is_empty() {
            continue;
        }
        let toks: Vec<&str> = line.split_whitespace().collect();
        let (input, enc) = match toks.as_slice() {
            [enc] => (Vec::new(), unhex(enc)),
            [inp, enc] => (unhex(inp), unhex(enc)),
            _ => panic!("malformed fixture line"),
        };
        let dec = iguana_decompress(&enc)
            .unwrap_or_else(|e| panic!("decompress failed ({} byte input): {e:?}", input.len()));
        assert_eq!(
            dec,
            input,
            "structural decode mismatch ({} byte input)",
            input.len()
        );
        // The AVX-512 (VBMI2) kernel must decode genuine Go bytes identically.
        let dec_simd = iguana_decompress_simd(&enc).unwrap_or_else(|e| {
            panic!("simd decompress failed ({} byte input): {e:?}", input.len())
        });
        assert_eq!(
            dec_simd,
            input,
            "AVX-512 structural decode mismatch ({} byte input)",
            input.len()
        );
        n += 1;
    }
    assert!(n >= 6, "expected ≥6 fixtures, parsed {n}");
}
