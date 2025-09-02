# **The Medallion → Streaming Connection:**

## **From Session 1 (Medallion) to Session 3 (Streaming):**

**Bridge Concept:** "Your medallion lakehouse is beautifully organized, but how does **new data flow into it**?"

## **The Flow Question:**

- **Bronze Layer:** How does raw data arrive? (batch files, streaming events, API calls)
- **Silver Layer:** How often do you refresh the cleaned data? (nightly batch, real-time updates)
- **Gold Layer:** How fresh do business dashboards need to be? (daily reports, live metrics)

## **Practical Example:**

*"Your bike-share company has a medallion architecture:*

- *Bronze: Raw sensor data from bike stations*
- *Silver: Clean location and availability data* 
- *Gold: Business metrics (popular routes, maintenance needs)*

*Question: Should bike availability updates be batch (hourly) or streaming (real-time)? What about route analytics?"*

## **The Transition Statement:**

*"Medallion architecture shows you **where** to put data. Data ingestion patterns show you **how fast** data flows through those layers. Let's explore when you need real-time vs batch processing."*

---

## **This Makes the Connection Clear:**
✅ Medallion = **data organization structure**
✅ Streaming = **data flow speed through that structure**  
✅ Both serve business needs but solve different problems
