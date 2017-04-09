CREATE FUNCTION last_day_ora(DATE)
  RETURNS DATE
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN (date_trunc('MONTH', $1) + '1 month' :: INTERVAL - '1 day' :: INTERVAL) :: DATE ;

END;
$$;

