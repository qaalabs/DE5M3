# Facilitator Notes — Lineage Bundle Demo

*Trainer-only. Day 3 — use after the fragile breakout to introduce a concrete fix.*

---

## Purpose

The fragile breakout surfaces design debts. One that often comes up is lineage: if a file arrives with bad data, can you trace it back to the source? This demo shows a simple pattern that answers that question — data and metadata bundled together so lineage always travels with the file.

---

## The artefact

`data/homesphere_sales_20260530_083200.zip` contains:

```
homesphere_sales_20260530_083200.zip
├── sales_raw.csv       ← the data, unchanged
└── metadata.json       ← what it is, where it came from, how to verify it
```

**`metadata.json`**

```json
{
  "file_name": "sales_raw.csv",
  "source_system": "HomeSphere CRM",
  "source_location": "crm.homesphere.internal/exports/sales",
  "extracted_at": "2026-05-30T08:32:00Z",
  "record_count": 30,
  "columns": ["order_id", "order_date", "customer_id", "product_id",
               "quantity", "unit_price", "status", "region"],
  "sha256": "2a0ed3e360f281ae5fcb9289a80b33d1c15ee483f96392c7d4dcb7c3e3c00299",
  "schema_version": "1.0",
  "bundle_name": "homesphere_sales_20260530_083200.zip"
}
```

**The zip name is the first line of provenance.** `homesphere_sales_20240130_083200` tells you source, dataset, date, and time before you open anything.

---

## What learners should take from this

Three questions the bronze layer should be able to answer for every file it holds:

1. **Where did it come from?** — `source_system` + `source_location`
2. **When was it extracted?** — `extracted_at`
3. **Is it unchanged?** — re-hash the CSV and compare against `sha256`

If the answer to any of these is "we don't know", the pipeline has a lineage gap.

---

## Python — unpacking and validating the bundle

Show this in a notebook cell or talk through it on screen:

```python
import hashlib
import zipfile
import json
import pandas as pd
from io import BytesIO

def load_sales_bundle(zip_path):
    with zipfile.ZipFile(zip_path) as z:
        metadata = json.loads(z.read("metadata.json"))
        raw_bytes = z.read("sales_raw.csv")

    actual_hash = hashlib.sha256(raw_bytes).hexdigest()
    if actual_hash != metadata["sha256"]:
        raise ValueError("Hash mismatch — file may be corrupt or tampered")

    df = pd.read_csv(BytesIO(raw_bytes))
    if len(df) != metadata["record_count"]:
        raise ValueError(f"Expected {metadata['record_count']} rows, got {len(df)}")

    print(f"Source:    {metadata['source_system']}")
    print(f"Extracted: {metadata['extracted_at']}")
    print(f"Records:   {metadata['record_count']} ✓")
    print(f"Hash:      verified ✓")

    return df, metadata

df, meta = load_sales_bundle("homesphere_sales_20260530_083200.zip")
```

Output:
```
Source:    HomeSphere CRM
Extracted: 2026-05-30T08:32:00Z
Records:   30 ✓
Hash:      verified ✓
```

---

## Where this fits in the day

Use it after the fragile share to pivot from *identifying* debts to *fixing* them:

> "You said you couldn't tell where a file came from or whether it had changed. Here's what it looks like when you design for that from the start. The zip name tells you when. The metadata tells you where. The hash tells you whether anything changed between extraction and processing. None of this required a new tool — just a deliberate bundle."

This sets up the medallion conversation naturally: if bronze is where raw data lands, it should land with enough context to be useful later.

---

## Teaching notes

- The hash is SHA-256 of the raw CSV bytes — not the parsed data. This means even a trailing newline difference would flag. That is deliberate and worth saying aloud.
- `schema_version` is a placeholder here, but in production it would point to a schema registry entry. You do not need to go into this unless someone asks.
- The pattern scales: the same approach works for JSON extracts, API response snapshots, or any file that arrives from an external system.
