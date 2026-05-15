# Open Product Data

## What you are doing

The Product catalogue came from a different system and is stored as JSON, not CSV.
Work through **Part 2** of **`day1_clean.ipynb`** and look at its structure.

---

## What to notice

- The file has a top-level wrapper — the products are inside a key called `"products"`
- Each product has a nested `specs` object containing price, warranty, colour, and connectivity
- This nested structure cannot be used directly as a table

Compare this to the Sales CSV you just looked at:

| | Sales | Products |
|---|---|---|
| Format | CSV | JSON |
| Structure | Flat rows | Nested objects |
| Ready to use as a table? | Almost | No — needs flattening |

---

## Discussion

- What would stop you using the Product JSON directly as a pandas DataFrame?
- Which fields from Products will you need when you join to Sales?
- The `specs` object contains `rrp` — how does that compare to `unit_price` in Sales?
