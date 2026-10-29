# Make It Safe to Run

!!! abstract "S9: Query and manipulate data using tools and programming such as SQL and Python. Manage database access, and implement automated validation checks."

## The pattern

Every check has three parts:

- **Risk** - what could go wrong
- **Check** - what you test for
- **Response** - what the pipeline should do if it fails

The response is the most important decision. A check that prints a warning and carries on is not a check - it is a log message. If the check matters, failing it should do something.

---

## Step 1: Run Jupyter Notebook in your Virtual Machine

Open the notebook: `day4/checks_practice.ipynb`

*Your trainer will demo the first check live. Watch the pattern, then continue from TODO 2.*

`sales_raw.csv` has 30 rows. The cleaned table has 23. This time you check the raw data **before** it is cleaned.

---

## Step 2: Fail loudly

Use explicit logic that is readable and intentional:

```python
null_count = df_raw["product_id"].isnull().sum()
if null_count > 0:
    raise ValueError(f"{null_count} rows have no product_id. Pipeline stopped.")
```

| TODO | Check |
|---|---|
| 1 - Missing product | No nulls in `product_id` |
| 2 - Duplicate rows | No fully duplicated rows |
| 3 - Quantity | Every quantity is a number greater than zero |
| 4 - Price | Every unit price is greater than zero |

Every check should fail - the raw data has problems. Then try **Run All**: the notebook stops at the first one.

---

## Step 3: Collect every problem

Instead of raising straight away, add each problem to a list and print them all:

```python
errors = []

if null_count > 0:
    errors.append(f"{null_count} rows have no product_id")

# ... the other checks ...

for msg in errors:
    print(f"ERROR: {msg}")
```

Every problem, one run.

---

## Stretch

Each part builds on the last.

### Part 3: Functions

Turn your checks into reusable functions that append to the list, then call them on the raw data:

```python
def check_no_nulls(df, column, errors):
    ...
```

### Part 4: Clean, then check again

Run the cleaning, then call the **same functions** on silver - they should now pass. Add checks that only make sense after cleaning: how many rows were lost, dates that failed to parse, status values.

### Part 5: Stop at the end

Raise one `ValueError` at the end if there are any silver errors.

A notebook only *fails* when an error is raised. A pipeline's on-failure path only fires when a notebook fails.

---

!!! note "The question is not *did your checks work?* It is: What should the pipeline do when a check fails?"
