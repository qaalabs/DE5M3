# Silent Failures

!!! abstract "S8: Identify and troubleshoot issues with data processing pipelines."

A **silent failure** is when the pipeline runs, produces output, and raises no errors - but the output is wrong.

That is worse than a crash. A crash tells you something went wrong. A silent failure tells you nothing.

---

## Four scenarios from HomeSphere

Work through these together. For each one:

1. What went wrong?
2. What check would catch it?
3. Where in the pipeline should that check live - bronze, silver, or gold?

---

**Scenario A**

`sales_raw.csv` arrives with 12 rows instead of 30. The pipeline runs. The row count prints in Cell 1. Nothing stops.

**Scenario B**

`order_date` arrives as MM/DD/YYYY instead of DD/MM/YYYY. `pd.to_datetime` with `dayfirst=True` parses it without a warning. The dates are wrong.

**Scenario C**

A `product_id` in sales has no match in `silver_products`. The left join drops that row silently. Gold revenue is understated.

**Scenario D**

A £ symbol appears in the `unit_price` column. `pd.to_numeric` converts the value to NaN. The row is dropped silently.

---

| Scenario | What went wrong | What check catches it | Where |
|----------|----------------|----------------------|-------|
| A | | | |
| B | | | |
| C | | | |
| D | | | |
