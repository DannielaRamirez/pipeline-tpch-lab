-- Phase 1 - Step 1.2: compare row counts with the expected TPC-H numbers (scale factor 1).
SET search_path TO tpch;

SELECT t.table_name, t.actual_rows, t.expected_rows,
       CASE WHEN t.actual_rows = t.expected_rows THEN 'OK' ELSE 'CHECK' END AS status
FROM (
    SELECT 'region'   AS table_name, COUNT(*) AS actual_rows, 5       AS expected_rows FROM region
    UNION ALL SELECT 'nation',   COUNT(*), 25      FROM nation
    UNION ALL SELECT 'supplier', COUNT(*), 10000   FROM supplier
    UNION ALL SELECT 'customer', COUNT(*), 150000  FROM customer
    UNION ALL SELECT 'part',     COUNT(*), 200000  FROM part
    UNION ALL SELECT 'partsupp', COUNT(*), 800000  FROM partsupp
    UNION ALL SELECT 'orders',   COUNT(*), 1500000 FROM orders
    UNION ALL SELECT 'lineitem', COUNT(*), 6001215 FROM lineitem
) AS t;
-- If you used a scale factor other than 1, multiply the expected numbers
-- (region and nation always stay 5 and 25).
