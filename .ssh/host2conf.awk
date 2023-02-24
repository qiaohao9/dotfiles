# Search the input (and SSH config file) for a given HOST and print all the
# host's settings in a tabular form to standard output. The HOST must be
# provided as a global variable to the Awk process.

BEGIN {
	n = 0  # Explicitly initialise as a number instead of empty string
}

# Skip comments
/^$/ || /^#/ {
	next
}

# A new host definition after we found our host terminates
($1 == "Host" || $1 == "Match") && did_find_host {
	exit
}

# Keep searching until we found our host
$1 == "Host" && $2 ~ HOST {
	did_find_host = 1
	next
}

# Accumulate all settings and their values for our host, ordered by their
# appearance in the input
did_find_host {
	keys[n] = $1
	values[n++] = $2
	width = max(length($1), width)  # Width of the widest key for padding
}

END {
	for (i = 0; i < n; ++i)
		printf "%-"width"s  %s\n", keys[i], values[i]
}

function max(a, b) {
	return a > b ? a : b
}
