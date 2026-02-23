WITH x AS (
  SELECT CAST(price_per_lb_usd AS FLOAT64) AS v
  FROM `fruit_prices.fruit_prices_cleaned`
  WHERE price_per_lb_usd IS NOT NULL
),
m AS (
  SELECT
    COUNT(*) AS n,
    AVG(v) AS mean,
    STDDEV_POP(v) AS sd
  FROM x
),
moments AS (
  SELECT
    ANY_VALUE(m.n) AS n,
    AVG(POW((x.v - m.mean) / NULLIF(m.sd, 0), 3)) AS skewness,
    AVG(POW((x.v - m.mean) / NULLIF(m.sd, 0), 4)) AS kurtosis
  FROM x
  CROSS JOIN m
)
SELECT
  n,
  skewness,
  kurtosis,
  (n / 6.0) * (POW(skewness, 2) + POW(kurtosis - 3, 2) / 4.0) AS jarque_bera,
  EXP(-((n / 6.0) * (POW(skewness, 2) + POW(kurtosis - 3, 2) / 4.0)) / 2.0) AS approx_p_value
FROM moments;
