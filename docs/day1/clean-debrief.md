# Facilitator Notes — Clean Debrief

*Trainer-only. Run this after learners have completed Part 3 of `day1_clean.ipynb`.*

---

## What to draw out

Ask the group: **"How many rows did you start with and end with?"**

**Expected journey:**

| Step | Rows remaining |
|------|---------------|
| Raw data loaded | 30 |
| After dropping unparseable quantity (`"two"`) | 29 |
| After dropping duplicates | 27 |
| After dropping missing `product_id` | 25 |
| After removing negative price | 24 |
| After removing zero quantity | 23 |

If someone gets a different number, work through it with them — it usually means they applied steps in a different order or missed one. The order matters for the count, not for the final quality.

---

## Mechanical vs. decision fixes

Ask: **"Which fixes were just mechanics, and which required a judgement call?"**

**Mechanical — one right answer:**

- Strip `£` from `unit_price` → only sensible interpretation
- Parse mixed date formats → `pd.to_datetime` handles this
- Lowercase `status` → obvious standardisation
- Drop duplicate rows → exact duplicates add nothing

**Required a decision:**

- `quantity = "two"` → drop the row or try to interpret it? (dropping is safest — guessing is risky at scale)
- Missing `product_id` → drop or keep? (drop — the row has no join value)
- Missing `region` → drop or fill? (fill with `Unknown` — region is context, not critical)
- Negative price → remove or flag as a return? (removed here — HomeSphere's data doesn't distinguish returns, so treating as invalid is defensible)
- Zero quantity → remove or investigate? (removed — a zero-quantity order line is not a sale)

The point to make: **data cleaning is not just code, it is policy.** Every decision here is an assumption that downstream users will rely on. If your assumptions are wrong, the reports built on this data are wrong.

---

## Key points to make

**On `errors='coerce'`:** This is a pattern worth dwelling on. Instead of crashing on bad input, pandas converts it to `NaN` — which you can then inspect and decide what to do with. It separates *detecting* the problem from *deciding* what to do about it.

**On the missing value decision:** The `product_id` vs `region` split is the clearest example of context-driven cleaning. Same symptom (missing value), completely different response. Ask — *what would happen if we had filled `product_id` with `Unknown` instead of dropping?* The join would silently produce rows that match nothing in Products — harder to spot than a missing row.

**On validation:** After each fix, they ran a check. Ask — *why not just do all the fixes and check at the end?* If something goes wrong mid-way, you don't know which step caused it. Fixing one thing at a time and verifying is slower but much easier to debug.

---

## Numbers check

The data quality report should show:
- No missing values in any column
- `unit_price` dtype: `float64`
- `order_date` dtype: `datetime64`
- `quantity` dtype: `int64`
- `status` unique values: `complete`, `pending`, `cancelled`

If any of these are off, it is worth tracing back which step was skipped or applied incorrectly.

---

## Bridge to the next session

> "You now have a clean, trustworthy Sales dataset saved as `cleaned_sales.csv`. The next session brings in the Product data — we flatten it, join it to Sales, and use the combined dataset to answer the question HomeSphere actually cares about."
