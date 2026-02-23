SELECT
  fruit_type,
  region,
  ripeness,
  season,
  price_per_lb_usd,
  predicted_price_per_lb_usd,
FROM ML.PREDICT(
  MODEL `fruit_prices.fruit_price_linear_regression`,
  (
    SELECT
      fruit_type,
      region,
      ripeness,
      season,
      weight_lb,
      price_per_lb_usd
    FROM `fruit_prices.fruit_prices_cleaned`
  )
);
