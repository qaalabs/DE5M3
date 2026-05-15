# Facilitator Notes — Module Retrospective

*Trainer-only. Final 20 minutes of Day 4 and the module.*

---

## Make the journey visible

Put the four-day arc on screen or say it clearly:

> "Day 1 — you had a messy CSV and a question. You made the logic work.
> Day 2 — you moved it into the cloud. Same logic, new environment.
> Day 3 — you gave it structure. Same output, better architecture.
> Day 4 — you made it supportable. Same pipeline, now someone else can own it."

The business output has not changed since Day 1. What changed is how reliably and legibly it produces that output, and how much of you it requires to keep running.

---

## Ask the group

**"What would you do differently if you started the pipeline again today?"**

This is the most important question. Things to draw out:

- "I would name the tables with the layer from the start" — yes, conventions compound
- "I would add row count checks from the first version" — yes, validation is easier to add early
- "I would plan the join key before building the sources" — yes, `customer_id` is a classic example
- "I would write down what the gold output is for before building it" — yes, the business question first

**"What have you learned about ETL beyond moving data?"**

Things to draw out:
- Structure prevents problems — a bronze layer you never modify is an insurance policy
- Naming is design — table names communicate architecture, not just content
- Documentation is for the next person — including your future self
- Validation is honesty — it turns assumptions into explicit claims

**"Where does this sit in the wider programme lifecycle?"**

This module is the **transform and load** phase of the data engineering lifecycle. What comes next in other modules:
- Source system integration — APIs, databases, streaming sources
- Orchestration — scheduling, dependencies, retries
- Governance — access control, data quality at scale, lineage

---

## Closing words

> "Three days ago — no, four days ago — you had a messy CSV and a question.
> Today you have a validated, layered pipeline running in the cloud, with documentation and checks, that you can explain to an engineer or a stakeholder.
> That is the middle of the data engineering lifecycle in action."

---

## Hand over to evaluation

Once the retrospective closes, move directly to the module evaluation.

Remind learners to be specific in their feedback — what worked, what could be clearer, what they would have wanted more or less of.

If there is time, ask: "What one thing would you tell next week's cohort to focus on?"
