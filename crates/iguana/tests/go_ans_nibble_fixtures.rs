//! Cross-validation of the scalar ANS-nibble codec against Go
//! `ANSNibbleEncoder.Encode` / `ANSNibbleDecode`, byte-for-byte in both
//! directions. `ans_nibble_fixtures.txt` holds `<input_hex> <encoded_hex>` pairs
//! produced by the Go reference.
use iguana::{ans_nibble_decode, ans_nibble_encode};

fn unhex(s: &str) -> Vec<u8> {
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}

#[test]
fn go_ans_nibble_fixtures() {
    let mut n = 0;
    for line in include_str!("ans_nibble_fixtures.txt").lines() {
        if line.trim().is_empty() {
            continue;
        }
        let t: Vec<&str> = line.split_whitespace().collect();
        let (input, enc) = (unhex(t[0]), unhex(t[1]));
        // Direction 1: decode Go's bytes back to the original input.
        let dec = ans_nibble_decode(&enc, input.len())
            .unwrap_or_else(|e| panic!("nibble decode failed ({}B): {e:?}", input.len()));
        assert_eq!(dec, input, "nibble decode mismatch ({}B)", input.len());
        // Direction 2: our encoder must reproduce Go's bytes exactly.
        assert_eq!(
            ans_nibble_encode(&input),
            enc,
            "nibble encode mismatch ({}B)",
            input.len()
        );
        n += 1;
    }
    assert!(n >= 6, "expected >=6 fixtures, parsed {n}");
}
