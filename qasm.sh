#!/bin/bash
set -e
if [[ $# -lt 1 ]]; then
    printf 'usage: %s file.hs\n' "$0" >&2
    exit 1
fi
file=$1
shift
quipper "$file"
QasmPrinting <("./${file%.hs}" "$@") > "${file%.hs}".qasm
printf 'done writing to %s\n' "${file%.hs}.qasm"
