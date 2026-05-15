# Facilitator Notes — Bridge to Day 4

*Trainer-only. Final 10 minutes of Day 3.*

---

## Summarise Day 3 in one sentence

> "The pipeline did not change what it produces — it changed how reliably and legibly it produces it."

---

## What they now have

- A pipeline with clear layers: bronze, silver, gold
- Validated silver tables that fail loudly if something is wrong
- A gold output that any analyst in the workspace can query with SQL
- A design they could hand to another engineer and explain

---

## What is still missing — set up Day 4

Ask: **"If this pipeline ran overnight and produced wrong numbers at 9am, how would you know?"**

The honest answer: they probably would not know until someone noticed.

There is no monitoring. No alerting. No documentation of what the pipeline does or why
decisions were made. No way for a new person to understand the intent without reading
every cell of every notebook.

> "Tomorrow is about making this pipeline something you can hand over, explain, and trust to run without you watching it."

Day 4 themes to name briefly:
- **Data quality checks** beyond basic assertions
- **Logging and observability** — knowing the pipeline ran and what it produced
- **Documentation** — writing down the why, not just the what
- **Handover** — could someone else support this pipeline on Monday morning?

---

## Close

> "Three days ago you had a messy CSV and a question. Today you have a documented, layered pipeline running in the cloud. Tomorrow we make it production-ready."
