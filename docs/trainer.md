# Trainer Notes

## Day 1 - ETL Locally

### Session 1

- `09:30` **Slides**: 🌅 Welcome to Day 1 of DE5 Module 3 (10 mins)
- `10:00` **Activity**: [Git Clone the Data Files](labs/git-clone.md) (10 mins)
- `10:20` **Practice**: Explore Python-101 Notebook (20 mins)

### Session 2

- `11:00` **Reading**: [Introducing HomeSphere](day1/homesphere.md) (10 mins)
- `11:10` **Practice**: [Part 1 ~ Inspect Sales Data](day1/inspect-sales.md) (10 mins)
- `11:20` **Practice**: [Part 2 ~ Inspect Product Data](day1/inspect-prod.md) (10 mins)
- `11:30` **Discussion**: [What Did You Find?](day1/inspect-debrief.md) (10 mins)
- `11:40` [Cleaning Moves Overview](day1/clean-intro.md) (10 mins)
- `11:50` **Practice**: [Part 3 ~ Clean Sales Data](day1/clean-sales.md) (30 mins)

### Session 3

- `13:20` **Discussion**: [Mechanical or Judgement?](day1/clean-debrief.md) (10 mins)
- `13:30` **Slides**: [Why Flatten and Join?](day1/flatten-intro.md) (10 mins)
- `13:40` **Practice**: [Flatten and Join](day1/flatten-join.md) (30 mins)
- `14:10` **Practice**: [ETL Pipeline ~ Stretch Task](day1/stretch-etl-script.md) (10 mins)
- `14:20` **Practice**: Which Categories Earn Most? (10 mins)

### Session 4

- `14:50` **Instructions**: ETL Product Investigation (10 mins)
- `15:00` **Breakout**: [ETL Product Investigation](day1/etl-products.md) (20 mins)
- `15:20` **Report-Back**: ETL Product Investigation (20 mins)
- `15:40` **Discussion**: [Reflect and Look Ahead](day1/reflection.md) (10 mins)

---

## Day 2 - ETL in the Cloud

### Session 1

- `09:30` **Slides**: 🌅 Welcome to Day 2 of DE5 Module 3 (10 mins)
- `09:40` 🖥️ Start MS Fabric Playground (10 mins)
- `09:50` **Slides**: What Is Fabric? (10 mins)
- `10:00` **Practice**: [Lab 2.1 - Explore Fabric Environment](labs/21-lakehouse.md) (30 mins)
- `10:30` **Discussion**: What Stays the Same? (10 mins)

### Session 2

- `11:00` **Practice**: [Lab 2.2 - Landing Raw Data](labs/22-land-data.md) (10 mins)
- `11:10` **Practice**: [Lab 2.3 - Clean the Sales Data](labs/23-cloud-clean.md) (20 mins)
- `11:30` **Discussion**: [Familiar vs Different?](day2/cloud-debrief.md) (10 mins)
- `11:40` **Breakout**: [Choosing a Data Architecture](day2/architecture-investigation.md) (20 mins)
- `12:00` **Report-Back**: [Choosing a Data Architecture](day2/architecture-notes.md) (20 mins)

### Session 3

- `13:30` **Practice**: [Lab 2.4 - Build the Trusted Output](labs/24-cloud-output.md) (20 mins)
- `13:50` **Discussion**: [What Is Better? What Is Fragile?](day2/output-debrief.md) (10 mins)
- `14:00` **Practice**: [Lab 2.5 - Create ETL Pipeline](labs/25-etl-pipeline.md) (30 mins)

### Session 4

- `14:50` **Practice**: [Lab 2.6 - Rerun Pipeline](labs/26-rerun-pipeline.md) (20 mins)
- `15:10` **Practice**: [Lab 2.7 - Schema Drift](labs/27-schema-drift.md) (10 mins)
- `15:20` **Practice**: [Lab 2.8 - Pipeline Failure](labs/28-pipeline-failure.md) (20 mins)
- `15:40` **Discussion**: [Cloud Is Not Well-Architected](day2/reflection.md) (10 mins)

