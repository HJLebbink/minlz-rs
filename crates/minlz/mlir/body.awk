# Prints the body of function fn from llc's assembly, written with -asm-verbose=false, for a Rust
# naked function. Fails when fn is not in the file.
#
#   awk -v fn=<symbol> -f body.awk <file.s>
#
# Rust may put two copies of a naked function in one assembly unit (two crate versions under LTO),
# so the body must define no named symbol or label. Each .LBB label becomes a numeric local label,
# and each reference to it becomes Nf or Nb by where the label lies. Constant pool entries (.LCPI)
# that the body uses follow the body, in the same section, under numeric labels of their own. All
# numbers end in 2, so the x86 Intel syntax never reads one as binary. CFI directives are dropped.

$0 ~ "^" fn ":" { inside = 1; found = 1; next }
inside && /^\.Lfunc_end/ { inside = 0; next }
!inside {
	# Constant pool entries: a label, its alignment and the data lines after it.
	if (match($0, /^\.LCPI[0-9_]+:/)) {
		pool = substr($0, 1, RLENGTH - 1)
		pool_align[pool] = align
		pool_data[pool] = ""
	} else if ($0 ~ /^[ \t]*\.p2align/) {
		align = $0
		pool = ""
	} else if (pool != "" && $0 ~ /^[ \t]*\.(quad|long|short|byte|zero|space)[ \t]/) {
		pool_data[pool] = pool_data[pool] $0 "\n"
	} else if ($0 !~ /^[ \t]*$/) {
		pool = ""
	}
	next
}
$0 ~ /^[ \t]*$/ || $0 ~ /^[ \t]*\.cfi_/ { next }
{
	line[++n_lines] = $0
	if (match($0, /^\.LBB[0-9_]+:/)) {
		name = substr($0, 1, RLENGTH - 1)
		label[name] = 10 * ++n_labels - 8
		at[name] = n_lines
	}
}
END {
	if (!found) {
		print "body.awk: no function " fn > "/dev/stderr"
		exit 1
	}
	# Number the pool entries the body uses, in order of first use; they come after every line.
	for (i = 1; i <= n_lines; i++) {
		s = line[i]
		while (match(s, /\.LCPI[0-9_]+/)) {
			name = substr(s, RSTART, RLENGTH)
			if (!(name in label)) {
				if (!(name in pool_data)) {
					print "body.awk: " fn " uses " name ", not found" > "/dev/stderr"
					exit 1
				}
				label[name] = 10 * ++n_labels - 8
				at[name] = n_lines + 1
				used[++n_used] = name
			}
			s = substr(s, RSTART + RLENGTH)
		}
	}
	for (i = 1; i <= n_lines; i++) {
		s = line[i]
		if (match(s, /^\.LBB[0-9_]+:/)) {
			print label[substr(s, 1, RLENGTH - 1)] ":"
			continue
		}
		out = ""
		while (match(s, /\.L(BB|CPI)[0-9_]+/)) {
			name = substr(s, RSTART, RLENGTH)
			if (!(name in label)) {
				print "body.awk: " fn " refers to " name ", defined elsewhere" > "/dev/stderr"
				exit 1
			}
			out = out substr(s, 1, RSTART - 1) label[name] (at[name] > i ? "f" : "b")
			s = substr(s, RSTART + RLENGTH)
		}
		print out s
	}
	for (i = 1; i <= n_used; i++) {
		name = used[i]
		if (pool_align[name] != "")
			print pool_align[name]
		print label[name] ":"
		printf "%s", pool_data[name]
	}
}
