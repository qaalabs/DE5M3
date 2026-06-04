## Lineage by design

What happens when you receive a file and something looks wrong?

Can you answer: *where did it come from, when, and has it changed?*

---

```
homesphere_sales_20260530_083200.zip
├── sales_raw.csv
└── metadata.json
```

The name tells you **what** and **when**. The metadata travels with the data.

---

```json
{
  "source_system": "HomeSphere CRM",
  "extracted_at": "2026-05-30T08:32:00Z",
  "record_count": 30,
  "sha256": "2a0ed3e3..."
}
```

One hash check tells you whether the file is exactly what was sent.
