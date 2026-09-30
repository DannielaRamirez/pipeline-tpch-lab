"""Generate the TPC-H dataset with DuckDB and export one CSV per table.

Usage:  python generate_tpch_duckdb.py
Output: data/tpch_csv/<table>.csv  (comma-separated, with header row)
"""
import pathlib

import duckdb

SCALE_FACTOR = 1  # 1 = about 1 GB. Use 0.1 for a quick test.
OUTPUT_DIR = pathlib.Path("data/tpch_csv")


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    con = duckdb.connect()
    con.execute("INSTALL tpch; LOAD tpch;")
    con.execute(f"CALL dbgen(sf={SCALE_FACTOR});")

    tables = [row[0] for row in con.execute("SHOW TABLES").fetchall()]
    for table in tables:
        target = OUTPUT_DIR / f"{table}.csv"
        con.execute(f"COPY {table} TO '{target}' (HEADER, DELIMITER ',')")
        rows = con.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
        print(f"{table:10s} {rows:>10,} rows -> {target}")


if __name__ == "__main__":
    main()
