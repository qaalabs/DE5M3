# Facilitator Notes — What Needs to Move?

*Trainer-only. After MED-MAP, before lunch.*
*Aim: 20 minutes.*

---

## What to draw out

Ask groups to share their mapping. The correct answers:

| Item | Layer |
|------|-------|
| `sales_raw.csv` | Bronze |
| `products_raw.json` | Bronze |
| `cleaned_sales` table | Silver |
| `sales_trusted` table | Gold |
| Cleaning logic | Belongs in the bronze→silver notebook |
| Join logic | Belongs in the silver→gold notebook |
| `line_value` calculation | Gold |
| Revenue groupby | Gold (or a view on top of gold) |

---

## What is missing — key teaching point

The Day 2 pipeline has no silver Products table. `products_raw.json` was flattened
inside the join notebook and never saved as a reusable silver dataset.

Ask: **"If a second gold output needed product data, where would it read from?"**

The answer in the Day 2 pipeline is: it would re-flatten the raw JSON again.
That is a design problem — bronze data being processed twice, inconsistently.

The fix: save `silver_products` as an explicit table. Any gold output that needs
product data reads from silver, not bronze.

---

## On naming

The Day 2 table names (`cleaned_sales`, `sales_trusted`) carry no layer information.
A new person cannot tell which is silver and which is gold without reading the notebooks.

The new names (`silver_sales`, `silver_products`, `gold_revenue`) encode the layer
in the name. That is a convention, not a technical requirement — but conventions matter.

---

## Bridge to the afternoon

> "This afternoon you build what you just drew. Same data, same logic — but with the structure you designed this morning. The notebooks are shorter than you might expect because the logic has not changed. What changed is where things live and what they are called."

Keep this brief. Send them to lunch with a clear picture of what they are building.
