//! Tiny buffer pool used by [`super::MtWriter`] and the parallel
//! decoder.  Mirrors Go's `sync.Pool` of `[]byte` on `writer.go`.
//!
//! The pool holds up to `max_items` empty-but-allocated `Vec<u8>`.
//! `acquire` either pops one or allocates a fresh `Vec` with the
//! requested capacity hint.  `release` clears the vec and pushes it
//! back if there's room, otherwise drops it.
//!
//! Bounded to keep memory steady; one pool is sized to
//! `concurrency + 1` per the MT plan ("one extra in-flight block").

use std::sync::Mutex;

pub(super) struct BufferPool {
    inner: Mutex<Vec<Vec<u8>>>,
    max_items: usize,
    cap_hint: usize,
}

impl BufferPool {
    pub(super) fn new(max_items: usize, cap_hint: usize) -> Self {
        Self {
            inner: Mutex::new(Vec::with_capacity(max_items)),
            max_items,
            cap_hint,
        }
    }

    /// Pop a recycled buffer or allocate a fresh one of at least
    /// `cap_hint` bytes capacity.  Returns an empty `Vec`.
    pub(super) fn acquire(&self) -> Vec<u8> {
        if let Some(buf) = self.inner.lock().unwrap().pop() {
            return buf;
        }
        Vec::with_capacity(self.cap_hint)
    }

    /// Return a buffer to the pool (cleared first).  If the pool is
    /// full, the buffer is dropped.
    pub(super) fn release(&self, mut buf: Vec<u8>) {
        buf.clear();
        let mut guard = self.inner.lock().unwrap();
        if guard.len() < self.max_items {
            guard.push(buf);
        }
    }
}
