SELECT
  *
FROM ML.ADVANCED_WEIGHTS(
  MODEL `fruit_prices.fruit_price_linear_regression`
)
ORDER BY p_value;
