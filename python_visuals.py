#!pip install --upgrade google-cloud-bigquery

from google.colab import auth
auth.authenticate_user()
print('Authenticated')

# set your google cloud project ID
project_id = 'YOUR_PROJECT_NAME'

from google.cloud import bigquery
import pandas as pd
import matplotlib.pyplot as plt

#create a bigquery client
client = bigquery.Client(project=project_id)

query = """
          SELECT actual_price_per_lb_usd, predicted_price_per_lb_usd, residual
          FROM `YOUR_PROJECT_NAME.fruit_prices.v_actual_residual`
          LIMIT 1000
        """
query_job = client.query(query)

df = query_job.to_dataframe()

#create scatter plot predicted vs residuals

x = df["predicted_price_per_lb_usd"]
y = df["residual"]

plt.figure(figsize=(8,5))
plt.scatter(x, y, s=8, alpha=0.35)
plt.axhline(0)  # residual = 0 reference line
plt.xlabel("predicted_price_per_lb_usd")
plt.ylabel("residual")
plt.title("Residuals vs Predicted Price")
plt.show()

#create scatter plot predicted vs actual price

x = df["actual_price_per_lb_usd"]
y = df["predicted_price_per_lb_usd"]

plt.figure(figsize=(6,6))
plt.scatter(x, y, s=8, alpha=0.35)
mn = min(x.min(), y.min())
mx = max(x.max(), y.max())
plt.plot([mn, mx], [mn, mx])

plt.xlabel("actual_price_per_lb_usd")
plt.ylabel("predicted_price_per_lb_usd")
plt.title("Predicted vs Actual Price")
plt.show()