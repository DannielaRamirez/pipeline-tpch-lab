# End-to-End Data Pipeline Lab

PostgreSQL -> Snowflake medallion (Bronze / Silver / Gold) with dbt -> Power BI, using the TPC-H dataset.

The full step-by-step guide (with videos and script downloads) is published as a website:
**https://YOUR-USER.github.io/tpch-lab/**

## Run the guide locally

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
mkdocs serve                     # open http://127.0.0.1:8000
```

## Publish

1. Push this repo to GitHub (branch `main`). The workflow in `.github/workflows/deploy.yml` builds the site on every push.
2. In GitHub: **Settings -> Pages -> Build and deployment -> Deploy from a branch -> `gh-pages` / `(root)` -> Save**.

## Security

Never commit `.env`, passwords, or Snowflake account details. Use `.env.example` as a template.
