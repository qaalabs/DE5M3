# Facilitator Notes — Why Flatten and Join?

*Trainer-only. Short setup before learners open `day1_join.ipynb`.*
*Aim: 10 minutes, then hand over to practice.*

---

## The problem to set up

> "We have two clean datasets. But they are in different shapes. We cannot just put them side by side."

Sales is flat rows — one order line per row, ready to use.
Products is nested JSON — the data we need is buried inside a `specs` object.

Before we can combine them, we need to flatten Products into a table.

---

## Live demo — json_normalize

Show the before and after. Two cells, takes two minutes.

```python
import json
import pandas as pd

with open('products_raw.json') as f:
    products_data = json.load(f)

# Before — nested structure
print(products_data['products'][0])
# {'product_id': 'P001', 'name': 'Smart Thermostat Pro',
#  'category': 'Thermostats',
#  'specs': {'rrp': 89.99, 'warranty_years': 2, ...}}

# After — flat table
products = pd.json_normalize(products_data['products'])
products.head()
# product_id | name | category | specs.rrp | specs.warranty_years | ...
```

**What to point out:** `json_normalize` creates columns named with dot notation — `specs.rrp`, `specs.warranty_years`. That is where the rename step comes from. The data is correct, just the column names need tidying.

---

## Explain the join in plain English

Before they touch the notebook, say this out loud:

> "A left join means: keep every row from Sales, and look up the matching product details. If Sales has a `product_id` that doesn't exist in Products, the product columns will be blank — but the Sales row stays."

Draw it on the board if it helps:

```
Sales (left)          Products (right)
ORD-001  P003   →     P003  Motion Sensor  Sensors
ORD-002  P007   →     P007  Smart Plug     Smart Plugs
ORD-007  (null) →     no match — row kept, category = NaN
```

**If someone asks about inner join:** An inner join would silently drop any Sales row with no matching product. We would lose rows without knowing it. The left join keeps them visible so we can see the problem.

**If someone has SQL experience:** Same concept, different syntax. `df.merge(other, on='product_id', how='left')` is `SELECT * FROM sales LEFT JOIN products ON sales.product_id = products.product_id`.

---

## Hand over

> "Flatten the Products, load your cleaned Sales, join them, calculate line value, and answer the question. The notebook walks you through each step."
