# Trainer Notes

## Day 1 ~ ETL Locally

### Session 1

- `09:30` **Slides**: 🌅 Welcome to day 1 of module 3 (10 mins)
- `10:00` **Activity**: [Git clone the data files](labs/git-clone.md) (10 mins)
- `10:20` **Practice**: Explore Python-101 notebook (20 mins)

### Session 2

- `11:00` **Reading**: [Introducing HomeSphere](day1/homesphere.md) (10 mins)
- `11:10` **Practice**: [Part 1 - Inspect sales data](day1/inspect-sales.md) (10 mins)
- `11:20` **Practice**: [Part 2 - Inspect product data](day1/inspect-prod.md) (10 mins)
- `11:30` **Discussion**: [What did you find?](day1/inspect-debrief.md) (10 mins)
- `11:40` [Cleaning moves overview](day1/clean-intro.md) (10 mins)
- `11:50` **Practice**: [Part 3 - Clean sales data](day1/clean-sales.md) (30 mins)

### Session 3

- `13:20` **Discussion**: [Mechanical or judgement?](day1/clean-debrief.md) (10 mins)
- `13:30` **Slides**: [Why flatten and join?](day1/flatten-intro.md) (10 mins)
- `13:40` **Practice**: [Flatten and join](day1/flatten-join.md) (30 mins)
- `14:10` **Practice**: [ETL pipeline ~ Stretch task](day1/stretch-etl-script.md) (10 mins)
- `14:20` **Practice**: Which categories earn most? (10 mins)

### Session 4

- `14:50` **Instructions**: ETL product investigation (10 mins)
- `15:00` **Breakout**: [👥 ETL product investigation](day1/etl-products.md) (20 mins)
- `15:20` **Report-Back**: ETL product investigation (20 mins)
- `15:40` **Discussion**: [Reflect and look ahead](day1/reflection.md) (10 mins)

---

## Day 2 ~ ETL in the Cloud

### Session 1

- `09:30` **Slides**: 🌅 Welcome to day 2 of module 3 (10 mins)
- `09:40` **Setup**: 🖥️ Start MS Fabric playground (10 mins)
- `09:50` **Slides**: What is Fabric? (10 mins)
- `10:00` **Practice**: [Lab 2.1 - Explore Fabric environment](labs/21-lakehouse.md) (30 mins)
- `10:30` **Discussion**: What stays the same? (10 mins)

### Session 2

- `11:00` **Practice**: [Lab 2.2 - Landing raw data](labs/22-land-data.md) (10 mins)
- `11:10` **Practice**: [Lab 2.3 - Clean the sales data](labs/23-cloud-clean.md) (20 mins)
- `11:30` **Discussion**: [Familiar vs different?](day2/cloud-debrief.md) (10 mins)
- `11:40` **Breakout**: [👥 Choosing a data architecture](day2/architecture-investigation.md) (20 mins)
- `12:00` **Report-Back**: [Choosing a data architecture](day2/architecture-notes.md) (20 mins)

### Session 3

- `13:30` **Practice**: [Lab 2.4 - Build the trusted output](labs/24-cloud-output.md) (20 mins)
- `13:50` **Discussion**: [What is better? What is fragile?](day2/output-debrief.md) (10 mins)
- `14:00` **Practice**: [Lab 2.5 - Create ETL pipeline](labs/25-etl-pipeline.md) (30 mins)

### Session 4

- `14:50` **Practice**: [Lab 2.6 - Rerun pipeline](labs/26-rerun-pipeline.md) (20 mins)
- `15:10` **Practice**: [Lab 2.7 - Schema drift](labs/27-schema-drift.md) (10 mins)
- `15:20` **Practice**: [Lab 2.8 - Pipeline failure](labs/28-pipeline-failure.md) (20 mins)
- `15:40` **Discussion**: [Cloud is not well-architected](day2/reflection.md) (10 mins)

---

## Day 3 ~ Robust & Well-Architectured

### Session 1

- `09:30` **Slides**: 🌅 Welcome to day 3 of module 3 (10 mins)
- `09:40` **Demo**: [MERMAID](day3/mermaid-intro.md) (10 mins)
- `09:50` **Slides**: [Design review](day3/review.md) (10 mins)
- `10:00` **Slides**: [Add metadata to a CSV file](day3/csv-metadata.md) (10 mins)
- `10:10` **Slides**: [Swagger - Read from a live API](day3/products-api.md) (10 mins)
- `10:20` **Practice**: [Swagger - Read from a live API](day3/swagger-lab.md) (20 mins)

### Session 2

- `11:00` **Breakout**: [👥 Where are the weaknesses?](day3/fragile.md) (20 mins)
- `11:20` **Report-Back**: Our design debts (10 mins)
- `11:30` **Slides**: Medallion ~ Bronze - Silver - Gold (20 mins)
- `11:50` **Practice**: [Map the pipeline](day3/medallion-mapping.md) (10 mins)
- `12:00` **Discussion**: [What needs to move?](day3/medallion-debrief.md) (20 mins)

### Session 3

- `13:20` **Setup**: [🖥️ Start MS Fabric playground](day3/pipeline-diagram.md) (10 mins)
- `13:30` **Practice**: [Lab 3.1 - Medallion architecture](labs/31-medallion-lab.md) (40 mins)
- `14:10` **Discussion**: [What is actually better?](day3/debrief.md) (20 mins)

### Session 4

- `14:50` **Instructions**: Medallion scenarios (10 mins)
- `15:00` **Breakout**: [👥 Medallion scenarios](day3/medallion-scenarios.md) (20 mins)
- `15:20` **Report-Back**: Medallion scenarios (20 mins)
- `15:40` **Discussion**: [Bridge to Day 4](day3/bridge.md) (10 mins)

---

## Day 4 ~ Supportable & Explainable

### Session 1

- `09:30` **Slides**: 🌅 Welcome to day 4 of module 3 (10 mins)
- `09:40` [Can you trust your pipeline?](day4/checks-intro.md) (10 mins)
- `09:50` **Discussion**: [Silent failures](day4/silent-fail.md) (10 mins)
- `10:00` **Practice**: [Add validation checks](day4/checks-build.md) (20 mins)
- `10:20` [Run the pipeline locally](day4/pipeline-local.md) (20 mins)

### Session 2

- `11:00` [Minimum viable documentation](day4/mvd-intro.md) (10 mins)
- `11:10` **Practice**: [Create a handover artefact](day4/mvd-build.md) (40 mins)
- `11:50` **Report-Back**: [Learners share their artefact](day4/mvd-review.md) (30 mins)

### Session 3

- `13:20` [Deploy a new pipeline](day4/deploy-guide.md) (10 mins)
- `13:30` **Instructions**: Compare cloud platforms (10 mins)
- `13:40` **Breakout**: [👥 Compare cloud ETL platforms](day4/cloud-compare.md) (20 mins)
- `14:00` **Report-Back**: Pitch your platform (20 mins)
- `14:20` **Slides**: [Technical vs stakeholder view](day4/stakeholder.md) (10 mins)

### Session 4

- `14:50` **Breakout**: [👥 Prepare your explanation](day4/pitch-prep.md) (20 mins)
- `15:10` **Report-Back**: Share your explanation (20 mins)
- `15:30` **Discussion**: [What made the difference?](day4/pitch-debrief.md) (10 mins)
- `15:40` **Slides**: 🎁 Wrap (10 mins)
- `15:50` **Slides**: 💯 Evaluation (10 mins)

---
