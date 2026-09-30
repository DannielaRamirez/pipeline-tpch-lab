-- Phase 0 - Step 0.4: load the CSV files with \copy
-- Run this from the project root (the folder that contains data/):
--   psql -U postgres -d tpch -f docs/scripts/phase0/02_load_data.sql
-- Files must be CSV with a header row (DuckDB export).
-- If your files came from dbgen (.tbl), convert them first with 00_tbl_to_csv.sh
-- and replace  HEADER true  with  DELIMITER '|'  (and remove HEADER).
-- Load order: parent tables first, then children.

SET search_path TO tpch;

\copy region   FROM 'data/tpch_csv/region.csv'   WITH (FORMAT csv, HEADER true)
\copy nation   FROM 'data/tpch_csv/nation.csv'   WITH (FORMAT csv, HEADER true)
\copy supplier FROM 'data/tpch_csv/supplier.csv' WITH (FORMAT csv, HEADER true)
\copy customer FROM 'data/tpch_csv/customer.csv' WITH (FORMAT csv, HEADER true)
\copy part     FROM 'data/tpch_csv/part.csv'     WITH (FORMAT csv, HEADER true)
\copy partsupp FROM 'data/tpch_csv/partsupp.csv' WITH (FORMAT csv, HEADER true)
\copy orders   FROM 'data/tpch_csv/orders.csv'   WITH (FORMAT csv, HEADER true)
\copy lineitem FROM 'data/tpch_csv/lineitem.csv' WITH (FORMAT csv, HEADER true)
