# Add Validation Checks

## What you are doing

You designed the checks. Now write the code.

Open `day4/checks_practice.ipynb` and work through the four parts.

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
    try:
        assert len(df) > 0, "dataframe is empty - check source file"
    except AssertionError as e:
        errors.append(str(e))
    ```

??? "No duplicate order IDs"
    ```python
    try:
        assert df['order_id'].duplicated().sum() == 0, "duplicate order_id values found"
    except AssertionError as e:
        errors.append(str(e))
    ```

??? "order_date parses cleanly"
    ```python
    try:
        assert df['order_date'].isnull().sum() == 0, "order_date has nulls - check date format in source"
    except AssertionError as e:
        errors.append(str(e))
    ```

??? "status values are from expected set"
    ```python
    try:
        valid_statuses = {'completed', 'pending', 'cancelled', 'returned'}
        assert df['status'].isin(valid_statuses).all(), "unexpected status values found"
    except AssertionError as e:
        errors.append(str(e))
    ```

---

## For silver-->gold: what this would look like in Fabric

If this were running in Fabric, you would also add checks after the join in the silver to gold notebook. This is illustrative - not a task:

```python
# After the merge in the Silver to Gold notebook
try:
    assert len(joined) == len(sales), "row count changed after join - unexpected"
except AssertionError as e:
    errors.append(str(e))

try:
    assert joined['category'].isnull().sum() == 0, "some product_ids did not match silver_products"
except AssertionError as e:
    errors.append(str(e))
```
