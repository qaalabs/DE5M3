# HomeSphere

HomeSphere is a UK company that designs, sells, and supports smart home devices — thermostats, sensors, cameras, and smart plugs.

## The data problem

HomeSphere collects data across several systems: sales orders, product catalogue, customer support, IoT events, and app usage. Each system was built independently, and the data they produce is inconsistent and difficult to reuse. Fields are named differently across systems. Formats vary. Records contain errors and gaps. Nothing joins cleanly out of the box.

The data team's job is to take that raw source data, understand it, clean it, and combine it into something that can support reliable reporting and future data products.

That is what Module 3 is about.

## Data sources

| Source | What it contains |
|--------|-----------------|
| Sales / Orders | Customer orders, quantities, prices, dates |
| Product catalogue | Product names, categories, specifications |
| Inventory / Supply | Stock levels, supplier data |
| Customer support | Tickets, resolution times, issue types |
| IoT events | Device telemetry and usage signals |
| Marketing / App usage | Campaign data, app engagement |

## What we are building in Module 3

Across the four days you will build one evolving pipeline using HomeSphere data. It starts locally and develops into a structured, cloud-based, documented pipeline.

| Day | Starting point | Output |
|-----|---------------|--------|
| Day 1 | Raw Sales and Product files | A trusted order-level dataset with product detail |
| Day 2 | The same pipeline | The same output, running in Microsoft Fabric |
| Day 3 | A working but fragile pipeline | A refactored pipeline with bronze, silver, and gold layers |
| Day 4 | A well-structured pipeline | A pipeline that is documented, checked, and explainable |

## Day 1 sources

Today you are working with two sources:

**Sales** — a flat file of orders. Each row is a line item from a customer order. The data contains quality issues you will need to find and fix.

**Product** — a JSON file from the product catalogue system. It is semi-structured, with nested fields that need flattening before they can be joined to Sales.

By the end of the day, you will have joined these two sources into a single trusted dataset and used it to answer a simple business question.
