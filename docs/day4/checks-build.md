# Make It Safe to Run

## The pattern

Every check has three parts:

- **Risk** - what could go wrong
- **Check** - what you test for
- **Response** - what the pipeline should do if it fails

The response is the most important decision. A check that prints a warning and carries on is not a check - it is a log message. If the check matters, failing it should do something.

---

## Open the notebook

Open `day4/checks_practice.ipynb` in Fabric.

The trainer will demo the first check live. Watch the pattern, then continue from TODO 2.

---

## The check pattern

Use explicit logic that is readable and intentional:

```python
row_count = len(silver_sales)
if row_count < 20:
    raise ValueError(f"Row count too low: {row_count} rows. Pipeline stopped.")
```

Or collect checks and report together before stopping:

```python
failures = []

if len(silver_sales) < 20:
    failures.append(f"Row count too low: {len(silver_sales)}")

if silver_sales["product_id"].isnull().sum() > 0:
    failures.append("Nulls found in product_id")

if failures:
    for msg in failures:
        print(f"FAIL: {msg}")
    raise ValueError("Validation failed - pipeline stopped.")
```

---

## The TODOs

Each TODO follows the same structure: risk, check, and what should happen if it fails.

---

### TODO 1 - Row count

**Risk:** Sales file arrives with fewer rows than expected  
**Check:** `silver_sales` has at least 20 rows  
**If this fails:** Stop the pipeline

```python
row_count = len(silver_sales)

# TODO: check row_count and raise a clear error if it is too low
```

---

### TODO 2 - Null check on a key field

**Risk:** `product_id` has nulls, which will cause silent join failures  
**Check:** No nulls in `product_id` in `silver_sales`  
**If this fails:** Stop the pipeline - unmatched rows will understate revenue

```python
null_count = silver_sales["product_id"].isnull().sum()

# TODO: check null_count and raise a clear error if any are found
```

---

### TODO 3 - Join quality

**Risk:** Some sales rows did not match a product after joining  
**Check:** No nulls in `category` after the silver-to-gold join  
**If this fails:** Warn and identify which order IDs are affected

```python
unmatched = gold_revenue[gold_revenue["category"].isnull()]

# TODO: check whether unmatched is empty and respond clearly if not
```

---

### TODO 4 - Value sanity

**Risk:** Negative or zero `quantity` or `line_value` would distort revenue figures  
**Check:** All values in both columns are greater than zero  
**If this fails:** Collect the offending rows and stop promotion to gold

```python
bad_rows = gold_revenue[(gold_revenue["quantity"] <= 0) | (gold_revenue["line_value"] <= 0)]

# TODO: check whether bad_rows is empty and respond clearly if not
```

---

## Stretch task

If you have finished the four TODOs, move your checks into reusable functions:

```python
def check_not_empty(df, name):
    if len(df) == 0:
        raise ValueError(f"{name} is empty")

def check_no_nulls(df, column, name):
    null_count = df[column].isnull().sum()
    if null_count > 0:
        raise ValueError(f"{name}: {null_count} nulls found in {column}")
```

Then call them:

```python
check_not_empty(silver_sales, "silver_sales")
check_no_nulls(silver_sales, "product_id", "silver_sales")
```

Same thinking, cleaner reuse. You could call these from any notebook in the pipeline.

---

## Debrief

Before break, come back together for a few minutes.

The question is not "did your checks work?" It is:

> **What should the pipeline do when a check fails?**

Three options:

- **Stop** - raise an error and halt. Nothing downstream runs. Safe but inflexible.
- **Warn and continue** - print the failure and keep going. Risky if downstream code consumes bad data.
- **Quarantine** - write the failing rows to a rejected file, continue with the clean rows.

There is no single right answer. It depends on what the downstream consumer expects and how bad the failure is.

Push the group: for each of the four checks they wrote - which response makes most sense and why?
