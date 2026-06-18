# Add Validation Checks

## What you are doing

Open `day4/checks_practice.ipynb` and work through the three parts.

The notebook runs the Day 3 validation checks against the raw file - before any cleaning has happened. Most checks will fail. That is the point.

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

The raw file has more problems than the five Day 3 checks will catch. Once you have written your own, compare with these:

??? "No duplicate order IDs"
    ```python
    try:
        assert df_raw['order_id'].duplicated().sum() == 0, "duplicate order_id values found"
    except Exception as e:
        errors.append(str(e))
    ```

??? "status values are from the expected set"
    ```python
    try:
        valid_statuses = {'complete', 'pending', 'cancelled'}
        assert df_raw['status'].str.lower().str.strip().isin(valid_statuses).all(), "unexpected status values found"
    except Exception as e:
        errors.append(str(e))
    ```

??? "no £ signs in unit_price"
    ```python
    try:
        assert not df_raw['unit_price'].astype(str).str.contains('£').any(), "unit_price contains £ signs - not yet cleaned"
    except Exception as e:
        errors.append(str(e))
    ```

---

## For silver-->gold: what this would look like in Fabric

After the join in the silver to gold notebook, you would add checks there too. This is illustrative - not a task:

```python
try:
    assert len(joined) == len(sales), "row count changed after join - unexpected"
except Exception as e:
    errors.append(str(e))

try:
    assert joined['category'].isnull().sum() == 0, "some product_ids did not match silver_products"
except Exception as e:
    errors.append(str(e))
```
