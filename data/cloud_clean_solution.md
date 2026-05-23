# HomeSphere — Day 2: Clean the Sales Data in Fabric

**Scenario:** The same raw Sales and Product files you worked with locally are now
sitting in your Fabric lakehouse. Your job is to run the same cleaning pipeline
you built on Day 1 — but this time the data lives in OneLake, and the output
will be saved as a Delta table rather than a CSV file.

---

## Part 1: Load the Sales Data

On Day 1 we loaded from a local path. In Fabric, files uploaded to the lakehouse
are available at `/lakehouse/default/Files/`. The path structure mirrors the
folder you see in the Lakehouse Explorer.


```python
import pandas as pd
import json

df = pd.read_csv('/lakehouse/default/Files/data/sales_raw.csv')

print(f'Shape: {df.shape}')
df.head()
```


```python
# Same checks as Day 1 — confirm the data arrived as expected
print('Data types:')
print(df.dtypes)
print('\nMissing values:')
print(df.isnull().sum())
print(f'\nDuplicate rows: {df.duplicated().sum()}')
```

## Part 2: Clean the Sales Data

The same nine fixes as Day 1. The logic is identical — only the file path changed.


```python
# Fix unit_price — strip £ prefix and cast to float
df['unit_price'] = df['unit_price'].astype(str).str.replace('£', '', regex=False).astype(float)

# Standardise order_date — format='mixed' handles multiple date formats in one column
df['order_date'] = pd.to_datetime(df['order_date'], format='mixed', dayfirst=True, errors='coerce')

# Fix quantity — coerce non-numeric to NaN, drop, cast to int
df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
df = df.dropna(subset=['quantity'])
df['quantity'] = df['quantity'].astype(int)

# Standardise status
df['status'] = df['status'].str.lower().str.strip()

# Remove duplicates
df = df.drop_duplicates()

# Handle missing values
df = df.dropna(subset=['product_id'])
df['region'] = df['region'].fillna('Unknown')

# Remove invalid rows
df = df[df['unit_price'] > 0]
df = df[df['quantity'] > 0]

print(f'Rows after cleaning: {len(df)}')
print('\nData types:')
print(df.dtypes)
print('\nMissing values:')
print(df.isnull().sum())
```

## Part 3: Save as a Delta Table

On Day 1 we saved a CSV file. In Fabric, the native output is a **Delta table**
stored in the lakehouse. Delta tables are queryable via the SQL endpoint,
versioned, and accessible to other Fabric workloads.

We convert the pandas DataFrame to a Spark DataFrame to write it as a Delta table.


```python
# Convert to Spark DataFrame and save as a managed Delta table
spark_df = spark.createDataFrame(df)
spark_df.write.mode('overwrite').saveAsTable('cleaned_sales')

print('Saved: cleaned_sales (Delta table)')
print(f'Rows: {spark_df.count()}')
```

## Part 4: Verify in the SQL Endpoint

Now that the table is saved, you can query it using SQL — without writing any more Python.

Switch to the **SQL analytics endpoint** in your lakehouse and run:


```sql
%%sql
SELECT
    status,
    COUNT(*) AS order_count,
    ROUND(SUM(quantity * unit_price), 2) AS total_value
FROM cleaned_sales
GROUP BY status
ORDER BY total_value DESC
```

### Discussion

- What changed between Day 1 and today?
- What stayed exactly the same?
- The output is now a Delta table instead of a CSV — what does that enable that a CSV cannot do?
