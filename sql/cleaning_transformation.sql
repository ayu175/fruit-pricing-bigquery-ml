CREATE OR REPLACE VIEW `fruit_prices.fruit_prices_cleaned` AS
SELECT
  month_num,
  year,
  -- derive season from month_num from sub query
  CASE
    WHEN month_num IN (12, 1, 2) THEN 'Winter'
    WHEN month_num IN (3, 4, 5) THEN 'Spring'
    WHEN month_num IN (6, 7, 8) THEN 'Summer'
    WHEN month_num IN (9, 10, 11) THEN 'Fall'
  END AS season,
  -- normalize strings (remove leading and trailing spaces and proper case)
  INITCAP(TRIM(fruit_type)) AS fruit_type,
  INITCAP(TRIM(region)) AS region,
  INITCAP(TRIM(state)) AS state,
  INITCAP(TRIM(ripeness)) AS ripeness,

  weight_lb,
  price_per_lb_usd

  FROM (
  SELECT
    -- convert month to month number
    EXTRACT(
      MONTH FROM PARSE_DATE('%b %Y', TRIM(month))
    ) AS month_num,
    year,
    fruit_type,
    region,
    state,
    ripeness,
    weight_lb,
    price_per_lb_usd

FROM `fruit_prices.fruit_prices_summary`)


