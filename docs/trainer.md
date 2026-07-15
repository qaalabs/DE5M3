# Trainer Notes

## Day 1 - ETL Locally

### Session 1

- `10:10` **Activity**: [Git Clone the Data Files](labs/11-setup.md) (10 mins)
- `10:20` **Practice**: Explore Python-101 Notebook (10 mins)

### Session 2

- `10:50` **Reading**: [Introducing HomeSphere](day1/homesphere.md) (10 mins)
- `11:00` **Practice**: [Part 1: Inspect Sales Data](day1/inspect-sales.md) (10 mins)
- `11:10` **Practice**: [Part 2: Inspect Product Data](day1/inspect-prod.md) (10 mins)
- `11:20` **Discussion**: [What Did You Find?](day1/inspect-debrief.md) (10 mins)
- `11:30` [Cleaning Moves Overview](day1/clean-intro.md) (10 mins)
- `11:40` **Practice**: [Part 3: Clean Sales Data](day1/clean-sales.md) (40 mins)

### Session 3

- `13:20` **Discussion**: [Mechanical or Judgement?](day1/clean-debrief.md) (10 mins)
- `13:30` **Slides**: [Why Flatten and Join?](day1/flatten-intro.md) (10 mins)
- `13:40` **Practice**: [Flatten and Join](day1/flatten-join.md) (30 mins)
- `14:10` **Practice**: [ETL Pipeline ~ Stretch Task](day1/stretch-etl-script.md) (10 mins)
- `14:20` **Practice**: Which Categories Earn Most? (10 mins)

### Session 4

- `14:50` **Breakout**: ETL Product Investigation (10 mins)
- `15:00` **Investigation**: [ETL Product Investigation](day1/etl-products.md) (20 mins)
- `15:20` **Report-Back**: ETL Product Investigation (20 mins)
- `15:40` **Discussion**: [Reflect and Look Ahead](day1/reflection.md) (10 mins)

---

## Day 2 - ETL in the Cloud

### Session 1

- `09:40` 🖥️ Start MS Fabric Playground (10 mins)
- `09:50` What Is Fabric? (10 mins)
- `10:00` **Practice**: [Lab 2.1 - Explore Fabric Environment](labs/21-lakehouse.md) (30 mins)
- `10:30` **Discussion**: What Stays the Same? (10 mins)

### Session 2

- `11:00` **Practice**: [Lab 2.2 - Landing Raw Data](labs/22-land-data.md) (10 mins)
- `11:10` **Practice**: [Lab 2.3 - Clean the Sales Data](labs/23-cloud-clean.md) (20 mins)
- `11:30` **Discussion**: [Familiar vs Different?](day2/cloud-debrief.md) (10 mins)
- `11:40` **Breakout**: [Choosing a Data Architecture](day2/architecture-investigation.md) (20 mins)
- `12:00` **Report-Back**: [Choosing a Data Architecture](day2/architecture-notes.md) (20 mins)

### Session 3

- `13:20` **Practice**: [Lab 2.4 - Setup Fabric](labs/24-pm-setup.md) (10 mins)
- `13:30` **Practice**: [Lab 2.5 - Build the Trusted Output](labs/25-cloud-output.md) (20 mins)
- `13:50` **Discussion**: [What Is Better? What Is Fragile?](day2/output-debrief.md) (10 mins)
- `14:00` **Practice**: [Lab 2.6 - Create ETL Pipeline](labs/26-etl-pipeline.md) (30 mins)

### Session 4

- `14:50` Security, Scalability, Governance, Cost (10 mins)
- `15:00` **Breakout**: [Local vs Cloud](day2/compare.md) (20 mins)
- `15:20` **Report-Back**: Share Your Comparison (10 mins)
- `15:30` **Discussion**: [Cloud Is Not Well-Architected](day2/reflection.md) (20 mins)

---

## Day 3 - Robust & Well-Architectured

### Session 1

- `09:40` **Slides**: [Design Review](day3/review.md) (10 mins)
- `09:50` **Slides**: [Solution: Add Metadata to a CSV File](day3/csv-metadata.md) (10 mins)
- `10:00` **Slides**: Solution: Get Data From an API (10 mins)
- `10:10` **Practice**: Swagger: Read from a Live API (30 mins)

### Session 2

- `11:00` **Breakout**: [Where are the Weaknesses?](day3/fragile.md) (20 mins)
- `11:20` **Report-Back**: Our Design Debts (10 mins)
- `11:30` **Slides**: Medallion: Bronze - Silver - Gold (20 mins)
- `11:50` **Practice**: [Map the Pipeline](day3/med-map.md) (10 mins)
- `12:00` **Discussion**: [What Needs to Move?](day3/med-debrief.md) (20 mins)

### Session 3

- `13:20` **Activity**: [Lab 3.1 - Setup Fabric](labs/31-setup.md) (10 mins)
- `13:30` **Practice**: [Lab 3.2 - Medallion Architecture](labs/32-medallion-lab.md) (40 mins)
- `14:10` **Discussion**: [What Is Actually Better?](day3/debrief.md) (20 mins)

### Session 4

- `14:50` **Breakout**: Medallion Scenarios (10 mins)
- `15:00` **Investigation**: [Medallion Scenarios](day3/medallion-scenarios.md) (20 mins)
- `15:20` **Report-Back**: Medallion Scenarios (20 mins)
- `15:40` **Discussion**: [Bridge to Day 4](day3/bridge.md) (10 mins)

---

## Day 4 - Supportable & Explainable

### Session 1

- `09:40` [Can You Trust Your Pipeline?](day4/checks-intro.md) (10 mins)
- `09:50` **Discussion**: [Silent Failures](day4/silent-fail.md) (10 mins)
- `10:00` **Practice**: [Add Validation Checks](day4/checks-build.md) (30 mins)

### Session 2

- `10:50` [Minimum Viable Documentation](day4/mvd-intro.md) (10 mins)
- `11:00` **Practice**: [Create a Handover Artefact](day4/mvd-build.md) (40 mins)
- `11:40` **Breakout**: [Learners Share Their Artefact](day4/mvd-review.md) (30 mins)

### Session 3

- `13:20` **Breakout**: [Learners Share Their Artefact](day4/mvd-review.md) (10 mins)
- `13:30` [Technical vs Stakeholder View](day4/stakeholder.md) (10 mins)
- `13:40` **Breakout**: [Prepare Your Explanation](day4/pitch-prep.md) (20 mins)
- `14:00` **Report-Back**: Share Your Explanation (20 mins)
- `14:20` **Discussion**: [What Made the Difference?](day4/pitch-debrief.md) (10 mins)

### Session 4

- `14:50` New Requirements Arrive (10 mins)
- `15:00` **Breakout**: [Evaluate New Change Request](day4/change-respond.md) (20 mins)
- `15:20` **Report-Back**: [Evaluate New Change Request](day4/change-debrief.md) (20 mins)
- `15:40` **Slides**: 🎁 Wrap (10 mins)

---
