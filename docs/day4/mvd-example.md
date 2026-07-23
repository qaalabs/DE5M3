# Example Handover Artefact

*Trainer reference. An example of a well-scoped structured note from the [Create a Handover Artefact](mvd-build.md) activity.*
*Use after the share-back to anchor the debrief - not before the activity.*

---

## HomeSphere Pipeline — Handover Note

**Owner:** Data Engineering team
**Last updated:** Day 3

---

### Overview

This pipeline takes daily sales data and a product catalogue, cleans and joins them, and produces a revenue breakdown by product category. It answers the question: which HomeSphere product categories are generating the most revenue?

---

### Sources

| Source | Format | Contents | How it arrives |
|--------|--------|----------|----------------|
| `sales_raw.csv` | CSV | 30 rows of order lines — order ID, product ID, quantity, unit price, date, status, region | Uploaded manually to Fabric |
| `products_raw.json` | JSON | 9 products with nested specs — name, category, RRP, warranty, colour, connectivity | Uploaded manually to Fabric |

Both files are uploaded to `Files/bronze/` in the HomeSphere lakehouse. They are never modified after landing there.

---

### Layers

| Layer | Name | Contents | Notes |
|-------|------|----------|-------|
| Bronze | `Files/bronze/sales_raw.csv` | Raw sales file, untouched | Starting point if anything goes wrong |
| Bronze | `Files/bronze/products_raw.json` | Raw product catalogue, untouched | |
| Silver | `silver_sales` | Cleaned sales — 23 rows after removing 7 invalid records | Prices stripped of £, dates parsed, nulls and negatives removed |
| Silver | `silver_products` | Flattened product catalogue — 9 products | Nested specs expanded into columns |
| Gold | `gold_revenue` | Sales joined to products, with `line_value` (quantity × unit_price) | Answers the business question |

---

### Run order

1. **HomeSphere - Bronze to Silver** — reads both bronze files, cleans and validates, writes `silver_sales` and `silver_products`
2. **HomeSphere - Silver to Gold** — reads both silver tables, joins on `product_id`, computes `line_value`, writes `gold_revenue`

Run notebook 1 before notebook 2. Gold always reads from silver — never from bronze directly.

---

### Output

`gold_revenue` contains one row per order line, with product name and category attached. Query it with:

```sql
SELECT category, ROUND(SUM(line_value), 2) AS total_revenue
FROM gold_revenue
GROUP BY category
ORDER BY total_revenue DESC
```

Used by: Head of Sales and marketing team to understand which product categories are performing.

---

### Known limitations

- **No row count alerting** — if `sales_raw.csv` arrives with fewer rows than expected, the pipeline runs without warning
- **Manual trigger** — both notebooks must be run by hand; there is no scheduled pipeline
- **No history** — the pipeline processes today's file only; there is no record of previous runs
- **Product catalogue** — if a new product is added to the catalogue after the file was uploaded, it will not appear in `silver_products` until the file is re-uploaded and the pipeline is re-run
