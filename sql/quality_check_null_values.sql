SELECT
  COUNT(*) AS total_rows,
  COUNTIF(month IS NULL) AS null_month,
  COUNTIF(year IS NULL) AS null_year,
  COUNTIF(state IS NULL) AS null_state,
  COUNTIF(region IS NULL) AS null_region,
  COUNTIF(fruit_type IS NULL) AS null_fruit_type,
  COUNTIF(ripeness IS NULL) AS null_ripeness,
  COUNTIF(weight_lb IS NULL) AS null_weight,
  COUNTIF(price_per_lb_usd IS NULL) AS null_price,
  COUNTIF(total_price_usd IS NULL) as null_total_price
FROM `fruit_prices.fruit_prices_summary`;
