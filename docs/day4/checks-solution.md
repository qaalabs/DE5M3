# Make It Safe to Run - Sample Answers

*One way to complete each TODO in `day4/checks_practice.ipynb`. Other answers are fine if the checks fire on the right rows.*

---

## Part 1 - Fail loudly

Each cell should raise. The data has problems.

### TODO 1 - Missing product

```python
null_count = df_raw["product_id"].isnull().sum()

if null_count > 0:
    raise ValueError(f"{null_count} rows have no product_id. Pipeline stopped.")
```

Expected: `ValueError: 2 rows have no product_id. Pipeline stopped.`

### TODO 2 - Duplicate rows

```python
dup_count = df_raw.duplicated().sum()

if dup_count > 0:
    raise ValueError(f"{dup_count} duplicate rows found. Pipeline stopped.")
```

Expected: 2 duplicate rows (ORD-002 and ORD-014 appear twice).

### TODO 3 - Quantity

```python
quantity = pd.to_numeric(df_raw["quantity"], errors="coerce")
bad_quantity = df_raw[~(quantity > 0)]

if len(bad_quantity) > 0:
    raise ValueError(f"{len(bad_quantity)} rows have a bad quantity: {list(bad_quantity['order_id'])}. Pipeline stopped.")
```

Expected: ORD-011 (`two`) and ORD-013 (`0`).

### TODO 4 - Price

```python
price = df_raw["unit_price"].astype(str).str.replace("£", "", regex=False).astype(float)
bad_price = df_raw[price <= 0]

if len(bad_price) > 0:
    raise ValueError(f"{len(bad_price)} rows have a zero or negative price: {list(bad_price['order_id'])}. Pipeline stopped.")
```

Expected: ORD-021 (`-89.99`).

---

## Part 2 - Collect every problem

```python
errors = []

# 1 - missing product_id
null_count = df_raw["product_id"].isnull().sum()
if null_count > 0:
    errors.append(f"{null_count} rows have no product_id")

# 2 - duplicate rows
dup_count = df_raw.duplicated().sum()
if dup_count > 0:
    errors.append(f"{dup_count} duplicate rows")

# 3 - quantity not a number, or zero or less
quantity = pd.to_numeric(df_raw["quantity"], errors="coerce")
bad_quantity = df_raw[~(quantity > 0)]
if len(bad_quantity) > 0:
    errors.append(f"{len(bad_quantity)} rows have a bad quantity: {list(bad_quantity['order_id'])}")

# 4 - unit price zero or less
price = df_raw["unit_price"].astype(str).str.replace("£", "", regex=False).astype(float)
bad_price = df_raw[price <= 0]
if len(bad_price) > 0:
    errors.append(f"{len(bad_price)} rows have a zero or negative price: {list(bad_price['order_id'])}")

# 5 - missing region
region_nulls = df_raw["region"].isnull().sum()
if region_nulls > 0:
    errors.append(f"{region_nulls} rows have no region")

for msg in errors:
    print(f"ERROR: {msg}")

print(f"{len(errors)} problems found")
```

Expected: 5 problems found.

---

## Stretch Part 3 - Functions

```python
def check_no_nulls(df, column, errors):
    null_count = df[column].isnull().sum()
    if null_count > 0:
        errors.append(f"{null_count} nulls in {column}")


def check_no_duplicates(df, errors):
    dup_count = df.duplicated().sum()
    if dup_count > 0:
        errors.append(f"{dup_count} duplicate rows")


def check_positive(df, column, errors):
    values = pd.to_numeric(df[column], errors="coerce")
    bad = df[~(values > 0)]
    if len(bad) > 0:
        errors.append(f"{len(bad)} rows have a bad {column}: {list(bad['order_id'])}")
```

The call cell is given. Expected: 5 problems found, but `unit_price` now reports 6 rows - the `£` prices are not numbers until cleaning strips the symbol. Only ORD-021 is a real price problem.

---

## Stretch Part 4 - Clean, then check again

```python
silver_errors = []

# same functions, now on silver
check_no_nulls(silver_sales, "product_id", silver_errors)
check_no_nulls(silver_sales, "region", silver_errors)
check_no_duplicates(silver_sales, silver_errors)
check_positive(silver_sales, "quantity", silver_errors)
check_positive(silver_sales, "unit_price", silver_errors)

# rows lost
lost = 1 - len(silver_sales) / len(df_raw)
if lost > 0.25:
    silver_errors.append(f"Cleaning dropped {lost:.0%} of rows")

# dates
bad_dates = silver_sales["order_date"].isnull().sum()
if bad_dates > 0:
    silver_errors.append(f"{bad_dates} order dates could not be read")

# status
allowed = ["complete", "pending", "cancelled"]
bad_status = silver_sales[~silver_sales["status"].isin(allowed)]
if len(bad_status) > 0:
    silver_errors.append(f"{len(bad_status)} rows have an unexpected status: {list(bad_status['status'].unique())}")

for msg in silver_errors:
    print(f"SILVER: {msg}")

print(f"{len(silver_errors)} problems found")
```

Expected: 0 problems found. Cleaning dropped 7 of 30 rows (23%) - just under the 25% limit. Changing it to 10% makes the check fire.

Region passes on silver because cleaning filled 2 blanks with `"Unknown"` - the problem is hidden, not fixed.

---

## Stretch Part 5 - Stop at the end

```python
if silver_errors:
    raise ValueError(f"{len(silver_errors)} silver checks failed. Pipeline stopped.")

print("All silver checks passed - safe to use")
```

Expected: `All silver checks passed - safe to use`. In a Fabric pipeline, this raise is what would make the on-failure path run.
