# DE5 Module 3 - Day 2 Summary
*Handoff note for Day 3 planning session*

---

## Final Day 2 Schedule

```
09:20  Day 2 - Work in the Cloud (open)
09:30  Welcome to Day 2 of DE5 Module 3 (welcome)
09:40  VM Setup + Start Fabric Playground
09:50  What Is Fabric? (slides)
10:00  Lab 2.1 - Fabric Lakehouse (practice)
10:30  What Stays the Same? (discussion)
10:40  Morning Break
10:50  Lab 2.2 - Land HomeSphere Data (setup)
11:00  Lab 2.3 - Clean the Sales Data (practice)
11:20  Familiar vs Different? (discussion)
11:30  Choosing a Data Architecture (investigation)
12:00  Choosing a Data Architecture (report-back)
12:20  Lunch
13:20  Lab 2.4 - Build the Trusted Output (practice)
13:40  What Is Better? What Is Fragile? (discussion)
13:50  Lab 2.5 - Create ETL Pipeline (practice)
14:30  Afternoon Break
14:50  Does Succeeded Mean Correct? (content)
15:00  Rerun the Pipeline - Labs 2.7-2.9 (practice)
15:20  Share What You Found (report-back)
15:30  Cloud Is Not Well-Architected (discussion)
15:50  Wrap
16:00  End of Day 2
```

---

## Artefacts

| Artefact | Purpose | Status |
|----------|---------|--------|
| Slides - What Is Fabric? | Intro to Fabric concepts | Ready |
| `labs/21-lakehouse.md` | Lab 2.1 - orientation lab, generic Microsoft data | Ready, tested - includes Step 7 notebook query (pandas), Step 8 SQL, Step 9 visual query |
| `labs/22-land-data.md` | Setup - upload csv, json, notebook to lakehouse | Ready - used as Lab 2.2 setup, ~10 mins |
| `cloud_clean.ipynb` | Lab 2.3 learner notebook - clean Sales in Fabric | Ready, tested |
| `cloud_clean_solution.ipynb` | Lab 2.3 solution | Ready, tested |
| `cloud-clean.md` | Lab 2.3 learner handout | Ready |
| `cloud-debrief.md` | Facilitator notes - Familiar vs Different? | Ready |
| `architecture-investigation.md` | Investigation - Choosing a Data Architecture | Ready - updated to HomeSphere scenario |
| `cloud_output.ipynb` | Lab 2.4 learner notebook - trusted output | Ready, tested |
| `cloud_output_solution.ipynb` | Lab 2.4 solution | Ready, tested |
| `cloud-output.md` | Lab 2.4 learner handout | Ready |
| `output-debrief.md` | Facilitator notes - What Is Better? What Is Fragile? | Ready |
| `labs/25-etl-pipeline.md` | Lab 2.5 - wire solution notebooks into a pipeline | Ready, tested |
| COMPARE-INTRO trainer note | Reframed as "Does Succeeded mean correct?" - K13 no longer anchored here | Superseded - K13 moved to Day 3 `fragile.md` |
| `compare.md` | Local vs Cloud breakout framework | Superseded by Labs 2.7-2.9 |
| `labs/27-rerun-pipeline.md` | Lab 2.7 - baseline record, then rerun with `sales_raw_batch27.csv` (new batch, one row silently dropped) | Ready |
| `labs/28-schema-drift.md` | Lab 2.8 - rerun with `sales_raw_batch28.csv` (`unit_price` renamed to `price`); whole batch silently vanishes, pipeline still succeeds | Ready |
| `labs/29-pipeline-failure.md` | Lab 2.9 - rerun with `sales_raw_batch29.csv` (ragged CSV row); pipeline actually fails. Workspace cleanup step now lives here instead of Lab 2.6 | Ready |
| `day2-reflection.md` | Facilitator notes - Cloud Is Not Well-Architected | Ready |
| `sales_raw.csv` | Raw Sales data | Verified |
| `products_raw.json` | Raw Product catalogue | Verified |

