//! Cross-validation of scalar ANS32 encode+decode against Go `ANS32Encoder`.
use iguana::{ans32_decode, ans32_encode};
fn unhex(s: &str) -> Vec<u8> {
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}
#[test]
fn go_ans32_fixtures() {
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
        let dec = ans32_decode(&enc, input.len())
            .unwrap_or_else(|e| panic!("ans32 decode failed ({}B): {e:?}", input.len()));
        assert_eq!(dec, input, "ans32 decode mismatch ({}B)", input.len());
        // encode must reproduce Go's exact bytes
        assert_eq!(
            ans32_encode(&input),
            enc,
            "ans32 encode mismatch ({}B)",
            input.len()
        );
        n += 1;
    }
    assert!(n >= 6);
}
