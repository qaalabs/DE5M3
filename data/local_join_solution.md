# HomeSphere ~ Locally: Flatten, Join, and Answer

**Scenario:** You have a cleaned Sales dataset and a Product catalogue in nested JSON.

Your job is to flatten the Product data into a table, join it to Sales, and answer the question the business is asking:


**Which product categories generate the most revenue?**

---


```python
import pandas as pd
import json
```

## Part 1: Flatten the Product Data

The Product catalogue is a JSON file with a nested `specs` object inside each product.

Before we can join it to Sales we need to flatten it into a flat table.


```python
with open('products_raw.json') as f:
    products_data = json.load(f)

# pd.json_normalize flattens nested dicts into columns
# record_path points to the list of records inside the top-level key
products = pd.json_normalize(products_data['products'])

print('Shape:', products.shape)
print('Columns:', products.columns.tolist())
products
```

### Tidy up column names

`json_normalize` names nested fields with dot notation (`specs.rrp`).

Rename them to something cleaner.


```python
products = products.rename(columns={
    'specs.rrp': 'rrp',
    'specs.warranty_years': 'warranty_years',
    'specs.colour': 'colour',
    'specs.connectivity': 'connectivity'
})

print('Columns after rename:', products.columns.tolist())
products.head()
```

### Select the columns we need

For the join and the revenue analysis we only need `product_id`, `name`, and `category`.

Keeping only what we need avoids polluting the joined table.


```python
products = products[['product_id', 'name', 'category']]
products
```

## Part 2: Load the Cleaned Sales Data

We saved `cleaned_sales.csv` in the previous notebook.

Load it now.


```python
sales = pd.read_csv('cleaned_sales.csv', parse_dates=['order_date'])

print('Shape:', sales.shape)
print('Columns:', sales.columns.tolist())
sales.head()
```

## Part 3: Join Sales to Products

Merge the two DataFrames on `product_id`.

We use a **left join** - keeping every Sales row and matching the product information where it exists.

Any Sales row with a `product_id` not found in Products will have `NaN` in the product columns.


```python
df = sales.merge(products, on='product_id', how='left')

print('Shape after join:', df.shape)
print('\nMissing values after join:')
print(df.isnull().sum())
df.head()
```

## Part 4: Calculate Line Value

Revenue for each order line = `quantity × unit_price`.

Add a `line_value` column.


```python
df['line_value'] = df['quantity'] * df['unit_price']

print('line_value — first 5 rows:')
print(df[['order_id', 'quantity', 'unit_price', 'line_value']].head())
print(f'\nTotal revenue across all orders: £{df["line_value"].sum():,.2f}')
```

## Part 5: Answer the Business Question

**Which product categories generate the most revenue?**

Group by `category`, sum `line_value`, and sort descending.


```python
# This is the business question we have been building towards all day.
revenue_by_category = (
    df.groupby('category')['line_value']
    .sum()
    .sort_values(ascending=False)
    .reset_index()
)

revenue_by_category.columns = ['category', 'total_revenue']
revenue_by_category['total_revenue'] = revenue_by_category['total_revenue'].round(2)

print('Revenue by category:')
revenue_by_category
```


```python
# Format as a readable summary
print('=== Revenue by Category ===')
for _, row in revenue_by_category.iterrows():
    print(f"{row['category']:<20} £{row['total_revenue']:>8,.2f}")
```

## Part 6: Save the Joined Dataset


```python
df.to_csv('sales_joined.csv', index=False)
print('Saved: sales_joined.csv')
print(f'Rows: {len(df)}')
print(f'Columns: {df.columns.tolist()}')
```

---

### Discussion

- Why did we use a left join rather than an inner join?
- What does it mean if a Sales row has `NaN` for `category` after the join?
- What would happen to the revenue totals if we had kept the duplicate rows from the raw file?
- What cleaning steps were essential before the join could work?
