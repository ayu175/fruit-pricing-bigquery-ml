# Fruit Pricing Analysis - BigQuery ML

What factors significantly influence fruit pricing across regions and seasons?

This project builds a multiple linear regression model using Google BigQuery ML to identify the key drivers of fruit price variation across U.S. regions, seasons, fruit types, and ripeness levels. The full data pipeline — from ingestion and quality checks through transformation, feature engineering, and model training — is implemented entirely in BigQuery using SQL, with model evaluation and visualizations produced in Python.

## Key Findings

The model achieved **R² = 0.9487** on the validation set, explaining ~95% of the variation in price per pound — a strong result indicating that fruit type, region, ripeness, and season together provide a near-complete picture of price drivers.

The null hypothesis (that these variables have no significant effect on price) was **rejected**. All major predictors except weight were statistically significant at α = 0.05.

**Fruit type** is the largest driver of price differences. Relative to Peach (reference):

| Fruit | Price Effect |
|---|---|
| Blueberry | +$2.493/lb |
| Strawberry | +$1.103/lb |
| Pineapple | +$0.651/lb |
| Grape | +$0.191/lb |
| Avocado | −$0.456/lb |
| Mango | −$0.734/lb |
| Orange | −$0.926/lb |
| Banana | −$1.482/lb |

**Region** shows consistent geographic price differences. Relative to South (reference):

| Region | Price Effect |
|---|---|
| West | +$0.207/lb |
| Northeast | +$0.171/lb |
| Midwest | +$0.045/lb |

**Season** — prices are highest in Winter and decline across other seasons. Relative to Winter (reference):

| Season | Price Effect |
|---|---|
| Summer | −$0.335/lb |
| Spring | −$0.121/lb |
| Fall | −$0.091/lb |

**Ripeness** — "Ripe" commands a small premium (+$0.051/lb) while Overripe carries the largest discount (−$0.538/lb). Weight was **not statistically significant** (p = 0.321).

**Model performance on validation set:**

| Metric | Value |
|---|---|
| R² | 0.9487 |
| MAE | 0.1934 |
| Median Absolute Error | 0.1493 |
| MSE | 0.0682 |
| MSLE | 0.0070 |

> Residual analysis revealed heteroscedasticity at higher predicted prices — the model underpredicts some high-priced fruits and shows group-specific clustering, suggesting potential interaction effects (e.g. fruit type × region) that a future model iteration could capture.

## Dataset

- **Source:** [Kaggle](https://www.kaggle.com/datasets/williamsewell/fruit-pricing-dataset) — synthetic fruit pricing dataset
- **Size:** 30,000 records
- **Scope:** U.S. states, 2024–2025
- **Variables:** month, year, state, region, fruit type, ripeness, weight (lb), price per pound (USD), total price (USD)
- `total_price_usd` was excluded from modeling to prevent feature leakage (it is derived from `price_per_lb_usd × weight_lb`)

## Pipeline

All data preparation and modeling steps were implemented in BigQuery using SQL:

**Step 1 — Ingestion:** Dataset loaded into BigQuery with auto-detected schema using a BigQuery load job.

**Step 2 — Quality Checks:** SQL-based NULL checks across all key variables confirmed 0 missing values. IQR-based outlier detection on `weight_lb` found 0 outliers — no imputation required.

**Step 3 — Cleaning & Transformation:** Categorical fields were standardized (trimmed, proper-cased). Month was parsed as a date and converted to a numeric month value (1–12), which was then mapped to a derived `season` variable (Winter: 12/1/2, Spring: 3/4/5, Summer: 6/7/8, Fall: 9/10/11).

**Step 4 — Modeling Dataset:** A cleaned analytical view was created with dummy-encoded categorical predictors (fruit_type, region, ripeness, season) and numeric predictors ready for regression input.

**Step 5 — Model Training:** A BigQuery ML `CREATE MODEL` query trained a multiple linear regression on a 60/40 train/validation split with `price_per_lb_usd` as the target.

**Step 6 — Evaluation & Visualization:** Model performance was evaluated using BigQuery ML's `ML.EVALUATE`. Actual vs. predicted and residuals vs. predicted plots were generated in a BigQuery notebook using Python (pandas, matplotlib).

## Tools & Technologies

Google BigQuery · BigQuery ML · SQL · Python · pandas · matplotlib
