//! Encode arbitrary bytes at every level, decode, assert equality.
//!
//! Seed corpus from `testdata/fuzz/block-corpus-enc.zip` in the Go repo.

#![no_main]

use libfuzzer_sys::fuzz_target;
use minlz::{decode, encode, Level};

fuzz_target!(|data: &[u8]| {
    // Block codec only handles inputs up to `MAX_BLOCK_SIZE` (8 MiB).
    // Cap at that; the stream fuzzer (`stream_decode_arbitrary`) covers
    // larger inputs via the multi-block path.
    if data.len() > minlz::MAX_BLOCK_SIZE {
        return;
    }
    for level in [Level::Fastest, Level::Balanced, Level::Smallest] {
        let mut enc = Vec::new();
        encode(&mut enc, data, level).expect("encode");
        let mut dec = Vec::new();
        decode(&mut dec, &enc).expect("decode");
        assert_eq!(dec.as_slice(), data, "level {level:?}");
    }
});
