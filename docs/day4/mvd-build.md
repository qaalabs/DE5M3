# Create a Handover Artefact

*Practice - Session 2. Individual.*
*Aim: 30 minutes.*

---

## The scenario

> You are going on leave on Friday. Someone else is supporting the HomeSphere pipeline from Monday morning.
> They have not seen it before. They are a competent data engineer.

Your task: produce the minimum documentation they would need to orientate themselves.

Not everything - the minimum. The thing that would save them an hour of confusion.

---

## What to include

A handover artefact should answer these questions for a new person:

**What does this pipeline do?**
One or two sentences. What business question does it answer?

**What are the sources?**
Where does the raw data come from? What format? How often does it arrive?

**What does each layer contain?**
Bronze, silver, gold - what is in each one, and what has been done to it?

**What runs first?**
The order matters. Which notebook runs before which?

**What is the final output for?**
Who uses `gold_revenue`? What decisions does it support?

**What are the known limitations?**
What is not checked? What could go wrong that the pipeline would not catch?

---

## Format - your choice

Pick the format that feels most useful for a new engineer:

**Option A - Structured table**

| Layer | Name | Contents | Notes |
|-------|------|----------|-------|
| Bronze | Files/bronze/ | Raw CSV and JSON | Never modified |
| Silver | silver_sales | Cleaned, validated sales | 23 rows after cleaning |
| Silver | silver_products | Flattened product catalogue | 9 products |
| Gold | gold_revenue | Revenue by product category | Built from silver only |

**Option B - Flow diagram (text)**

```
data/sales_raw.csv       → [bronze/sales_raw.csv]   →  silver_sales  ─┐
data/products_raw.json   → [bronze/products_raw.json] → silver_products ┘
                                                                        ↓
                                                               gold_revenue
```

**Option C - Structured note**

A short written document with headings: Overview, Sources, Layers, Run Order, Output, Caveats.

---

## What you are not trying to do

- Explain every cleaning step
- Document every column
- Describe every assert

Those belong in the code comments. The handover artefact explains what the pipeline does and how to navigate it - not how every line works.

---

## Produce your artefact

Use whichever format you chose. Aim for something you could hand to a colleague in a real job.

When done, you will swap it with someone else and review it.
