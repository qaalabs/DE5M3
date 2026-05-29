# Where Could This Go Wrong?

## The question

!!! question "If this pipeline ran overnight and produced wrong numbers at 9am - how would you know?"

You probably would not. Not immediately. Someone would have to notice the numbers looked off.

A **silent failure** is when the pipeline runs, produces output, and raises no errors - but the output is wrong.
That is worse than a crash, because a crash tells you something went wrong.

---

## Map the risks

Work through each layer. Foreach one, write down:

- What could go wrong here?
- Would the pipeline stop - or would it carry on and produce bad output?

| Layer | What could go wrong? | Silent or loud? |
|-------|---------------------|-----------------|
| Bronze - raw file lands | | |
| Bronze→Silver - cleaning | | |
| Silver - validated tables | | |
| Silver→Gold - join | | |
| Gold - final output | | |

---

## Prompts to get started

Things that could go wrong silently in the HomeSphere pipeline:

- `sales_raw.csv` arrives with 25 rows instead of 30 - Cell 1 prints the lower count, nothing fails
- `order_date` arrives as MM/DD/YYYY - `dayfirst=True` parses it silently with wrong dates
- A `product_id` in sales has no match in `silver_products` - the left join drops it silently, `gold_revenue` understates revenue
- A £ symbol appears in `quantity` instead of `unit_price` - `pd.to_numeric` coerces it to NaN, the row is dropped silently

---

## Discuss

1. Which of these would your current pipeline catch?
2. Which would it miss?
3. Is there a pattern to what kinds of failures are caught vs missed?

