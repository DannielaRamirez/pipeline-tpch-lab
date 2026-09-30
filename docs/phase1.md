# Phase 1: Validate the source data in PostgreSQL

**Goal:** prove the source layer is clean before extracting anything: keys, row counts and no orphan records.

### Video

*Video coming soon.*

---

## Step 1.1: Add foreign keys

```bash
psql -U postgres -d tpch -f docs/scripts/phase1/01_add_foreign_keys.sql
```

If a statement fails, the data has orphan records. Use Step 1.3 to find them.

[:material-download: Download 01_add_foreign_keys.sql](scripts/phase1/01_add_foreign_keys.sql){ download }

## Step 1.2: Validate row counts

```bash
psql -U postgres -d tpch -f docs/scripts/phase1/02_validate_counts.sql
```

Expected result: every table shows `OK` (for scale factor 1).

[:material-download: Download 02_validate_counts.sql](scripts/phase1/02_validate_counts.sql){ download }

## Step 1.3: Orphan checks

```bash
psql -U postgres -d tpch -f docs/scripts/phase1/03_orphan_checks.sql
```

Expected result: every check returns `0`.

[:material-download: Download 03_orphan_checks.sql](scripts/phase1/03_orphan_checks.sql){ download }

!!! note "Why check if the constraints already exist?"
    In a real warehouse, source systems can have disabled constraints, async loads or several unvalidated sources. See [Concepts](concepts.md).

**Next:** [Phase 2: Bronze layer](phase2.md)
