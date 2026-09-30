# End-to-End Data Pipeline Lab

A hands-on lab that builds a realistic data platform from source to dashboard, using the **TPC-H** benchmark dataset.

**Flow:** PostgreSQL (source) -> Snowflake Bronze -> Silver -> Gold (dbt) -> Power BI

| Phase | Goal | Status |
|---|---|---|
| [Phase 0](phase0.md) | Choose the data, generate it, load it into PostgreSQL | Done |
| [Phase 1](phase1.md) | Validate the source: keys, row counts, orphan records | Done |
| [Phase 2](phase2.md) | Extract to files/stage and build the Bronze layer in Snowflake | In progress |
| [Phase 3](phase3.md) | Silver (cleansed, star schema) and Gold (business aggregations) with dbt | Planned |
| [Phase 4](phase4.md) | Connect Power BI to Gold, build the model, DAX and dashboards | Planned |

## How to use this guide

Each step has the same structure: **Goal**, **Video** (me explaining), **Commands**, **Download** (scripts) and **Check** (what result to expect).

!!! warning "Security"
    Never share passwords, `.env` files or Snowflake account names. Use `.env.example` as a template.
