-- Phase 1 - Step 1.1: add foreign keys AFTER loading the data.
-- If one statement fails, you have orphan records: see 03_orphan_checks.sql.
SET search_path TO tpch;

ALTER TABLE nation   ADD FOREIGN KEY (n_regionkey) REFERENCES region (r_regionkey);
ALTER TABLE supplier ADD FOREIGN KEY (s_nationkey) REFERENCES nation (n_nationkey);
ALTER TABLE customer ADD FOREIGN KEY (c_nationkey) REFERENCES nation (n_nationkey);
ALTER TABLE partsupp ADD FOREIGN KEY (ps_partkey)  REFERENCES part (p_partkey);
ALTER TABLE partsupp ADD FOREIGN KEY (ps_suppkey)  REFERENCES supplier (s_suppkey);
ALTER TABLE orders   ADD FOREIGN KEY (o_custkey)   REFERENCES customer (c_custkey);
ALTER TABLE lineitem ADD FOREIGN KEY (l_orderkey)  REFERENCES orders (o_orderkey);
ALTER TABLE lineitem ADD FOREIGN KEY (l_partkey, l_suppkey)
                     REFERENCES partsupp (ps_partkey, ps_suppkey);
