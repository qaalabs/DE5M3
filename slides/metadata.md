---
title: Trusting Your Data
---

# You Received a File

```
sales_raw.csv
```

- Is this today's file or yesterday's?
- Are all the rows there?
- Which system did it come from?
- Has anyone touched it since it was exported?

> "A CSV on its own cannot answer any of these questions."

Notes: Let the silence sit after the question. They will recognise this problem from their own workplaces. The point is not that CSVs are bad - it's that a bare file carries no context.

---

# Wrap It

```
homesphere_sales_20260530_083200.zip
  sales_raw.csv
  metadata.json
```

The filename already tells you when it was created. The metadata tells you everything else.

Notes: Open the zip live and show both files. The filename convention (source_date_time) is itself a form of metadata - worth pointing out.

---

# What the Metadata Tells You

```json
{
  "source_system": "HomeSphere CRM",
  "extracted_at": "2026-05-30T08:32:00Z",
  "record_count": 30,
  "sha256": "2a0ed3e36...",
  "columns": ["order_id", "order_date", ...]
}
```

- You know where it came from
- You know when it was extracted
- You can check the row count before you process it
- The checksum tells you if the file was modified

Notes: The sha256 is the most powerful thing here - if the file changes after export, the hash won't match. You can catch corruption or tampering before it enters your pipeline.

---

# How Do You Do This at Work?

<p class="fragment"><mark>❓ Does your team have a way of knowing if a file is fresh, complete, or from the right source?</mark></p>

Notes: Give them 30 seconds to think, then take 2-3 answers. Common responses: "we just trust it", "we check the date on the filename", "we have a log somewhere." All of these are worth acknowledging - the point is that ad-hoc approaches break under pressure.
