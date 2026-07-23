# Facilitator Notes - Familiar vs Different?

*Trainer-only. Run after [Lab 2.3 - Clean the Sales Data](../labs/23-cloud-clean.md) - before lunch.*
*Aim: 10 minutes.*

---

## Ask the group

**"What was familiar? What was different?"**

Take answers from the room. Most will land on the right things without much prompting.

**What should be familiar:**
- All nine cleaning steps - identical pandas code
- The DataFrame operations - same methods, same logic
- The output shape - same columns, same row count

**What is different:**
- The file path - `/lakehouse/default/Files/data/` instead of a local path
- The output - a Delta table instead of a CSV
- The environment - Fabric notebook instead of Jupyter on the VM
- The last step - `spark.createDataFrame()` and `saveAsTable()` - new

---

## Key point to make

> "You did not learn new data skills today - you ran the same skills in a new environment. That is deliberate. The environment should feel almost invisible at this point."

This sets up the afternoon well. The afternoon session adds the one genuinely new thing: querying the output with SQL via the endpoint, and seeing what that enables.

---

## If someone asks about `spark`

Fabric notebooks have `spark` pre-injected - it is always available without importing. Under the hood, Fabric is running Apache Spark. That is why we needed `spark.createDataFrame()` to save as a Delta table - pandas alone cannot write to Delta. But they did not need to think about Spark to do the cleaning. That is the point.

---

## Bridge to the afternoon

> "This morning you landed data and ran the pipeline. This afternoon you build the trusted output - join, save, and then explore what you can do with a Delta table that you could not do with a CSV."