---

## Day 3 - Robust & Well-Architectured

### Session 1

- `09:30` **Slides**: 🌅 Welcome to Day 3 of DE5 Module 3 (10 mins)
- `09:40` **Demo**: [MERMAID](day3/mermaid-intro.md) (10 mins)
- `09:50` **Slides**: [Design Review](day3/review.md) (10 mins)
- `10:00` **Slides**: [Add Metadata to a CSV File](day3/csv-metadata.md) (10 mins)
- `10:10` **Slides**: [Swagger ~ Read from a Live API](day3/products-api.md) (10 mins)
- `10:20` **Practice**: [Swagger ~ Read from a Live API](day3/swagger-lab.md) (20 mins)

### Session 2

- `11:00` **Breakout**: [Where are the Weaknesses?](day3/fragile.md) (20 mins)
- `11:20` **Report-Back**: Our Design Debts (10 mins)
- `11:30` **Slides**: Medallion ~ Bronze - Silver - Gold (20 mins)
- `11:50` **Practice**: [Map the Pipeline](day3/medallion-mapping.md) (10 mins)
- `12:00` **Discussion**: [What Needs to Move?](day3/medallion-debrief.md) (20 mins)

### Session 3

- `13:20` [🖥️ Start MS Fabric Playground](day3/pipeline-diagram.md) (10 mins)
- `13:30` **Practice**: [Lab 3.1 - Medallion Architecture](labs/31-medallion-lab.md) (40 mins)
- `14:10` **Discussion**: [What Is Actually Better?](day3/debrief.md) (20 mins)

### Session 4

- `14:50` **Instructions**: Medallion Scenarios (10 mins)
- `15:00` **Breakout**: [Medallion Scenarios](day3/medallion-scenarios.md) (20 mins)
- `15:20` **Report-Back**: Medallion Scenarios (20 mins)
- `15:40` **Discussion**: [Bridge to Day 4](day3/bridge.md) (10 mins)

---

## Day 4 - Supportable & Explainable

### Session 1

- `09:30` **Slides**: 🌅 Welcome to Day 4 of DE5 Module 3 (10 mins)
- `09:40` [Can You Trust Your Pipeline?](day4/checks-intro.md) (10 mins)
- `09:50` **Discussion**: [Silent Failures](day4/silent-fail.md) (10 mins)
- `10:00` **Practice**: [Add Validation Checks](day4/checks-build.md) (20 mins)
- `10:20` [Run the Pipeline Locally](day4/pipeline-local.md) (20 mins)

### Session 2

- `11:00` [Minimum Viable Documentation](day4/mvd-intro.md) (10 mins)
- `11:10` **Practice**: [Create a Handover Artefact](day4/mvd-build.md) (40 mins)
- `11:50` **Report-Back**: [Learners Share Their Artefact](day4/mvd-review.md) (30 mins)

### Session 3

- `13:20` [Deploy a New Pipeline](day4/deploy-guide.md) (10 mins)
- `13:30` **Instructions**: CLOUD-SETUP (10 mins)
- `13:40` **Breakout**: [CLOUD-COMPARE](day4/cloud-compare.md) (20 mins)
- `14:00` **Report-Back**: CLOUD-SHARE (20 mins)
- `14:20` **Slides**: [Technical vs Stakeholder View](day4/stakeholder.md) (10 mins)

### Session 4

- `14:50` **Breakout**: [Prepare Your Explanation](day4/pitch-prep.md) (20 mins)
- `15:10` **Report-Back**: Share Your Explanation (20 mins)
- `15:30` **Discussion**: [What Made the Difference?](day4/pitch-debrief.md) (10 mins)
- `15:40` **Slides**: 🎁 Wrap (10 mins)

---
