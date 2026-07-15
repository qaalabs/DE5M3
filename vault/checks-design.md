# Which Checks Matter?

## What you already have

The bronze→silver notebook currently validates this after cleaning:

```python
assert df['unit_price'].dtype == float, "unit_price should be float"
assert df['quantity'].dtype == int, "quantity should be int"
assert df['product_id'].isnull().sum() == 0, "product_id should have no nulls"
assert (df['unit_price'] > 0).all(), "all prices should be positive"
assert (df['quantity'] > 0).all(), "all quantities should be positive"
```

These catch type problems and missing required fields. They do not catch everything.

---

## Your task

Design the checks you would add. Use the table below.

For each check, decide:

- **What** are you checking?
- **Where** in the pipeline - bronze→silver, or silver→gold?
- **Essential or nice-to-have?** Essential = the pipeline should stop if this fails. Nice-to-have = useful but not blocking.

---

| Check | Layer | Essential / Nice? |
|-------|-------|-------------------|
| Row count is greater than zero | Bronze→Silver | |
| `order_date` has no nulls after parsing | Bronze→Silver | |
| No duplicate `order_id` values | Bronze→Silver | |
| `status` values are from the expected set | Bronze→Silver | |
| `product_id` values all exist in silver_products | Silver→Gold | |
| Row count after join is ≥ row count in silver_sales | Silver→Gold | |
| All `line_value` amounts are positive | Silver→Gold | |
| Gold revenue total is within a plausible range | Gold | |

---

## Discussion questions

1. Which checks would you mark as essential?
2. Is there a check on this list you would leave out entirely - and why?
3. Can you think of a check that is not on this list but should be?

---

## The harder question

> "How do you know what normal looks like?"

Some checks are easy: no nulls, positive values. Others require knowing the business:

- How many rows should the sales file have? 20? 200? 20,000?
- What is the expected revenue range? £500? £5,000? £500,000?

When you do not know the baseline, you cannot write the check. That is a real problem in new pipelines - and it is worth naming.
