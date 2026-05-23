# HomeSphere — Day 1: Inspect and Clean

**Scenario:** HomeSphere has exported two raw source files from their systems.
Your job is to understand what is in each file, find what is wrong, and clean the Sales data
into something trustworthy enough to use.

By the end of this notebook you will have a cleaned Sales dataset saved and ready to join.

---


```python
import pandas as pd
import json
```

## Part 1: Meet the Sales Data

Load the raw Sales file and take a look at what is in it.
Do not fix anything yet — just observe.


```python
df = pd.read_csv('sales_raw.csv')
print(f'Shape: {df.shape}')
df.head(10)
```


```python
# Data types — what has pandas inferred?
df.dtypes
```


```python
# Missing values
print('Missing values per column:')
print(df.isnull().sum())
print(f'\nDuplicate rows: {df.duplicated().sum()}')
```


```python
# Look at the unique values in columns that might have problems
print('Status values:')
print(df['status'].unique())

print('\nSample unit_price values:')
print(df['unit_price'].unique())

print('\nSample quantity values:')
print(df['quantity'].unique())

print('\nSample order_date values:')
print(df['order_date'].unique())
```

### Discussion

What problems did you spot?

- Problem 1:
- Problem 2:
- Problem 3:
- Problem 4:
- Problem 5:

Why would it be risky to use this data as-is for reporting?

## Part 2: Meet the Product Data

Now look at the second source — the Product catalogue.
Notice what is different about its structure.


```python
with open('products_raw.json') as f:
    products_data = json.load(f)

print(f'Number of products: {len(products_data["products"])}')
print('\nFirst product:')
print(json.dumps(products_data['products'][0], indent=2))
```


```python
# What categories exist?
categories = [p['category'] for p in products_data['products']]
print('Product categories:', sorted(set(categories)))
```

### Discussion

- What is different about this source compared with Sales?
- What would stop you using it directly as a table?
- Which fields will you need when you join to Sales?

---

## Part 3: Clean the Sales Data

Work through each problem you identified above.
Fix one thing at a time and verify the result before moving on.

### Fix unit_price

Some prices have a `£` prefix which caused pandas to read the column as text (object) instead of a number.
Strip the symbol and convert to float.


```python
# .astype(str) ensures every value is a string before we strip
# .str.replace('£', '', regex=False) removes the £ symbol
# .astype(float) converts the cleaned string to a number
df['unit_price'] = df['unit_price'].astype(str).str.replace('£', '', regex=False).astype(float)

print('unit_price dtype:', df['unit_price'].dtype)
print('Min:', df['unit_price'].min(), '  Max:', df['unit_price'].max())
```

### Standardise order_date

The dates use three different formats. `pd.to_datetime` with `format='mixed'` handles each date individually rather than assuming one format for the whole column. `dayfirst=True` tells pandas to treat ambiguous dates like `01/02/2024` as 1 Feb, not 2 Jan.
Any dates that still fail to parse will become `NaT` (Not a Time — pandas' version of null for dates).


```python
# format='mixed' infers the format for each date individually — needed for mixed-format columns
# dayfirst=True treats ambiguous dates like 01/02/2024 as 1 Feb, not 2 Jan
# errors='coerce' turns any value that cannot be parsed into NaT instead of crashing
df['order_date'] = pd.to_datetime(df['order_date'], format='mixed', dayfirst=True, errors='coerce')

print('order_date dtype:', df['order_date'].dtype)
print('Unparseable dates (NaT):', df['order_date'].isnull().sum())
```

### Fix quantity

`pd.to_numeric` with `errors='coerce'` converts non-numeric values (like `"two"`) to `NaN`.
Drop rows where quantity could not be parsed, then convert to integer.


```python
# TODO: Convert quantity to numeric — use pd.to_numeric with errors='coerce'
# This turns any value that isn't a number (like 'two') into NaN
df['quantity'] = # YOUR CODE HERE

unparseable = df['quantity'].isnull().sum()
print(f'Rows with unparseable quantity (now NaN): {unparseable}')

# TODO: Drop rows where quantity is NaN, then convert the column to int
# Hint: df.dropna(subset=[...]) drops rows where a specific column is NaN
df = # YOUR CODE HERE
df['quantity'] = # YOUR CODE HERE
print('quantity dtype:', df['quantity'].dtype)
```

### Standardise status

Status values have inconsistent capitalisation. Lowercase and strip whitespace.


```python
# TODO: Standardise status — convert to lowercase and strip leading/trailing whitespace
# Hint: pandas string methods chain with .str.lower() and .str.strip()
df['status'] = # YOUR CODE HERE

print('Status values after cleaning:', df['status'].unique())
print(df['status'].value_counts())
```

### Remove duplicates


```python
before = len(df)
# TODO: Remove duplicate rows
# Hint: df.drop_duplicates() returns a DataFrame with duplicate rows removed
df = # YOUR CODE HERE
print(f'Removed {before - len(df)} duplicate rows  ({len(df)} remaining)')
```

### Handle missing values

Two columns have missing values. The decision is different for each:

- `product_id` — without a product ID we cannot join to Product, so the row has no value. Drop it.
- `region` — region is useful context but not critical. Flag as `Unknown` rather than losing the row.


```python
before = len(df)
# Drop rows where product_id is missing — we cannot use these rows in a join
df = df.dropna(subset=['product_id'])
print(f'Removed {before - len(df)} rows with missing product_id')

# TODO: Fill missing region values with the string 'Unknown'
# Hint: .fillna('...') replaces NaN values with the value you provide
df['region'] = # YOUR CODE HERE
print('Remaining missing values:')
print(df.isnull().sum())
```

### Remove invalid rows

A negative price and a zero quantity are not valid order lines.
Remove them and record how many were dropped.


```python
before = len(df)
# Keep only rows where unit_price is greater than zero
df = df[df['unit_price'] > 0]
print(f'Removed {before - len(df)} rows with negative or zero price')

before = len(df)
# TODO: Keep only rows where quantity is greater than zero
df = # YOUR CODE HERE
print(f'Removed {before - len(df)} rows with zero quantity')
```

## Data Quality Report


```python
print('=== CLEANED SALES DATA ===')
print(f'Rows: {len(df)}')
print(f'\nData types:')
print(df.dtypes)
print(f'\nMissing values:')
print(df.isnull().sum())
print(f'\nStatus distribution:')
print(df['status'].value_counts())
df.head()
```


```python
df.to_csv('cleaned_sales.csv', index=False)
print('Saved: cleaned_sales.csv')
```

### Discussion

- Which fixes were mechanical (no judgement needed)?
- Which fixes required a decision?
- What is now better about the data?
- What assumptions have you made that someone else might challenge?
