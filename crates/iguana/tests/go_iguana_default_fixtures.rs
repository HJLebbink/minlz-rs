//! Full default-mode Iguana decode (Go `Compress` => EntropyANS32) end-to-end.
use iguana::iguana_decompress;
fn unhex(s: &str) -> Vec<u8> {
    (0..s.len() / 2)
        .map(|i| u8::from_str_radix(&s[2 * i..2 * i + 2], 16).expect("hex"))
        .collect()
}
#[test]
fn go_iguana_default_fixtures() {
    let mut n = 0;
    for line in include_str!("iguana_default_fixtures.txt").lines() {
        if line.trim().is_empty() {
            continue;
        }
        let t: Vec<&str> = line.split_whitespace().collect();
        let (input, enc) = match t.as_slice() {
            [e] => (Vec::new(), unhex(e)),
            [i, e] => (unhex(i), unhex(e)),
            _ => panic!("bad line"),
        };
        let dec = iguana_decompress(&enc)
            .unwrap_or_else(|e| panic!("default decode failed ({}B): {e:?}", input.len()));
        assert_eq!(dec, input, "default decode mismatch ({}B)", input.len());
        n += 1;
    }
    assert!(n >= 6);
}
