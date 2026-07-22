# Facilitator Notes - What Is Better? What Is Fragile?

*Trainer-only. Run after CLOUD-OUTPUT.*
*Aim: 20 minutes - this one has more to unpack.*

---

## Ask the group

**"What can you do with the Delta table that you could not do with the CSV?"**

Things to draw out:

- **SQL endpoint** - any analyst in the workspace can query it without touching Python
- **Versioning** - Delta tables keep a transaction log; you can time-travel to previous versions
- **Shared access** - the output lives in OneLake, not on one person's VM
- **Live** - re-run the notebook and the table updates; anyone querying it gets the latest data

---

## Ask the group

**"What is still fragile about this pipeline?"**

This is the more important question - it sets up Day 3.

Things to draw out:

- **No structure** - bronze/silver/gold are all mixed together in one lakehouse, one notebook
- **No reusability** - if someone else wanted to use just the cleaned Sales data, there is no clean boundary
- **Manual trigger** - someone has to run the notebook; nothing is automated
- **No schema enforcement** - if `sales_raw.csv` changes structure, the pipeline silently produces wrong output
- **Hard to debug** - one notebook does everything; if something breaks mid-run it is hard to isolate

---

## Key point to make

> "The pipeline works. The output is better than a CSV on a VM. But it is not yet engineered - it is a notebook someone runs by hand. Day 3 is about turning this into something with structure."

Introduce the idea of **medallion architecture** here, briefly - bronze (raw), silver (cleaned), gold (trusted output). Do not explain it fully yet. Just name it and say that is Day 3's job.

---

## If the SQL endpoint question came up

Someone may have noticed that running the same revenue query in SQL felt more natural than `groupby` in Python. This is worth acknowledging:

> "SQL is the right tool for aggregation questions. Python is the right tool for complex transformation. Both live in the same environment now - that is the point of Fabric."

---

## Bridge to the next session

The next lab builds the ETL pipeline itself - orchestrating today's notebooks so they run in sequence rather than by hand. The fragility conversation feeds directly into that: yes, the cloud version is better, but it is not well-architected yet.
