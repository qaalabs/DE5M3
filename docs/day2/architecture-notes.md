# Trainer Notes - Data Architecture Activity

## Objective

Learners should understand that:
- there is no single “best” architecture
- architecture depends on **data type, use case, and transformation approach**
- **ETL vs ELT** is a key differentiator

---

## Expected Responses by Group

### Data Warehouse

**Problem it solves**
- Structured reporting
- Clean, consistent, trusted data

**ETL / ELT**
- ETL (transform before load)
- Schema-on-write

**Why it fits the scenario**
- Daily reporting requirements
- Structured sales data
- Strong for BI tools

**Where it struggles**
- Semi-structured / unstructured data (e.g. clickstream)
- Slower to adapt to new data sources
- Less flexible

**Key idea to listen for**
- Trades flexibility for reliability

---

### Data Lake

**Problem it solves**
- Storing large volumes of raw data
- Supporting diverse data types

**ETL / ELT**
- ELT (load first, transform later)
- Schema-on-read

**Why it fits the scenario**
- Handles clickstream data well
- Cost-effective storage
- Flexible for exploration

**Where it struggles**
- Data can become messy
- Harder to produce consistent reporting
- Not ideal for direct business use

**Key idea to listen for**
- Prioritises flexibility over structure

---

### Data Lakehouse

**Problem it solves**
- Combines flexibility and structure
- Supports both analytics and data science

**ETL / ELT**
- Hybrid approach
- Raw and curated layers

**Why it fits the scenario**
- Handles both structured and unstructured data
- Aligns with modern platforms (e.g. Fabric)
- Supports reporting and advanced analytics

**Where it struggles**
- More complex to manage
- Requires strong governance
- Risk of becoming disorganised

**Key idea to listen for**
- Aims to combine the best of both approaches

---

## Questions to Challenge Learners

Use these if discussion is shallow:

- What breaks first if data volume increases?
- Who would struggle to use this - business users or engineers?
- Where does transformation actually happen?
- Would this support real-time or near real-time data?
- What happens if data quality is poor?

---

## Key Teaching Moment

Ask:

> Would you actually choose just one architecture?

Expected direction:
- Combination approaches (e.g. lake + warehouse)
- Lakehouse as a modern pattern
- “It depends” based on business needs

---

## Common Weak Responses

Watch for:
- Focus only on storage (“it stores data in…”)
- Vague claims (“it is faster”, “it scales well”)
- No reference to the scenario
- No discussion of trade-offs

---

## What Strong Responses Look Like

Learners:
- Refer directly to the scenario
- Explain ETL vs ELT clearly
- Discuss trade-offs and limitations
- Justify decisions, not just describe

