// Copyright 2026 MinIO Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//! A global allocator that counts the allocations of each thread, for the tests that check that a
//! warm encoder or decoder does not allocate. A test binary that includes this file with `#[path]`
//! counts with it; it needs a binary of its own, since a binary has one global allocator.

use std::alloc::{GlobalAlloc, Layout, System};
use std::cell::Cell;

thread_local! {
    static ALLOCS: Cell<usize> = const { Cell::new(0) };
}

/// Counts the allocations of the current thread.
struct Counting;

fn count() {
    let _ = ALLOCS.try_with(|c| c.set(c.get() + 1));
}

// SAFETY: forwards to the system allocator; counting does not allocate.
unsafe impl GlobalAlloc for Counting {
    unsafe fn alloc(&self, l: Layout) -> *mut u8 {
        count();
        // SAFETY: the caller upholds the GlobalAlloc contract.
        unsafe { System.alloc(l) }
    }

    unsafe fn alloc_zeroed(&self, l: Layout) -> *mut u8 {
        count();
        // SAFETY: as for alloc.
        unsafe { System.alloc_zeroed(l) }
    }

    unsafe fn realloc(&self, p: *mut u8, l: Layout, n: usize) -> *mut u8 {
        count();
        // SAFETY: as for alloc.
        unsafe { System.realloc(p, l, n) }
    }

    unsafe fn dealloc(&self, p: *mut u8, l: Layout) {
        // SAFETY: as for alloc.
        unsafe { System.dealloc(p, l) }
    }
}

#[global_allocator]
static GLOBAL: Counting = Counting;

/// Returns the number of allocations of the current thread so far.
fn allocs() -> usize {
    ALLOCS.with(Cell::get)
}

/// Runs f once to warm up, then `runs` times, and fails if those runs allocate.
pub fn check_allocs(what: &str, runs: usize, mut f: impl FnMut()) {
    f(); // warm up
    let before = allocs();
    for _ in 0..runs {
        f();
    }
    let n = allocs() - before;
    assert_eq!(n, 0, "{what}: {n} allocs in {runs} runs");
}

/// Fails unless the counter counts an allocation of the current thread.
pub fn assert_counter_counts() {
    let before = allocs();
    drop(std::hint::black_box(vec![0u8; 100]));
    assert!(allocs() > before);
}
