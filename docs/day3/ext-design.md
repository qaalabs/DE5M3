# Design B/S/G for a New Source

## Your task

HomeSphere has more data sources beyond Sales and Products.
Your group has been assigned one of the sources below.

Design what bronze, silver, and gold would look like for your source —
without building anything. This is a design exercise.

You have 20 minutes. Prepare to share your design with the room.

---

## Source A — Inventory

HomeSphere tracks stock levels across multiple warehouses. The raw export is a
daily CSV snapshot with one row per product per warehouse:

```
product_id, warehouse_id, warehouse_name, stock_level, reorder_threshold,
last_restocked, supplier_id, supplier_name
```

Known issues in the raw data:
- `warehouse_name` has inconsistent capitalisation
- `last_restocked` uses two date formats
- Some rows have `stock_level = null` (product not tracked at that warehouse)
- `supplier_name` is sometimes missing even when `supplier_id` exists

---

## Source B — Customer Support

HomeSphere logs every support ticket raised by customers. The raw export is a JSON
file with one object per ticket:

```json
{
  "ticket_id": "T0042",
  "customer_id": "C001",
  "product_id": "P003",
  "raised_at": "2024-01-18T09:14:00",
  "category": "device_fault",
  "priority": "HIGH",
  "resolved_at": "2024-01-19T14:30:00",
  "resolution": "Replacement dispatched"
}
```

Known issues in the raw data:
- `priority` has mixed case (`HIGH`, `high`, `High`)
- `resolved_at` is null for open tickets
- Some tickets have no `product_id` (general enquiries)
- `category` has free-text variations (`device_fault`, `Device Fault`, `fault - device`)

---

## Design questions

Work through these for your source:

**Bronze:**
- What does the raw file look like as-is?
- What would you name the bronze folder / file?

**Silver:**
- What cleaning is needed before this source is trustworthy?
- What validation checks would you add?
- What would you name the silver table?
- What columns does the silver table need?

**Gold:**
- What business questions could this source help answer?
- Which gold outputs would it feed into?
- Could it join to `silver_sales`? On what key?

**Awkward questions:**
- What makes this source harder to fit into the architecture than Sales?
- What assumptions would you need to make?
- What would you leave in silver rather than promoting to gold?

---

## Prepare to share

Be ready to explain:
1. Your silver table — what it contains and what was cleaned
2. One gold output your source enables
3. One thing that made this source awkward
