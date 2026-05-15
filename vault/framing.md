Last updated: 15 May 2026

# Module 3 - Lifecycle Framing (Internal Note)

## Programme Lifecycle Map

The seven modules follow the natural arc of a data engineering career.

| Module | Focus | Lifecycle Position |
|--------|-------|--------------------|
| Module 1 | Fundamentals | Context and foundations across all stages |
| Module 2 | Storage and Management | Storage undercurrent - where data lives |
| Module 3 | Processing, Transformation and ETL | Ingestion and Transformation - the middle of the lifecycle |
| Module 4 | Planning a Data Engineering Product | Architecture and design undercurrents |
| Module 5 | Data Engineering Product Development | Build undercurrents - implementing towards serving |
| Module 6 | Data Operations | DataOps undercurrent - operating what serves consumers |
| Module 7 | Emerging Technologies | Future directions across all lifecycle stages |

The underlying lifecycle (Reis & Housley) runs:

**Generation → Ingestion → Transformation → Serving**

With undercurrents beneath all stages: security, data management, DataOps, orchestration, architecture, and software engineering.

Module 3 is the only module that sits directly on the main pipeline of the lifecycle. All other modules address either context, undercurrents, or the product lifecycle that wraps around it.

---

## Where Module 3 Sits

Module 3 owns **Ingestion** and **Transformation**.

- Generation is upstream of data engineers and is out of scope
- Storage is covered in Module 2 as an undercurrent, not as a lifecycle stage
- Serving is approached but not owned - the Gold layer output is ready to serve, but what consumes it belongs to Modules 4, 5, and 6
- DataOps undercurrents (monitoring, incident response, troubleshooting) belong to Module 6

---

## The Boundary of Module 3

**What Module 3 owns:**

- Extracting data from sources - files, APIs, databases
- Identifying and resolving data quality issues
- Transforming and integrating data from multiple sources
- Structuring pipelines using recognised patterns - batch, incremental, medallion architecture
- Moving pipelines into cloud-based environments
- Making pipelines understandable and supportable

**What Module 3 does not own:**

- How data is stored and modelled (Module 2)
- How data products are planned and designed (Module 4)
- How data products are built and tested at scale (Module 5)
- Monitoring, incident response, and pipeline operations (Module 6)
- Serving data to end consumers - analysts, dashboards, ML models (Modules 4-6)

This boundary is a design decision, not a gap. The module does not try to teach the whole lifecycle - only the part it owns.

---

## The 4-Day Live Arc - HomeSphere Pipeline

Learners build one evolving pipeline across the four days. The same scenario and core data keep the thread together. The pipeline does not restart - it develops.

| Day | Theme | What changes |
|-----|-------|--------------|
| Day 1 | Make it work | Learners extract, clean, and join raw Sales and Product data locally. The output is a first trusted dataset. The point is to prove the pipeline logic. |
| Day 2 | Make it work in the cloud | The same data and the same business output move into Microsoft Fabric. The business problem does not change - the environment does. The day ends with a comparison between local and cloud. |
| Day 3 | Make it more robust and well-architected | Starting from the weaknesses identified on Day 2, learners refactor the pipeline into bronze, silver, and gold layers. Architecture has a reason to exist because it solves a real problem. |
| Day 4 | Make it supportable and explainable | The pipeline is working and well-structured. The question becomes whether someone who did not build it could run it, trust it, and explain its value. Learners add lightweight checks, documentation, and practise stakeholder explanation. |

**The arc in one line:**
Day 1 proves the logic. Day 2 proves it in the cloud. Day 3 improves the design. Day 4 makes it trustworthy and transferable.

