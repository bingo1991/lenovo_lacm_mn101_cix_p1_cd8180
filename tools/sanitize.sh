#!/bin/sh
# SPDX-License-Identifier: MIT
#
# Replace device identifiers in collected text files.
#
# Usage: sanitize.sh [-a] [-l LIST] FILE...
#
#   -a      Also replace every UUID.  Use this for hardware logs.
#           Do not use it on ACPI dumps: those contain protocol UUIDs.
#   -l LIST Read extra rules from LIST.  One rule per line:
#           <extended regex><TAB><replacement>
#           Blank lines and lines starting with # are ignored.
#           Keep the real device values out of the repository.
#           See redact.list.example.
#
# The script always replaces MAC addresses.

set -eu

aggressive=0
list=""

while [ $# -gt 0 ]; do
	case "$1" in
	-a)
		aggressive=1
		shift
		;;
	-l)
		list="$2"
		shift 2
		;;
	*)
		break
		;;
	esac
done

sed_expr=""
if [ -n "$list" ]; then
	sed_expr=$(mktemp)
	trap 'rm -f "$sed_expr"' EXIT
	while IFS="$(printf '\t')" read -r pattern replacement; do
		case "$pattern" in
		""|\#*) continue ;;
		esac
		printf 's|%s|%s|g\n' "$pattern" "$replacement" >>"$sed_expr"
	done <"$list"
fi

for f in "$@"; do
	sed -E -i \
		-e 's/([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}/<MAC>/g' \
		"$f"

	if [ -n "$sed_expr" ]; then
		sed -E -i -f "$sed_expr" "$f"
	fi

	if [ "$aggressive" -eq 1 ]; then
		sed -E -i \
			-e 's/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/<UUID>/g' \
			"$f"
	fi
done
