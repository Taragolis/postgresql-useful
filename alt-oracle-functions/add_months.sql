CREATE FUNCTION add_months_ora(DATE, INTEGER)
  RETURNS DATE
LANGUAGE plpgsql
AS $$
DECLARE
  add_months DATE := ($1 + ($2 || ' months') :: INTERVAL) :: DATE;

BEGIN
  IF $1 != last_day_ora($1)
  THEN
    RETURN add_months;
  ELSE
    RETURN last_day_ora(add_months);
  END IF;

END;
$$;
