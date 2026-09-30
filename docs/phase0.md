# Phase 0: Choose data, generate it and load it into PostgreSQL

**Goal:** get a realistic relational dataset and load it into a PostgreSQL source database.

**Dataset:** TPC-H, a standard benchmark with 8 related tables (region, nation, supplier, customer, part, partsupp, orders, lineitem). It has facts and dimensions, so it fits a medallion and star-schema exercise.

!!! info "Fill in your own details"
    - Source and method used: `TODO (DuckDB or official dbgen)`
    - Scale factor: `TODO (for example SF1)`
    - Tool versions: `TODO (Python, DuckDB, PostgreSQL)`

---

## Step 0.1: Get the data

### Video

<!-- Upload your video to YouTube as "Unlisted", then replace YOUR_VIDEO_ID and remove the comment markers:
<div style="position:relative;padding-bottom:56.25%;height:0;">
  <iframe src="https://www.youtube.com/embed/YOUR_VIDEO_ID"
          style="position:absolute;top:0;left:0;width:100%;height:100%;"
          frameborder="0" allowfullscreen></iframe>
</div>
-->
*Video coming soon.*

### Option A: DuckDB (easiest, no registration)

```bash
pip install duckdb
python docs/scripts/phase0/generate_tpch_duckdb.py
```

This creates `data/tpch_csv/` with one CSV file per table (comma-separated, with header).

[:material-download: Download generate_tpch_duckdb.py](scripts/phase0/generate_tpch_duckdb.py){ download }

### Option B: official TPC-H tools (`dbgen`)

1. On the TPC website, go to **Downloads -> Download Programs and Specifications**, select the TPC-H tools, fill in the form and download the zip.
2. Unzip, open the `dbgen` folder, copy `makefile.suite` to `Makefile` and set `CC=gcc`, `DATABASE=ORACLE`, `MACHINE=LINUX`, `WORKLOAD=TPCH`.
3. Build and generate: `make` then `./dbgen -s 1`.
4. You get pipe-delimited `.tbl` files with an extra `|` at the end of each line. Convert them:

```bash
./docs/scripts/phase0/00_tbl_to_csv.sh /path/to/dbgen
```

[:material-download: Download 00_tbl_to_csv.sh](scripts/phase0/00_tbl_to_csv.sh){ download }

### Check

```bash
ls -lh data/tpch_csv/
wc -l data/tpch_csv/*.csv     # SF1: lineitem 6,001,215 rows, orders 1,500,000 (add 1 for the header)
head -3 data/tpch_csv/customer.csv
```

---

## Step 0.2: Create the database and tables

```bash
psql -U postgres -c "CREATE DATABASE tpch;"
psql -U postgres -d tpch -f docs/scripts/phase0/01_create_tables.sql
```

Foreign keys are **not** created yet. They are added after the load in [Phase 1](phase1.md), which avoids load-order errors.

[:material-download: Download 01_create_tables.sql](scripts/phase0/01_create_tables.sql){ download }

---

## Step 0.3: Load the CSV files

Run from the project root, so the relative path `data/tpch_csv/` works:

```bash
psql -U postgres -d tpch -f docs/scripts/phase0/02_load_data.sql
```

The script uses `\copy` (client-side), which avoids file-permission problems on the server. Parent tables load first, then children.

[:material-download: Download 02_load_data.sql](scripts/phase0/02_load_data.sql){ download }

### Check

```sql
SELECT COUNT(*) FROM tpch.lineitem;   -- SF1: 6001215
```

**Next:** [Phase 1: validate the source](phase1.md)
