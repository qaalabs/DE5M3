---
title: Medallion Architecture
---

# What is it?

A layered approach to organising data in a lakehouse.

Each layer has a clear purpose — raw, clean, ready.

Note:
Data lakehouses in Fabric are built on the Delta Lake format, which natively supports ACID (Atomicity, Consistency, Isolation, Durability) transactions. Within this framework, the medallion architecture is a recommended data design pattern used to organize data in a lakehouse logically. It aims to improve data quality as it moves through different layers. The architecture typically has three layers – bronze (raw), silver (validated), and gold (enriched), each representing higher data quality levels. Some people also call it a "multi-hop" architecture, meaning that data can move between layers as needed.
This architecture ensures that data is reliable and consistent as it goes through various checks and changes. It also guarantees that the data is safely stored in a way that makes it easier and faster to analyze.

---

# Bronze Layer

**Raw ingested data. No transformation.**

- Exact copy of the source
- Append-only
- The source of truth — you can always reprocess from here

Note:
The bronze or raw layer of the medallion architecture is the first layer of the lakehouse. It's the landing zone for all data, whether it's structured, semi-structured, or unstructured. The data is stored in its original format, and no changes are made to it.

---

# Silver Layer

**Cleaned and validated data.**

- Bad rows removed or flagged
- Schema enforced
- Joins and enrichment applied

Note:
The silver or validated layer is the second layer of the lakehouse. It's where you'll validate and refine your data. Typical activities in the silver layer include combining and merging data and enforcing data validation rules like removing nulls and deduplicating. The silver layer can be thought of as a central repository across an organization or team, where data is stored in a consistent format and can be accessed by multiple teams. In the silver layer you're cleaning your data enough so that everything is in one place and ready to be refined and modeled in the gold layer.

---

# Gold Layer

**Business-ready data.**

- Aggregated for reporting
- Optimised for query performance
- What analysts and dashboards read from

Note:
The gold or enriched layer is the third layer of the lakehouse. In the gold layer, data undergoes further refinement to align with specific business and analytics needs. This could involve aggregating data to a particular granularity, such as daily or hourly, or enriching it with external information. Once the data reaches the gold stage, it becomes ready for use by downstream teams, including analytics, data science, or MLOps.
