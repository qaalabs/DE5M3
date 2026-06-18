# Day 4 - Validation Before Cleaning

On Day 3 you added validation checks to the silver layer - after cleaning.

This notebook asks a different question: what happens if you run those same checks on the raw file, before any cleaning has happened?


```python
import pandas as pd

df_raw = pd.read_csv('../HomeSphere/data/sales_raw.csv')

print(f'{len(df_raw)} rows loaded')
df_raw.head()
```

## Part 1 - The Day 3 checks on raw data

These are the same five checks from the silver layer notebook.

Run the cell - it will stop at the first failure. That is the point.


```python
assert pd.api.types.is_float_dtype(df_raw['unit_price']), "unit_price should be float"
assert pd.api.types.is_integer_dtype(df_raw['quantity']), "quantity should be int"
assert df_raw['product_id'].isnull().sum() == 0, "product_id should have no nulls"
assert (df_raw['unit_price'] > 0).all(), "all prices should be positive"
assert (df_raw['quantity'] > 0).all(), "all quantities should be positive"

print('All validation checks passed')
```

## Part 2 - Collect all failures with try/except

Using `try/except` lets all checks run even when some fail.

We catch `Exception` rather than just `AssertionError` - because a check on dirty data
can crash before it even reaches the assertion (for example, trying to compare a string to a number).

Run this cell to see every problem at once.


```python
errors = []

try:
    assert pd.api.types.is_float_dtype(df_raw['unit_price']), "unit_price should be float"
except Exception as e:
    errors.append(str(e))

try:
    assert pd.api.types.is_integer_dtype(df_raw['quantity']), "quantity should be int"
except Exception as e:
    errors.append(str(e))

try:
    assert df_raw['product_id'].isnull().sum() == 0, "product_id should have no nulls"
except Exception as e:
    errors.append(str(e))

try:
    assert (df_raw['unit_price'] > 0).all(), "all prices should be positive"
except Exception as e:
    errors.append(str(e))

try:
    assert (df_raw['quantity'] > 0).all(), "all quantities should be positive"
except Exception as e:
    errors.append(str(e))

if errors:
    print(f'{len(errors)} check(s) failed:')
    for err in errors:
        print(f'  FAIL: {err}')
else:
    print('All checks passed')
```

## Discussion

The checks surfaced real problems in the raw file.

You know that cleaning will drop 7 rows. But should the pipeline have even started?

Three options:

- **Let it proceed** - run cleaning as normal, accept that rows will be dropped
- **Stop the pipeline** - fail fast, require the source to fix the data before resubmitting
- **Quarantine bad rows** - save the invalid rows to a separate file for review, process the rest

Which would you choose for this pipeline? Does it depend on what the report is used for?

## Part 3 - Add your checks

The raw file has more issues than the five Day 3 checks caught.

Add three more `try/except` blocks to surface them. Use the reference table in the lab for patterns.


```python
errors = []

# --- Day 3 checks ---
try:
    assert pd.api.types.is_float_dtype(df_raw['unit_price']), "unit_price should be float"
except Exception as e:
    errors.append(str(e))

try:
    assert pd.api.types.is_integer_dtype(df_raw['quantity']), "quantity should be int"
except Exception as e:
    errors.append(str(e))

try:
    assert df_raw['product_id'].isnull().sum() == 0, "product_id should have no nulls"
except Exception as e:
    errors.append(str(e))

try:
    assert (df_raw['unit_price'] > 0).all(), "all prices should be positive"
except Exception as e:
    errors.append(str(e))

try:
    assert (df_raw['quantity'] > 0).all(), "all quantities should be positive"
except Exception as e:
    errors.append(str(e))

# --- add your checks here ---
# TODO 1:

# TODO 2:

# TODO 3:


# --- results ---
if errors:
    print(f'{len(errors)} check(s) failed:')
    for err in errors:
        print(f'  FAIL: {err}')
else:
    print('All checks passed')
```
