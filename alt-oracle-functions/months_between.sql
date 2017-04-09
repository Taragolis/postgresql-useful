CREATE FUNCTION months_between_ora(DATE, DATE)
  RETURNS DOUBLE PRECISION
LANGUAGE plpgsql
AS $$
DECLARE
  months_interval INTERVAL := age($1, $2);

BEGIN
  RETURN (extract(YEAR FROM months_interval) * 12) + extract(MONTH FROM months_interval) +
         (extract(DAY FROM months_interval) / 31);

END;
$$;

