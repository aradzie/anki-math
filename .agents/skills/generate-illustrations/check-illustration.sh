#!/usr/bin/env bash
# Compile one illustration source and verify its build output actually
# landed: run after authoring or editing a .asy or .py illustration source,
# before committing.
#
# Usage: check-illustration.sh <name>
#   <name> is the source file's basename (no extension), e.g. "ellipsoid"
#   for illustrations/ellipsoid.py or "unit_circle" for
#   illustrations/unit_circle.asy.
#
# Exits non-zero and prints the failing podman/uv/make output on any
# compile failure or missing/empty output file.
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "usage: $0 <name>" >&2
  exit 2
fi
name=$1

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
illustrations_dir=$(cd "$script_dir/../../.." && pwd)/illustrations
cd "$illustrations_dir"

check_output() {
  local path=$1 expect=$2
  if [ ! -s "$path" ]; then
    echo "FAIL: $path missing or empty" >&2
    exit 1
  fi
  if ! file "$path" | grep -qi "$expect"; then
    echo "FAIL: $path is not a valid $expect ($(file -b "$path"))" >&2
    exit 1
  fi
  echo "OK: $path ($(stat -c%s "$path") bytes, $(file -b "$path"))"
}

if [ -f "$name.asy" ]; then
  make "$name.pdf" "$name.svg"
  check_output "$name.pdf" "PDF document"
  check_output "$name.svg" "SVG"
elif [ -f "$name.py" ]; then
  make "$name.png"
  check_output "$name.png" "PNG image"
else
  echo "FAIL: no illustrations/$name.asy or illustrations/$name.py found" >&2
  exit 1
fi
