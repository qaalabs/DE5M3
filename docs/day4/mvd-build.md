# Create a Handover Artefact

!!! abstract "K11: Data and information security standards, ethical practices, policies and procedures relevant to data management activities such as data lineage and metadata management."

**Aim: 40 minutes. Spend the first 5 choosing your format, the next 25 writing, the last 10 checking.**

---

## The scenario

> You are going on leave on Friday. Someone else is supporting the HomeSphere pipeline from Monday morning.
> They have not seen it before. They are a competent data engineer.

Your task: produce the minimum documentation they would need to orientate themselves.

Not everything - the minimum. The thing that would save them an hour of confusion.

Use the [HomeSphere pipeline diagram](pipeline-solution.md) as your reference throughout this activity.

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

| Layer  | Name            | Contents                    | Notes                  |
|--------|-----------------|-----------------------------|------------------------|
| Bronze | Files/bronze/   | Raw CSV and JSON            | Never modified         |
| Silver | silver_sales    | Cleaned, validated sales    | 23 rows after cleaning |
| Silver | silver_products | Flattened product catalogue | 9 products             |
| Gold   | gold_revenue    | Revenue by product category | Built from silver only |

**Option B - Flow diagram (text)**

```
data/sales_raw.csv       → [bronze/sales_raw.csv]     →  silver_sales  ─┐
data/products_raw.json   → [bronze/products_raw.json] → silver_products ┘
                                                               ↓
                                                         gold_revenue
```

**Option C - Structured note**

A short written document with headings.

*For example:*

1. Overview
2. Sources
3. Layers
4. Run Order
5. Output
6. Caveats

---

## What you are not trying to do

- Explain every cleaning step
- Document every column
- Describe every assert

Those belong in the code comments. The handover artefact explains what the pipeline does and how to navigate it - not how every line works.

---

## Produce your artefact

Use whichever format you chose. Aim for something you could hand to a colleague in a real job.

---

## Before you finish - check your own artefact

Read it back as if you are the engineer arriving Monday morning.

- ✅ Can you say in one sentence what the pipeline does?
- ✅ Do you know what to run first?
- ✅ Do you know where the gold output is and what it is for?
- ✅ Have you named at least one known limitation?
- ✅ Is there anything in there that belongs in the code rather than here?

If you answer no to any of the first four - go back and add it.

If you answer yes to the last one - remove it.

---

## If you finish early

Extend your artefact with a short "what would make this pipeline stronger" section.

Two or three bullet points. What would a more mature version of this pipeline include
that this one does not?

