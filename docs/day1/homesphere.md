# HomeSphere

**HomeSphere** is a fictitious UK company that designs, sells, and supports smart home devices - thermostats, sensors, cameras, and smart plugs.

## The data problem

**HomeSphere** collects data across several systems: sales orders, product catalogue, customer support, IoT events, and app usage. Each system was built independently, and the data they produce is inconsistent and difficult to reuse. Fields are named differently across systems. Formats vary. Records contain errors and gaps. Nothing joins cleanly out of the box.

The data team's job is to take that raw source data, understand it, clean it, and combine it into something that can support reliable reporting and future data products.

That is what Module 3 is about.

## Data sources

| Source                | What it contains                          |
|-----------------------|-------------------------------------------|
| Sales Orders          | Customer orders, quantities, prices, dates|
| Product catalogue     | Product names, categories, specifications |
| Inventory / Supply    | Stock levels, supplier data               |
| Customer support      | Tickets, resolution times, issue types    |
| IoT events            | Device telemetry and usage signals        |
| Marketing / App usage | Campaign data, app engagement             |

## What we are building in Module 3

Across the four days you will build one evolving pipeline using HomeSphere data. It starts locally and develops into a structured, cloud-based, documented pipeline.

| Day   | Starting point                | Output                                                    |
|-------|-------------------------------|-----------------------------------------------------------|
| Day 1 | Raw Sales Orders and Product files | A trusted order-level dataset with product detail    |
| Day 2 | The same pipeline             | The same output, running in Microsoft Fabric              |
| Day 3 | A working but fragile pipeline| A refactored pipeline with bronze, silver, and gold layers|
| Day 4 | A well-structured pipeline    | A pipeline that is documented, checked, and explainable   |

## Day 1 sources

Today you are working with two sources:

**Sales Orders** ~ a flat file containing customer order records

- Each row represents a product ordered by a customer.
- The data contains quality issues you will need to find and fix.

**Products** ~ a JSON file exported from the product catalogue system.

- Each record describes a product.
- The data is semi-structured and contains nested fields.
- The nested fields must be flattened before the product data can be joined to the sales order data.

---

!!! success "By the end of the day:"
    - You will have joined these two sources into a single trusted dataset;
    - And used it to answer a simple business question.

