# Facilitator Notes — What Did You Find?

*Trainer-only. Run this after learners have completed Parts 1 and 2 of `day1_clean.ipynb`.*

---

## What to draw out

Ask the group: **"What problems did you spot?"**

Take answers from the room before revealing the full list. Most groups find 4–6 unprompted — nudge them toward the rest.

**The 9 issues in `sales_raw.csv`:**

| # | Column | Problem |
|---|--------|---------|
| 1 | `order_date` | Three formats: `2024-01-15`, `15/01/2024`, `16/1/24` |
| 2 | `unit_price` | `£` prefix on some rows — pandas reads the whole column as text |
| 3 | `quantity` | `"two"` instead of `2` (ORD-011) |
| 4 | `quantity` | `0` — not a valid order line (ORD-013) |
| 5 | `unit_price` | `-89.99` — negative price (ORD-021) |
| 6 | `product_id` | Missing on ORD-007 and ORD-019 |
| 7 | `region` | Missing on ORD-010 and ORD-017 |
| 8 | `status` | Mixed case: `complete`, `Complete`, `COMPLETE`, `pending`, `Pending`, `cancelled`, `Cancelled` |
| 9 | all | ORD-002 and ORD-014 appear twice — exact duplicates |

---

## Key points to make

**On dtypes:** The `£` symbol is a good example of a hidden problem. The data *looks* fine in a spreadsheet — numbers are numbers. But pandas reads the column as `object` because of one character, and every calculation on that column silently fails or errors. This is why you check dtypes, not just the values.

**On the duplicate rows:** Ask — *how did they get there?* Could be a double export, a retry, a system bug. The data doesn't tell you. You still have to deal with it.

**On `quantity = "two"`:** Ask — *what happens if you try to sum a column that contains this?* pandas will either error or silently skip it depending on the operation. Neither is what you want.

**On missing `product_id`:** This is the most consequential issue. Two rows have no product ID — without it they can never join to the catalogue. Flag this now so the decision (drop vs. keep) feels motivated when they hit it in the clean session.

---

## On the Product JSON

Ask: **"What's different about this source?"**

Things to surface:
- It's not a flat table — you can't `pd.read_csv` it
- The data you need (`category`) is buried inside `specs`
- It needs flattening before it can be joined

If someone asks about `rrp` vs `unit_price` — good spot. The `rrp` in Products is the recommended retail price; `unit_price` in Sales is what was actually charged. They are related but not the same. No need to reconcile them today, but worth noting.

---

## Bridge to the next session

> "You now know exactly what is wrong. The next session is about fixing it — one problem at a time — so that by the end you have a dataset you can actually trust."

Keep it brisk. The debrief should be 10 minutes, not 20.
