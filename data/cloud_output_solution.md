# HomeSphere — Day 2: Build the Trusted Output

**Scenario:** Your cleaned Sales data is now a Delta table in the lakehouse.
Your job is to flatten the Product catalogue, join it to Sales, calculate revenue,
and save the trusted output as a second Delta table.

By the end of this notebook you will have answered the same business question as
Day 1 — but the answer will live in the lakehouse, queryable by anyone in the workspace.

---


```python
import pandas as pd
import json
```

## Part 1: Load the Cleaned Sales Table

Rather than reading a CSV file, we read directly from the Delta table
saved in the previous notebook.


```python
# Read the Delta table back into a pandas DataFrame
sales = spark.read.table('cleaned_sales').toPandas()
sales['order_date'] = pd.to_datetime(sales['order_date'])

print(f'Shape: {sales.shape}')
sales.head()
```

## Part 2: Flatten the Product Data

The Product JSON is in the same lakehouse Files folder as the raw Sales CSV.
The flattening logic is identical to Day 1.


```python
with open('/lakehouse/default/Files/data/products_raw.json') as f:
    products_data = json.load(f)

products = pd.json_normalize(products_data['products'])
products = products.rename(columns={
    'specs.rrp': 'rrp',
    'specs.warranty_years': 'warranty_years',
    'specs.colour': 'colour',
    'specs.connectivity': 'connectivity'
})
products = products[['product_id', 'name', 'category']]

print(f'Products: {len(products)} rows')
products
```

## Part 3: Join and Calculate Revenue


```python
df = sales.merge(products, on='product_id', how='left')
df['line_value'] = df['quantity'] * df['unit_price']

print(f'Shape after join: {df.shape}')
print(f'Total revenue: £{df["line_value"].sum():,.2f}')
df.head()
```

## Part 4: Save as a Delta Table


```python
spark_df = spark.createDataFrame(df)
spark_df.write.mode('overwrite').saveAsTable('sales_trusted')

print('Saved: sales_trusted (Delta table)')
print(f'Rows: {spark_df.count()}')
```

## Part 5: Answer the Question in SQL

The trusted output is now in the lakehouse. Use the SQL magic command
to answer the revenue question without leaving the notebook.


```sql
%%sql
SELECT
    category,
    ROUND(SUM(line_value), 2) AS total_revenue,
    COUNT(*) AS order_lines
FROM sales_trusted
GROUP BY category
ORDER BY total_revenue DESC
```

## Part 6: Explore in the SQL Endpoint

Switch to the **SQL analytics endpoint** in your lakehouse and run this query:

```sql
SELECT
    category,
    region,
    ROUND(SUM(line_value), 2) AS total_revenue
FROM sales_trusted
GROUP BY category, region
ORDER BY category, total_revenue DESC
```

This breaks revenue down by category **and** region — a query that would have
required more Python on Day 1 but is now just SQL against a live Delta table.

---

### Discussion

- On Day 1 the output was a CSV file on your VM. Today it is a Delta table in OneLake. What is the practical difference for someone who wants to use this data?
- You ran the revenue query in Python on Day 1 and in SQL today. Which felt more natural for this kind of question?
- What would break if `sales_raw.csv` arrived tomorrow with a new column added?
