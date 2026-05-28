//! Error type returned by the streaming [`Reader`](super::Reader) and
//! [`Writer`](super::Writer).

use std::io;

use crate::Error as BlockError;

/// Error raised by the MinLZ stream codec.
#[derive(Debug)]
#[non_exhaustive]
pub enum Error {
    /// The stream is structurally malformed (bad chunk header, truncated
    /// chunk, invalid stream identifier, etc.).  Equivalent to Go `ErrCorrupt`.
    Corrupt,
    /// A chunk's masked CRC32C did not match its contents.  Equivalent to
    /// Go `ErrCRC`.
    Crc,
    /// A block's declared or actual uncompressed size exceeds the configured
    /// [`max_block_size`](super::ReaderBuilder::max_block_size).
    /// Equivalent to Go `ErrTooLarge`.
    TooLarge,
    /// The stream uses a feature the reader cannot handle: a reserved
    /// non-skippable chunk, an unknown stream magic (Snappy/S2 fallback
    /// is not implemented in this crate), or an invalid
    /// stream-identifier indicator.  Equivalent to Go `ErrUnsupported`.
    Unsupported,
    /// A block-codec error bubbled up while decoding.
    Block(BlockError),
    /// An underlying I/O error from the wrapped reader/writer.
    Io(io::Error),
}

impl core::fmt::Display for Error {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        match self {
            Error::Corrupt => f.write_str("minlz: corrupt stream"),
            Error::Crc => f.write_str("minlz: CRC mismatch"),
            Error::TooLarge => f.write_str("minlz: block too large"),
            Error::Unsupported => f.write_str("minlz: unsupported chunk or stream"),
            Error::Block(e) => write!(f, "minlz: block decode failed: {e}"),
            Error::Io(e) => write!(f, "minlz: I/O error: {e}"),
        }
    }
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match self {
            Error::Block(e) => Some(e),
            Error::Io(e) => Some(e),
            _ => None,
        }
    }
}

impl From<io::Error> for Error {
    fn from(e: io::Error) -> Self {
        Error::Io(e)
    }
}

impl From<BlockError> for Error {
    fn from(e: BlockError) -> Self {
        Error::Block(e)
    }
}

impl From<Error> for io::Error {
    fn from(e: Error) -> io::Error {
        match e {
            Error::Io(inner) => inner,
            other => io::Error::new(io::ErrorKind::InvalidData, other),
        }
    }
}

/// Specialized [`Result`] type for stream operations.
pub type Result<T> = core::result::Result<T, Error>;
