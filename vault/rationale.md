Last updated: 15 May 2026

# Module 3 - Design Rationale

## What this module is for

Module 3 owns the middle of the data engineering lifecycle - Ingestion and Transformation. Everything before it (where data is stored, how it is modelled) belongs to Module 2. Everything after it (how data products are planned, built, operated, and served) belongs to Modules 4 through 6. This module does not try to teach the whole lifecycle. It teaches the part it owns, and teaches it well.

---

## The live event

The four-day live event follows one evolving pipeline built around a fictional property technology company called HomeSphere. The same scenario and the same core data run through all four days. The pipeline does not restart between days - it develops. By Day 4, learners have something that works, lives in the cloud, is properly structured, and can be understood and trusted by someone who did not build it.

This continuity is deliberate. It mirrors how data engineers actually work - not completing isolated exercises, but developing and improving a real system over time.

---

## The four-day arc

**Day 1 - Make it work**
Learners extract raw Sales and Product data, identify quality issues, clean and transform the data, and produce a first trusted output. The point of the day is to prove the pipeline logic and give learners a concrete sense of what it means to move from messy raw data to something useful.

**Day 2 - Make it work in the cloud**
The same data and the same business output move into Microsoft Fabric. The business problem does not change - the environment does. By the end of the day, learners have the same trusted dataset in a cloud-based workflow, and can articulate what improved and what still feels fragile.

**Day 3 - Make it more robust and well-architected**
The day starts from the weaknesses learners identified on Day 2. Rather than introducing architecture in the abstract, the session asks what is brittle about the current design. That leads naturally into bronze, silver, and gold layers as a response to real problems. Learners refactor the pipeline - they do not rebuild it from scratch.

**Day 4 - Make it supportable and explainable**
The final day asks what it would take for someone who did not build the pipeline to run it, trust it, and explain its value. Learners add lightweight checks, produce minimum viable documentation, and practise explaining the business output to a stakeholder without disappearing into technical detail.

---

## The arc in one line

Day 1 proves the logic. Day 2 proves it in the cloud. Day 3 improves the design. Day 4 makes it trustworthy and transferable.

