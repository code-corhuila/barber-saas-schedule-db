-- One exception per barber and date, overriding the weekly schedule (AGGR-INV-BARBER-002):
-- a day off has no hours; custom hours need both times.
CREATE TABLE schedule.schedule_exception (
    id                 uuid    NOT NULL,
    barbershop_id      uuid    NOT NULL,   -- owned by the barbershop domain: referenced by id, no FK
    barber_profile_id  uuid    NOT NULL,   -- owned by the barbershop domain: referenced by id, no FK
    exception_date     date    NOT NULL,
    is_day_off         boolean NOT NULL DEFAULT true,
    start_time         time    NULL,
    end_time           time    NULL,
    reason             text    NULL,
    CONSTRAINT pk_schedule_exception PRIMARY KEY (id),
    CONSTRAINT uq_schedule_exception_barber_date UNIQUE (barber_profile_id, exception_date),
    CONSTRAINT chk_schedule_exception_reason CHECK (char_length(reason) <= 150),
    CONSTRAINT chk_schedule_exception_hours  CHECK (
        (is_day_off AND start_time IS NULL AND end_time IS NULL)
        OR (NOT is_day_off AND start_time IS NOT NULL AND end_time > start_time))
);
