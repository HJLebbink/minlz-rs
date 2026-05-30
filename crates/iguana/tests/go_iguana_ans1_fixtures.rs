//! Stage-1 entropy composition: decode full Iguana output that uses **ANS1**
//! per-stream entropy (header≠0), cross-validated against Go
//! (`CompressComposite`, `EntropyANS1`). At least one fixture (the skewed
//! 8-letter-alphabet input) is entropy-coded; the rest fall back to raw.

use iguana::iguana_decompress;

fn unhex(s: &str) -> Vec<u8> {
    assert!(s.len() % 2 == 0, "odd hex length");
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}

#[test]
fn go_ans1_entropy_fixtures() {
    let data = include_str!("iguana_ans1_fixtures.txt");
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
        assert_eq!(dec, input, "decode mismatch ({} byte input)", input.len());
        n += 1;
    }
    assert!(n >= 4, "expected ≥4 fixtures, parsed {n}");
}
