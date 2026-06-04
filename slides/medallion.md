---
title: Medallion Architecture
---

# Medallion Architecture

*A convention for organising data you can trust*

![alt text](assets/my-image.png)


---

# What is Medallion Architecture?

A way of organising data in layers - each layer more refined and trustworthy than the last.

- Raw data lands in one place
- Cleaned data lives somewhere else
- Business outputs are built from trusted sources

> "Not a technology. A discipline."

Notes: Keep this simple. One sentence per bullet. Let it land before moving on. If anyone says they've seen this before, acknowledge it and say you'll go faster through the familiar parts.

---

# Why Do We Need It?

Without structure, pipelines grow like this:

- Raw and cleaned data mixed together
- No way to tell which tables are safe to query
- Debugging means reading every notebook
- Reuse is accidental, not designed

> "Sound familiar?"

Notes: This is the bridge from Session 1. They just named these problems themselves. Don't over-explain - just connect the dots. The question "sound familiar?" should get a reaction.

---

# The Three Layers

| Layer | Purpose |
|-------|---------|
| **Bronze** | Raw data, exactly as it arrived |
| **Silver** | Cleaned, validated, trustworthy |
| **Gold** | Business-facing output |

Each layer has one job. Each layer protects the one above it.

Note: Draw this on a whiteboard or annotate on screen if you can. The table is simple but the word "protects" is important - come back to it when you explain each layer.

---

# Bronze - Raw and Untouched

- Data lands here exactly as it arrived
- No modifications, ever
- If something goes wrong, you always have the original
- Think of it as your audit trail

> "Bronze is your safety net."

Note: Emphasise the word "ever." The whole value of bronze collapses if people start cleaning data there. A good question to ask: "What happens if you clean the raw file and the cleaning logic had a bug?"

---

# Silver - Cleaned and Trusted

- Raw data is cleaned, standardised, validated here
- Checks run before data is saved
- If validation fails, the pipeline stops loudly
- Anyone querying silver knows it has been verified

> "Silver is where trust is established."

Note: The key word is "loudly." Silent failures are worse than loud ones - you'd rather know immediately than find out when someone questions the numbers. The validation cells in the lab do exactly this.

---

# Gold - Business Ready

- Built from silver, never from bronze directly
- Answers a specific business question
- Aggregations, joins, metrics live here
- Safe for analysts to query without understanding the pipeline

> "Gold is where questions get answered."

Note: The "never from bronze directly" rule is important. If gold reads from bronze, you've bypassed all the cleaning and validation silver provides. Ask: "What would happen if gold read from bronze and the raw file changed format?"

---

# The Rules That Matter

Three rules that make medallion work:

1. **Bronze is read-only** - never modify raw data after it lands
2. **Silver is the trust boundary** - nothing reaches gold without passing through silver
3. **Gold reads from silver** - always, no exceptions

Break any of these and the architecture stops protecting you.

Note: These are the rules to keep coming back to during the lab. When learners are building, ask them to justify each decision against these three rules.

---

# Names Encode Meaning

| Day 2 name | What it tells you |
|------------|------------------|
| `cleaned_sales` | Something was cleaned. What? When? Which layer? |
| `sales_trusted` | Trusted by whom? Is this silver or gold? |

<hr>

| Day 3 name | What it tells you |
|------------|------------------|
| `silver_sales` | Cleaned and validated. Silver layer. |
| `gold_revenue` | Business output. Gold layer. |

> "A name is documentation."

Note: This is a small point but a real one. When someone inherits a pipeline at 9am on a Monday, the table names are the first thing they read. Names that encode the layer save time and reduce mistakes.

---

# Medallion is a Convention, Not a Technology

You can implement bronze/silver/gold in:

- Local files and folders
- Microsoft Fabric
- Databricks
- AWS S3
- Any data platform

What matters is the discipline - not the tool.

Note: This is important for the EPA. Learners need to be able to talk about medallion as an architectural decision, not just "something we did in Fabric." Ask: "Could you apply these same principles at work, whatever platform you use?"

---

# The HomeSphere Target

After today, the pipeline will look like this:

```text
Files/
   bronze/
      sales_raw.csv
      products_raw.json
Tables/
   silver_sales
   silver_products
   gold_revenue
```

Same data. Same business output. Better structure.

Note: This is the setup for med-map.md. Tell them: "In a moment you are going to map the Day 2 pipeline onto this structure before you build it. That is the next activity."

