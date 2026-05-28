//! MinLZ stream codec — `Reader<R>` / `Writer<W>` over the framing
//! format from `SPEC.md` §4.
//!
//! * [`Reader`] / [`Writer`] — single-threaded encode / decode over any
//!   [`Read`](std::io::Read) / [`Write`](std::io::Write).
//! * [`MtWriter`] / [`Reader::decode_concurrent`] — worker-pool variants
//!   that compress / decompress blocks in parallel.
//! * [`ReadSeeker`] — wraps `Reader<R: Read + Seek>` with random access
//!   driven by the stream index (see [`crate::index`]).
//!
//! Block search tables (`SPEC.md` §4.13) are not implemented in this
//! crate.

mod crc;
mod error;
mod format;
mod mt_pool;
mod mt_reader;
mod mt_writer;
mod reader;
mod seek;
mod writer;

pub use error::{Error, Result};
pub use format::{
    CHUNK_TYPE_PADDING, CHUNK_TYPE_STREAM_IDENTIFIER, DEFAULT_BLOCK_SIZE, MAX_BLOCK_SIZE,
    MAX_USER_CHUNK_SIZE, MAX_USER_NON_SKIPPABLE_CHUNK, MAX_USER_SKIPPABLE_CHUNK, MIN_BLOCK_SIZE,
    MIN_USER_NON_SKIPPABLE_CHUNK, MIN_USER_SKIPPABLE_CHUNK,
};
pub use mt_writer::{MtWriter, MtWriterBuilder};
pub use reader::{Reader, ReaderBuilder, UserChunkCb};
pub use seek::ReadSeeker;
pub use writer::{Writer, WriterBuilder};
