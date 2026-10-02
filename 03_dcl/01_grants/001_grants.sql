GRANT USAGE ON SCHEMA schedule TO schedule_reader, schedule_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA schedule TO schedule_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA schedule TO schedule_writer;
ALTER DEFAULT PRIVILEGES IN SCHEMA schedule GRANT SELECT ON TABLES TO schedule_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA schedule GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO schedule_writer;

-- The domain grants its writer role to its own login user (Annex J J.7). The user exists only
-- where the infrastructure created it, so the grant is conditional. No other domain is granted
-- schedule_reader: other domains read this data through schedule-api (Annex J J.3.3).
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'schedule_app') THEN
        GRANT schedule_writer TO schedule_app;
    END IF;
END
$$;
