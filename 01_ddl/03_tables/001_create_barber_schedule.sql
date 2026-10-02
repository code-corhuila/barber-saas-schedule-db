-- The weekly working hours of a barber. barbershop_id is stored here because the prototype
-- reached the tenant through barber_profiles, which now lives in another domain.
CREATE TABLE schedule.barber_schedule (
    id                 uuid     NOT NULL,
    barbershop_id      uuid     NOT NULL,   -- owned by the barbershop domain: referenced by id, no FK
    barber_profile_id  uuid     NOT NULL,   -- owned by the barbershop domain: referenced by id, no FK
    day_of_week        smallint NOT NULL,   -- 0 = Sunday … 6 = Saturday
    start_time         time     NOT NULL,
    end_time           time     NOT NULL,
    is_active          boolean  NOT NULL DEFAULT true,
    CONSTRAINT pk_barber_schedule PRIMARY KEY (id),
    CONSTRAINT chk_barber_schedule_day  CHECK (day_of_week BETWEEN 0 AND 6),
    CONSTRAINT chk_barber_schedule_time CHECK (end_time > start_time)
);
