# HomeSphere ~ PM Setup

This notebook prepares the `cleaned_sales` Delta table for the afternoon session.

Run all cells — no changes needed.

---

```python
import pandas as pd

df = pd.read_csv('/lakehouse/default/Files/data/sales_raw.csv')

print(f'Loaded: {df.shape[0]} rows')
```

```python
# Clean: unit_price
df['unit_price'] = df['unit_price'].astype(str).str.replace('£', '', regex=False).astype(float)

# Clean: order_date
df['order_date'] = pd.to_datetime(df['order_date'], format='mixed', dayfirst=True, errors='coerce')

# Clean: quantity
df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
df = df.dropna(subset=['quantity'])
df['quantity'] = df['quantity'].astype(int)

# Clean: status
df['status'] = df['status'].str.lower().str.strip()

# Remove duplicates
df = df.drop_duplicates()

# Handle missing values
df = df.dropna(subset=['product_id'])
df['region'] = df['region'].fillna('Unknown')

# Remove invalid rows
df = df[df['unit_price'] > 0]
df = df[df['quantity'] > 0]

print(f'Cleaned: {len(df)} rows')
```

```python
spark_df = spark.createDataFrame(df)
spark_df.write.mode('overwrite').saveAsTable('cleaned_sales')

print(f'Done: cleaned_sales table created ({spark_df.count()} rows)')
```
