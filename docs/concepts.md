# Concepts I learned

## Why duplicates and orphan records still happen

If a transactional (OLTP) database enforces primary and foreign keys, duplicates and orphans should not exist in the source. In real data platforms they still appear:

**Orphan or invalid records**

- **Partial and asynchronous loads:** orders arrive daily but customers only weekly, so an order can reference a customer that has not arrived yet.
- **Multiple unvalidated sources:** CSV files, third-party APIs and streaming tools (for example Kafka) do not enforce relational constraints.
- **Disabled constraints:** some high-throughput systems disable foreign keys at peak times to write faster.

**Duplicate records**

- **Pipeline retries (at-least-once delivery):** if an Airflow DAG fails halfway and runs again, the same batch can be ingested twice.
- **Change Data Capture (CDC):** when a customer changes an address, the raw table can hold two rows with the same primary key (old state and new state).

## Where the medallion layers help

| Layer | Role |
|---|---|
| **Bronze (raw)** | Ingest everything as-is, without failing, and keep the raw history |
| **Silver (cleansed and modeled)** | Deduplicate, handle null keys, remove orphans, standardize types |
| **Gold (analytics)** | Validated dimensional models and aggregations ready for Power BI |

## Deduplication

**Deduplication** identifies and removes redundant copies of the same record, so each entity, transaction or event appears exactly once. Without it, metrics and dashboards can be wrong.

**Exact duplicate rows** (all columns identical):

```sql
SELECT DISTINCT * FROM bronze.customer;
```

**Logical duplicates** (same primary key, keep the latest version):

```sql
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rn
    FROM bronze.customer
) AS ranked
WHERE rn = 1;
```

## Python notes

**List vs tuple**

- `[...]` creates a **list**: ordered and **mutable** (it can change). Useful for collections that grow or change.
- `(...)` creates a **tuple**: ordered and **immutable** (it cannot change).

**Entry point: `if __name__ == "__main__":`**

1. The top level of a module is for **definitions only**: imports, constants, and `def` / `class`.
2. **No active execution on import:** do not run queries or `print()` at the top level.
3. Put the script workflow inside the main guard.

**Why create a `main()` function?**

- **Scope control:** variables inside `main()` are local, so no accidental global state.
- **Testability and reuse:** an orchestrator such as Airflow can do `from my_script import main` and call it.
- **Readability:** it separates defining the workflow from triggering it.

```python
def main() -> None:
    ...  # your pipeline steps

if __name__ == "__main__":
    main()
```
