# Trainer Notes

## Day 1 - ETL Locally

### Session 1

- `10:10` [Introduce HomeSphere scenario, show both raw sources, explain Day 1 finish line](day1/homesphere.md) (30 mins)

### Session 2

- `11:00` **Practice**: Open Sales data — inspect columns, types, missing values, duplicates (30 mins)
- `11:30` **Practice**: Open Product JSON — notice nested structure and difference from Sales (10 mins)
- `11:40` **Discussion**: What quality problems did you spot? What is different about Product? (20 mins)
- `12:00` Cleaning moves overview — nulls, types, duplicates, standardisation (20 mins)

### Session 3

- `13:20` **Practice**: Guided cleaning of Sales dataset — fix types, handle missing, remove duplicates, standardise (50 mins)
- `14:10` **Discussion**: Which fixes were mechanical? Which required judgement? (20 mins)

### Session 4

- `14:50` Why JSON needs flattening and why joining sources adds value (10 mins)
- `15:00` **Practice**: Flatten Product JSON, select needed fields, join to Sales, produce trusted dataset (30 mins)
- `15:30` **Practice**: Use trusted dataset to answer: which product categories generate the most revenue? (10 mins)
- `15:40` **Discussion**: What worked? What feels brittle? Pointer to Day 2 (10 mins)

---

## Day 2 - ETL in the Cloud

### Session 1

- `09:40` What Fabric is in this module — lakehouse, OneLake, anchored to where Day 1 steps now sit (20 mins)
- `10:00` **Investigation**: Explore the Fabric environment — find where raw files, cleaned tables, and joined output live (30 mins)
- `10:30` **Discussion**: What stays the same from Day 1? What is new? (10 mins)

### Session 2

- `11:00` Demo: landing raw files in the lakehouse, reusing transformation logic in a notebook (20 mins)
- `11:20` **Practice**: Upload Sales and Product, recreate cleaning and flatten steps in a Fabric notebook (50 mins)
- `12:10` **Discussion**: What felt familiar? What felt different? (10 mins)

### Session 3

- `13:20` **Practice**: Store cleaned tables, join, query in Fabric — answer the same business question as Day 1 (50 mins)
- `14:10` **Discussion**: What is better now? What is still fragile? (20 mins)

### Session 4

- `14:50` K13 lens: security, scalability, governance, cost (10 mins)
- `15:00` **Breakout**: Groups compare Day 1 local pipeline vs Day 2 Fabric pipeline (20 mins)
- `15:20` **Report-Back**: Share back findings from the comparison (10 mins)
- `15:30` **Discussion**: Why cloud does not equal well-architected — what needs fixing — bridge to Day 3 (20 mins)

---

## Day 3 - Robust & Well-Architectured

### Session 1

- `09:40` Show the Day 2 pipeline as it stands — frame the design review with concrete prompts (20 mins)
- `10:00` **Breakout**: Pairs surface weaknesses: where is raw/cleaned mixed? what is hardest to debug or reuse? (20 mins)
- `10:20` **Report-Back**: Build a visible list of design debts (20 mins)

### Session 2

- `11:00` [Introduce bronze/silver/gold as the direct response to the weaknesses just listed — anchor each layer to the HomeSphere pipeline](day3/medallion/group-scenarios.md) (30 mins)
- `11:30` **Practice**: Map the Day 2 pipeline onto B/S/G: what already exists, what is missing, what should move (30 mins)
- `12:00` **Discussion**: What needs to move? What is misplaced? (20 mins)

### Session 3

- `13:20` **Practice**: Restructure Day 2 setup into explicit layers — raw untouched, silver Sales, silver Product, gold output explicit, lightweight validation checks (50 mins)
- `14:10` **Discussion**: What is actually better now? Why does this design matter? What is easier to debug? (20 mins)

### Session 4

- `14:50` Introduce Inventory or Support as the extension source — frame the group design task (10 mins)
- `15:00` **Breakout**: Groups design B/S/G for their source: bronze, silver, validation, where it feeds gold (20 mins)
- `15:20` **Report-Back**: Groups share — surface where choices differed and why — not every source fits neatly (20 mins)
- `15:40` **Discussion**: Pipeline still answers the same question — design is clearer — tomorrow: trust, explanation, and handover (10 mins)

---

## Day 4 - Supportable & Explainable

### Session 1

- `09:40` **Discussion**: Where could this pipeline fail quietly? Map silent failure risks across each layer (20 mins)
- `10:00` **Practice**: Decide which checks matter at bronze to silver and silver to gold — essential vs nice-to-have (20 mins)
- `10:20` **Practice**: Add or sketch the checks into the pipeline (20 mins)

### Session 2

- `11:00` Minimum viable documentation: what a new engineer needs — sources, layers, dependencies, what the gold output is for (20 mins)
- `11:20` **Practice**: Create a lightweight handover artefact: diagram, table, or structured note showing source to silver to gold and what each is for (40 mins)
- `12:00` **Breakout**: Pairs review each other's artefact — would this genuinely help someone new orientate? what is missing? (20 mins)

### Session 3

- `13:20` Technical view vs stakeholder view — how to explain trust and caveats in plain language without disappearing into engineering detail (20 mins)
- `13:40` **Breakout**: Pairs prepare a short explanation of orders_with_detail for a manager who does not care about notebooks or bronze/silver/gold (20 mins)
- `14:00` **Report-Back**: Share explanations — what built trust? what confused the message? (20 mins)
- `14:20` **Discussion**: What made the difference between a clear and an unclear stakeholder explanation? (10 mins)

### Session 4

- `14:50` **Discussion**: IoT and Marketing as realistic next sources — what would a more mature HomeSphere pipeline include? what adds most value vs most complexity? (20 mins)
- `15:10` **Discussion**: Full arc Day 1 to Day 4 — what changed? what would you do differently? what have you learned about ETL beyond just moving data? where does this module sit in the wider programme lifecycle? (30 mins)

---
