//! Cross-validation against Go Iguana.
//!
//! `ans1_fixtures.txt` holds `<input_hex> <ans1_encoded_hex>` pairs produced by
//! the Go reference (`ANS1Encoder.Encode`). For each we check BOTH directions:
//! our decoder reproduces the input from Go's bytes, AND our encoder reproduces
//! Go's exact bytes (byte-for-byte format fidelity). A line with a single token
//! is the empty-input case (the encoding is never empty).

use iguana::{ans1_decode, ans1_encode};

fn unhex(s: &str) -> Vec<u8> {
    assert!(s.len() % 2 == 0, "odd hex length");
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}

#[test]
fn go_ans1_fixtures() {
    let data = include_str!("ans1_fixtures.txt");
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

        // Decode fidelity: our decoder reproduces the input from Go's bytes.
        let dec = ans1_decode(&enc, input.len())
            .unwrap_or_else(|e| panic!("decode failed ({} byte input): {e:?}", input.len()));
        assert_eq!(dec, input, "decode mismatch ({} byte input)", input.len());

        // Encode fidelity: our encoder reproduces Go's exact bytes.
        let ours = ans1_encode(&input);
        assert_eq!(
            ours,
            enc,
            "encode byte mismatch ({} byte input): ours {} B vs go {} B",
            input.len(),
            ours.len(),
            enc.len()
        );
        n += 1;
    }
    assert!(n >= 8, "expected ≥8 fixtures, parsed {n}");
}
