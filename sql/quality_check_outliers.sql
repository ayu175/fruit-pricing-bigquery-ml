WITH base AS (
  SELECT
    weight_lb
  FROM `fruit_prices.fruit_prices_summary`
  WHERE weight_lb IS NOT NULL
),
stats AS (
  SELECT
    APPROX_QUANTILES(weight_lb, 100)[OFFSET(25)] AS q1,
    APPROX_QUANTILES(weight_lb, 100)[OFFSET(75)] AS q3
  FROM base
),
bounds AS (
  SELECT
    (q1 - 1.5 * (q3 - q1)) AS low,
    (q3 + 1.5 * (q3 - q1)) AS high
  FROM stats
)
SELECT
  COUNT(*) AS n,
  COUNTIF(weight_lb < low OR weight_lb > high) AS weight_outliers
FROM base
CROSS JOIN bounds;
