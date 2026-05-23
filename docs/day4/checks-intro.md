# Facilitator Notes - Trust and Validation

*Trainer-only. Opens Session 1 after the welcome.*
*Aim: 15–20 minutes before sending them into SILENT-FAIL.*

---

## Set up the session

Start with the holding question for the day:

> "What would it take for someone who did not build this pipeline to run it, trust it, and explain it to a stakeholder?"

Let that sit for a moment. Then:

> "Today is not about building new things. It is about making what you have built usable by other people - people who were not in the room when you built it."

---

## Restate where they are

Remind the group of the full journey:

- Day 1 - made the logic work, locally
- Day 2 - moved it into Fabric
- Day 3 - gave it structure and architecture
- Day 4 - make it trustworthy and explainable

The business output has not changed since Day 1. The pipeline now has a shape. Today is about what happens after that.

---

## Frame silent failures

Before sending them into SILENT-FAIL, introduce the concept briefly:

> "A crash is honest. The pipeline stops. You know something went wrong. A silent failure is worse - the pipeline runs, produces output, no one raises an error, and the numbers are wrong. The report lands in someone's inbox and looks fine."

Ask: "Can you think of an example of a silent failure - not just in data pipelines, but anywhere?"

Let two or three people answer. This builds intuition before they apply it to the pipeline.

---

## What to listen for in SILENT-FAIL

Good groups will produce specific, named failure modes:

- "If the source file has fewer rows, nothing would alert us"
- "If a new product ID appears that is not in the products table, it would be silently dropped"
- "If the date format changes, `to_datetime` would produce NaT silently"

Groups that are drifting will produce vague observations. Redirect with: "What would the output look like if that happened? Would anyone notice immediately?"

---

## Bridge to CHECKS-DESIGN

> "We know the pipeline can fail silently. The question is: which failures are worth writing code to catch - and where in the pipeline should those checks live?"

Send them into the checks design activity.

---

## Key point for the debrief

The hardest checks to write are the ones that require knowing what normal looks like. Row count, value ranges, expected revenue totals - these require baseline knowledge. A new pipeline has no baseline. That is a real problem worth naming:

> "Until you have run this pipeline a dozen times, you cannot write some of the most important checks. Monitoring accumulates context."
