CREATE OR REPLACE MODEL `fruit_prices.fruit_price_linear_regression`
OPTIONS (
  model_type = 'linear_reg',
  input_label_cols = ['price_per_lb_usd'],
  CALCULATE_P_VALUES = TRUE,
  CATEGORY_ENCODING_METHOD = 'DUMMY_ENCODING',
  L1_REG = 0,
  DATA_SPLIT_METHOD = 'RANDOM',
  DATA_SPLIT_EVAL_FRACTION = 0.4
) AS
SELECT
  price_per_lb_usd,
  fruit_type,
  region,
  ripeness,
  season,
  weight_lb
FROM `fruit_prices.fruit_prices_cleaned`;
