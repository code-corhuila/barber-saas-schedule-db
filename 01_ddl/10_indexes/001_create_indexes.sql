-- "hours of a barber on a weekday", what availability reads on every request
CREATE INDEX IF NOT EXISTS idx_barber_schedule_barber_day ON schedule.barber_schedule (barber_profile_id, day_of_week);
-- "schedules of a barbershop", the tenant filter
CREATE INDEX IF NOT EXISTS idx_barber_schedule_barbershop_id ON schedule.barber_schedule (barbershop_id);
CREATE INDEX IF NOT EXISTS idx_schedule_exception_barbershop_id ON schedule.schedule_exception (barbershop_id);
