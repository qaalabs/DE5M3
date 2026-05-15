# Facilitator Notes — Next Maturity Steps

*Trainer-only. Session 4, after afternoon break.*
*Aim: 15 minutes.*

---

## Frame it correctly

This is not a "things we did not have time for" section. It is about scope and honest ambition.

> "A real data pipeline is never finished. What you built this week is a foundation. What makes it more useful is adding sources that answer more questions."

---

## Introduce the two natural extensions

**IoT — Sensor and Device Data**

HomeSphere sells connected devices. Every thermostat, camera, and sensor generates event data: activations, temperature readings, motion detections, alerts.

This source would be:
- High volume — millions of events per day, not hundreds of rows
- Streaming — arriving continuously, not as a daily CSV
- Different structure — event log rather than transactional records

Ask: "How would bronze/silver/gold apply to a sensor stream?"

Key points:
- Bronze: raw event log, time-stamped, never modified
- Silver: device events joined to device registration (which customer owns this device?)
- Gold: usage patterns, fault rates, device health by product line

Ask: "Could `gold_revenue` join to sensor data? On what key?"
The answer: `product_id` — you could correlate sales volumes with fault rates. That is a genuinely interesting business question.

**Marketing — Customer Campaigns**

HomeSphere runs email and social campaigns. Marketing data would include:
- Which customers received which campaigns
- Open rates, click rates, conversion rates
- Campaign spend per channel

This source would join to sales on `customer_id` — which `sales_raw.csv` does not currently include.

Ask: "What does that mean for the current pipeline?"

Key point: the data we have does not support certain business questions. A more mature pipeline would capture `customer_id` at the sales stage so marketing data could join to it later. That is a design decision made (or missed) at source — not something you can fix in gold.

---

## What a more mature team would add

Without making this a wishlist, name a few realistic next steps:

- **Scheduling** — running the notebooks on a trigger (new file arrives) rather than manually
- **Run logging** — recording when the pipeline ran, how many rows processed, whether checks passed
- **Alerting** — notifying someone if a check fails, rather than just crashing
- **Schema enforcement** — defining the expected shape of silver tables so new code cannot accidentally break them

These are the things that turn a pipeline someone built into a pipeline a team can support.

---

## Close the discussion

> "None of these are things you lack the skill to build. They are things you now know to look for. That is the difference between a pipeline that exists and a pipeline that is owned."
