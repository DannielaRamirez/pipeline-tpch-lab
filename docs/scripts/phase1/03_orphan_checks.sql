-- Phase 1 - Step 1.3: orphan checks (every query should return 0).
SET search_path TO tpch;

SELECT 'orders without customer' AS check_name, COUNT(*) AS orphans
FROM orders o LEFT JOIN customer c ON c.c_custkey = o.o_custkey
WHERE c.c_custkey IS NULL
UNION ALL
SELECT 'lineitem without order', COUNT(*)
FROM lineitem l LEFT JOIN orders o ON o.o_orderkey = l.l_orderkey
WHERE o.o_orderkey IS NULL
UNION ALL
SELECT 'lineitem without partsupp', COUNT(*)
FROM lineitem l LEFT JOIN partsupp ps
  ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
WHERE ps.ps_partkey IS NULL;
