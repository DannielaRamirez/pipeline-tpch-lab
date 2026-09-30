#!/usr/bin/env bash
# Only needed if you generated data with the official TPC-H dbgen tool.
# dbgen writes pipe-delimited .tbl files with an extra "|" at the end of every line.
# This script removes that trailing pipe and writes clean files to data/tpch_csv/.
# Usage: ./00_tbl_to_csv.sh /path/to/dbgen
set -euo pipefail
SRC="${1:?Pass the folder that contains the .tbl files}"
OUT="data/tpch_csv"
mkdir -p "$OUT"
for f in "$SRC"/*.tbl; do
  name="$(basename "${f%.tbl}")"
  sed 's/|$//' "$f" > "$OUT/$name.csv"
  echo "converted $name"
done
