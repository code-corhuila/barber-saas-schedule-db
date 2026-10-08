# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

User stories: code-corhuila/barber-saas-docs#4, code-corhuila/barber-saas-docs#59

### Added

- **deploy:** add the migration runner with its own changelog tables
- **ddl:** create the schedule schema
- **ddl:** create barber schedule
- **ddl:** create schedule exception
- **ddl:** create idempotency key
- **dcl:** create roles
- **dcl:** grants

### Fixed

- **liquibase:** add the master changelog that includes the four families

### Changed

- **ddl:** create indexes

### Documentation

- **ddl:** explain why the schedule schema has no foreign keys
- **readme:** explain how the schema is migrated and where the data is
- **readme:** point the header to Barber Saas and barber-saas-docs

### Tests

- **ci:** rebuild the schema from an empty database on every pull request

### Maintenance

- **db:** ignore local env files and liquibase output
- **github:** add the pull request template
- **github:** track the story environment on the board
- **liquibase:** add the master changelog and the ddl, dml, dcl and tcl families
- use the new repository name barber-saas-infra-postgres

[2.0.0]: https://github.com/code-corhuila/barber-saas-schedule-db/releases/tag/v2.0.0
