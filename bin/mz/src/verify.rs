//! Verify subcommand: read + validate, no output.

use std::io::{self, Read};
use std::path::PathBuf;

use minlz::stream::Reader;

use crate::args::Options;
use crate::io_util::open_input;

pub fn run(opts: Options, input: Option<PathBuf>) -> io::Result<()> {
    let input = input.ok_or_else(|| io::Error::other("no input file given"))?;
    let (mut src, _) = open_input(&input)?;
    let is_block = opts.block || input.extension().and_then(|s| s.to_str()) == Some("mzb");
    if is_block {
        let mut buf = Vec::new();
        src.read_to_end(&mut buf)?;
        let mut dec = Vec::new();
        minlz::decode(&mut dec, &buf).map_err(io::Error::other)?;
        if !opts.quiet {
            eprintln!("{} ok ({} bytes)", input.display(), dec.len());
        }
        return Ok(());
    }
    let mut reader = Reader::new(&mut src);
    let mut sink = io::sink();
    let n = io::copy(&mut reader, &mut sink)?;
    if !opts.quiet {
        eprintln!("{} ok ({} bytes)", input.display(), n);
    }
    Ok(())
}
