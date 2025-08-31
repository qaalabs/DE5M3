# **Day 4 Theme:** *Pipeline Design Patterns in Modern ETL*

## Welcome

### **9:30–9:40 — Welcome (10 mins)**

* Set the tone: “Today we move from ‘doing ETL’ to *designing pipelines* that work in real-world systems.”
* Learning outcomes:

  * Understand four common ETL pipeline patterns
  * Compare when to use them
  * Link each to tools, trade-offs, and real data engineering concerns

## Session 1

### **Session 1 (9:40–10:40) — Pattern 1: Medallion Architecture**

**Focus:** Trust zones, layering, progressive refinement
**Activity ideas:**

* Visual walkthrough of Bronze → Silver → Gold
* Learners map sample datasets (raw CSVs, lookup tables, cleansed outputs) to each layer
* Optionally run a notebook or SQL script that moves data from bronze to gold

## Morning Break

## Session 2

### **Session 2 (11:00–12:10) — Pattern 2: Incremental vs Full Load**

**Focus:** Efficiency, state, and idempotency
**Activity ideas:**

* Simulate batch + incremental loads using Jupyter/SQL with a “new rows only” strategy
* Discuss: how to track state? what happens on failure?
* Connect to real-world: daily syncs, CDC, file drops, etc.

## Lunch Break

## Session 3

### **Session 3 (13:20–14:30) — Pattern 3: Multi-source Integration**

**Focus:** Combining data from multiple systems or formats
**Activity ideas:**

* Show sample data with mismatched schemas (e.g. product codes + regions)
* Discuss joins, cleaning, handling nulls/missing keys
* Design: “What’s your pipeline shape for combining these?”

## Afternoon break

## Session 4

### **Session 4 (14:50–15:50) — Pattern 4: Orchestrated Pipelines**

**Focus:** Control flow, retries, monitoring
**Activity ideas:**

* Show or build a simple ADF pipeline (or diagram it)
* Explain concepts like parallelism, conditional steps, error handling
* Discuss: “What happens after I write the code?” → link to CI/CD briefly

## Wrap

### **Wrap-up (15:50–16:00)**

* Quick recap: name the 4 patterns + one key learning from each

* Pose reflective questions:

  * “Which pattern would you use in your workplace?”
  * “How does this relate to what you’ve seen in ADF / Fabric / SQL jobs?”

