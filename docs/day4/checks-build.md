# Add Validation Checks

*Practice - Session 1. Individual.*
*Aim: 30 minutes.*

---

## What you are doing

You designed the checks. Now write the code.

The existing validation cell in the bronze→silver notebook is shown below.
Your task is to extend it with three more checks - your choice from the list you designed, or one you came up with yourself.

---

## Existing validation cell

```python
# Validation checks
assert df['unit_price'].dtype == float, "unit_price should be float"
assert df['quantity'].dtype == int, "quantity should be int"
assert df['product_id'].isnull().sum() == 0, "product_id should have no nulls"
assert (df['unit_price'] > 0).all(), "all prices should be positive"
assert (df['quantity'] > 0).all(), "all quantities should be positive"

print('All validation checks passed')
print(df.dtypes)
```

---

## Add your checks below the existing ones

Write the assert statements you would add. Use plain Python - no Fabric required.

```python
# Your additional checks here

```

---

## Reference: useful assert patterns

| What to check | Pattern |
|---------------|---------|
| No rows at all | `assert len(df) > 0, "dataframe is empty"` |
| No nulls in a column | `assert df['col'].isnull().sum() == 0, "..."` |
| No duplicate values | `assert df['col'].duplicated().sum() == 0, "..."` |
| Values are in a known set | `assert df['col'].isin({'A', 'B', 'C'}).all(), "..."` |
| All values positive | `assert (df['col'] > 0).all(), "..."` |
| All values within range | `assert df['col'].between(0, 1000).all(), "..."` |

---

## Suggested additions

Once you have written your own, compare with these:

??? "Row count check"
    ```python
    assert len(df) > 0, "dataframe is empty - check source file"
    ```

??? "No duplicate order IDs"
    ```python
    assert df['order_id'].duplicated().sum() == 0, "duplicate order_id values found"
    ```

??? "order_date parses cleanly"
    ```python
    assert df['order_date'].isnull().sum() == 0, "order_date has nulls - check date format in source"
    ```

??? "status values are from expected set"
    ```python
    valid_statuses = {'Completed', 'Pending', 'Cancelled', 'Returned'}
    assert df['status'].isin(valid_statuses).all(), "unexpected status values found"
    ```

---

## For silver→gold: add a check after the join

The join happens in the second notebook. Add a check after the merge:

```python
sales = spark.read.table('silver_sales').toPandas()
products = spark.read.table('silver_products').toPandas()

joined = sales.merge(products, on='product_id', how='left')

# Your check here - what should always be true after a left join on product_id?
```

??? "Join integrity check"
    ```python
    assert len(joined) == len(sales), "row count changed after join - unexpected"
    assert joined['category'].isnull().sum() == 0, "some product_ids did not match silver_products"
    ```

---

## Reflect

1. Did any check feel difficult to write because you did not know the expected value?
2. Are there checks you would mark as essential vs optional in this specific pipeline?
3. What would you do if a check fails in production - stop the pipeline, or log a warning and continue?
