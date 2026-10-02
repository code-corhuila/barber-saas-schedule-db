DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'schedule_app') THEN
        REVOKE schedule_writer FROM schedule_app;
    END IF;
END
$$;
ALTER DEFAULT PRIVILEGES IN SCHEMA schedule REVOKE ALL ON TABLES FROM schedule_reader, schedule_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA schedule FROM schedule_reader, schedule_writer;
REVOKE USAGE ON SCHEMA schedule FROM schedule_reader, schedule_writer;
