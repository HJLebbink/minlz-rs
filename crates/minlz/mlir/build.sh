#!/bin/bash
# Lowers the XXH3 stripe loop (xxh3.mlir) once per target, into crates/minlz/src/xxh3/mlir/<target>/,
# where the naked functions of crates/minlz/src/xxh3/mlir.rs include it. Run it after changing an
# MLIR file and commit its output: the Rust build never runs LLVM.
#
#   crates/minlz/mlir/build.sh
#
# Needs the LLVM and MLIR 23 tools mlir-opt, mlir-translate, opt and llc, on PATH or in $LLVM_BIN
# (apt.llvm.org packages llvm-23 and mlir-23-tools). Runs on Linux or WSL.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
out=$here/../src/xxh3/mlir
bin=${LLVM_BIN:+$LLVM_BIN/}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# lower <target> <target file> <comment start> <llc flags...> lowers xxh3.mlir with the target file
# in front, and with the split lane layout for SVE or the whole one for fixed-width vectors.
lower() {
	local name=$1 target=$2 cmt=$3 layout=whole
	shift 3
	case $target in sve*) layout=split ;; esac
	cat "$here/target/$target.mlir" "$here/xxh3_$layout.mlir" "$here/xxh3.mlir" > "$tmp/$name.mlir"
	"${bin}mlir-opt" "$tmp/$name.mlir" --inline --symbol-dce --canonicalize --convert-scf-to-cf \
		--convert-vector-to-llvm --convert-ub-to-llvm --convert-arith-to-llvm --convert-cf-to-llvm \
		--convert-func-to-llvm --reconcile-unrealized-casts -o "$tmp/$name.llvm.mlir"
	"${bin}mlir-translate" --mlir-to-llvmir "$tmp/$name.llvm.mlir" -o "$tmp/$name.ll"
	"${bin}opt" -O3 "$@" "$tmp/$name.ll" -o "$tmp/$name.bc"
	"${bin}llc" -O3 -asm-verbose=false "$@" "$tmp/$name.bc" -o "$tmp/$name.s"
	mkdir -p "$out/$name"
	for f in accum blocks; do
		{
			echo "$cmt minlz_xxh3_$f of crates/minlz/mlir/xxh3.mlir for $name, written by"
			echo "$cmt crates/minlz/mlir/build.sh. Do not edit."
			awk -v fn="minlz_xxh3_$f" -f "$here/body.awk" "$tmp/$name.s"
		} > "$out/$name/$f.s"
	done
}

# Code for aarch64 keeps x18 free for the systems that reserve it (Android, macOS, Windows) and uses
# base SVE only: Graviton 3 has 256-bit SVE but no SVE2. Code for x86-64 uses the System V calling
# convention on every system (the Rust side declares it extern "sysv64") and Intel syntax, the
# default of naked_asm!. AVX-512 code takes no feature beyond AVX-512F, which is all that
# xxh3::tiers checks, and keeps 512-bit vectors whole.
arm() { lower "$1" "$2" // -mtriple=aarch64-unknown-linux-gnu -mtune=neoverse-v2 "${@:3}"; }
x86() { lower "$1" "$2" '#' -mtriple=x86_64-unknown-linux-gnu -x86-asm-syntax=intel "${@:3}"; }
arm sve128 sve128 -mattr=+v8.2a,+sve,+reserve-x18
arm sve256 sve256 -mattr=+v8.2a,+sve,+reserve-x18
arm neon neon -mattr=+v8a,+neon,+reserve-x18
x86 avx2 x86 -mattr=+avx2
x86 avx512 x86 -mattr=+avx512f,-prefer-256-bit