---

## Key Design Decisions

- **Lab 2.1 uses generic Microsoft data** - deliberate. Learners orient themselves in Fabric without the cognitive load of reconnecting to HomeSphere at the same time. Three query approaches shown: notebook (pandas), SQL endpoint, visual query.
- **Lab 2.2 is a setup step, not a lab** - after Lab 2.1 learners already know the Lakehouse Explorer. Landing HomeSphere data is just upload csv, json, and notebook. ~10 minutes.
- **Labs 2.3 and 2.4 are fast** - ~20 minutes each. The logic is identical to Day 1. Speed is the point - the environment changed, the skills did not.
- **Lab 2.5 uses solution notebooks** - `cloud_clean_solution.ipynb` and `cloud_output_solution.ipynb` are wired into the pipeline. Avoids broken notebooks causing pipeline failures.
- **Architecture investigation uses HomeSphere** - updated from generic retail scenario. Three groups: Data Warehouse, Data Lake, Data Lakehouse.
- **No Dataflows Gen2 lab** - considered but dropped. Pipeline (Lab 2.5) introduces orchestration, which is a genuinely new concept. Dataflows would have been a third pass at transformation.
- **Session 4 reworked as a rerun sequence (Labs 2.7-2.9)** - replaces the K13 local-vs-cloud comparison. Learners rerun the same Lab 2.6 pipeline three times: a new batch (one row silently dropped), a renamed column (whole batch silently dropped, still Succeeded), then a ragged CSV row (pipeline actually fails). `cloud_clean_solution.ipynb` was changed to glob over `Files/data/sales_raw*.csv` instead of a single hardcoded filename - backward-compatible, so Lab 2.3's exercise notebook and Day 1 are unaffected. Data files are named to match the lab that uses them (`sales_raw_batch27/28/29.csv`).

---

## Timing Notes

- Fabric playground takes ~5 minutes to start - begin at 09:40 not 09:50
- Playground runs 3 hours with hard stop - morning session ends at lunch, new instance needed after
- Labs 2.3 and 2.4 are faster than the schedule slots suggest - absorb into debrief time
- Lab 2.5 (pipeline) is the longest afternoon lab at ~40 minutes

---

## Fixes Needed Before Delivery

1. **Day 1 wrap** - add explicit instruction for learners to save/download their Day 1 notebooks before the VM is lost overnight. They need them as reference for "the same nine fixes as Day 1."
2. **architecture-investigation.md** - confirm the HomeSphere scenario update is saved to the correct location in mkdocs.
3. **output-debrief.md** - written for 20 minutes but scheduled for 10. Run selectively - pick the two or three questions most relevant to what learners said during Lab 2.4.

---

## What Day 3 Needs to Pick Up

Day 3 theme: *Make it more robust and well-architected* - same HomeSphere pipeline, refactored into medallion architecture (bronze, silver, gold).

Day 3 is already partially planned. The medallion architecture lab (~45 minutes) exists. The day needs:
- A full schedule review against the same process used for Days 1 and 2
- Confirmation of what artefacts exist and what needs building
- The Fabric Eventstream lab (Lab 09, real-time bike-share data, KQL) is a candidate for streaming ingestion content
- KSB S16 (unstructured data extraction) needs a home - likely the multi-source session on Day 3

**Already picked up:** K13 (security, scalability, compliance, cost) lost its Day 2 anchor when COMPARE-INTRO was reworked - it's now signposted in the `FRAGILE` breakout instead (`tutor/DE5M3D3/fragile.md` and `docs/day3/fragile.md`, new "On cost and risk" question set). `docs/day3/fragile.md` also now has real Day 2 evidence to reference (the batch that silently vanished in Lab 2.8), not just the hypothetical "what if sales_raw.csv arrived with a new column?" question.
