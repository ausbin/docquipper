#!/bin/bash
set -e
if [[ $# -ne 1 ]]; then
    printf 'usage: %s file.hs\n' "$0" >&2
    exit 1
fi
file=$1
quipper $file
QasmPrinting <(./${file%.hs}) > ${file%.hs}.qasm
printf 'done writing to %s\n' "${file%.hs}.qasm"
