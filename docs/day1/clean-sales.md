# Part 3: Clean the Sales Data

## What you are doing

You have identified the problems in the raw Sales data.

!!! tip "Now fix them - one at a time - so the data is trustworthy enough to use."

Open the notebook: **`local_clean.ipynb`** and work through **Part 3**.

---

## The problems to fix

| Problem                                        | Column      | Fix |
|------------------------------------------------|-------------|-----|
| `£` prefix makes prices text instead of numbers| `unit_price`| Strip the symbol, cast to float |
| Three different date formats                   | `order_date`| Parse with `pd.to_datetime` |
| `"two"` is not a number                        | `quantity`  | Coerce to numeric, drop unparseable rows |
| Mixed capitalisation                           | `status`    | Lowercase and strip whitespace |
| Exact duplicate rows                           | all         | Drop duplicates |
| Missing `product_id`                           | `product_id`| Drop - cannot join without it |
| Missing `region`                               | `region`    | Fill with `"Unknown"` |
| Negative price                                 | `unit_price`| Remove - not a valid order line |
| Zero quantity                                  | `quantity`  | Remove - not a valid order line |

Work through each fix in the notebook. Run the verification cell after each one before moving on.

---

## Decisions, not just mechanics

Some fixes are mechanical - there is only one sensible thing to do.
Others require a judgement call. Notice which is which as you go.

The `product_id` and `region` columns both have missing values, but the fix is different for each:

- **Drop `product_id` nulls** - without a product ID the row cannot join to the Product catalogue and has no analytical value.
- **Fill `region` nulls** - region is useful context but not essential for joining. Flagging as `Unknown` keeps the row rather than losing it.

You may not always agree with these decisions - and that is fine. The important thing is to be explicit about the choice and the reason.

---

## Discussion

After you have run the Data Quality Report cell:

- Which fixes were purely mechanical? Which required a decision?
- What assumptions did you make that someone else might challenge?
- The data started with 30 rows. How many did you end up with, and why?
- If this file arrived every day automatically, what would you want to check each time?
