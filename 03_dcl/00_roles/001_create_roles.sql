-- NOLOGIN roles carry the permissions. The login user schedule_app is created by
-- barber-saas-infra from a secret; no password is ever versioned here.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'schedule_reader') THEN
        CREATE ROLE schedule_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'schedule_writer') THEN
        CREATE ROLE schedule_writer NOLOGIN;
    END IF;
END
$$;
