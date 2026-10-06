# barber-saas-schedule-db

> schedule bounded context: database (schema, seeds, migrations)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The `schedule` schema (the weekly hours of each barber, their exceptions for a date,
idempotency keys) versioned with Liquibase (ADR-007), following annex A and Annex J: it has **no
database instance of its own**. Its runner applies the changesets to the single PostgreSQL
instance of `barber-saas-infra-postgres`, with its own changelog tables (`databasechangelog_schedule`).
Model: `06-data/models.md` §4 and §10 in `barber-saas-docs`.

### How to run the migrations

From `barber-saas-infra-postgres`, with the platform up:

```bash
docker compose --env-file env/dev.env run --rm schedule-db-migrate            # update
docker compose --env-file env/dev.env run --rm schedule-db-migrate status --verbose
docker compose --env-file env/dev.env run --rm schedule-db-migrate rollback-count 1
```

### Where the data is

Schema `schedule` in database `barbersaas` of the shared instance. The service reads and
writes it as `schedule_app` (granted `schedule_writer` in `03_dcl/`); nobody else writes it.
Appointment never reads these tables: it asks `schedule-api` for availability.

### How it is tested

`.github/workflows/db-ci.yml` builds the schema from an empty database, checks that a second
update applies nothing, rolls everything back and applies it again.

### What is missing

No seed data yet: schedules are created through the API. Availability is computed by
`schedule-api`, not stored; how schedule learns about bookings is still open (OQ-09).
