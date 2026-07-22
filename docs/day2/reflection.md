# Facilitator Notes - Cloud Is Not Well-Architected

## The setup

After the pipeline reruns (Labs 2.7-2.9), land this clearly:

> "The cloud version is better than the local version on almost every dimension you compared. But it is not well-architected. It is a pipeline someone runs by hand, with no structure, no separation of concerns, and no guarantee that it will produce the same output twice."

This is the pivot that makes Day 3 necessary.

---

## What to surface

**The raw data problem:**

The raw files are sitting in `Files/data/` alongside the cleaned output. There is no separation between what arrived and what was produced. If something goes wrong, it is hard to tell which version of the data you are looking at.

**The notebook problem:**

One notebook does everything. If the clean step fails halfway through, the Delta table might contain partial results. There is no checkpoint, no rollback, no audit trail.

**The manual trigger problem:**

Someone has to remember to run the notebook. If HomeSphere exports data every Monday morning, someone has to log in and press Run. That is not a pipeline - that is a chore.

**The naming problem:**

`cleaned_sales` and `sales_trusted` are reasonable names, but they are not a convention. A new person joining the project would not know what bronze, silver, and gold mean - because those concepts do not exist yet in this workspace.

---

## The question to ask

> "If you handed this workspace to a colleague on Friday afternoon and went on holiday, what would they need to know to run the pipeline on Monday?"

Let the group answer. The answer is usually: quite a lot, and none of it is written down anywhere.

That is what Day 3 fixes.

---

## Introduce medallion - briefly

Name it, do not explain it:

> "Tomorrow we give this structure. Bronze is raw - exactly what arrived. Silver is cleaned and trusted. Gold is the output built for a specific question. Three layers, clear boundaries, each one dependent on the last."

One sentence each. Leave them wanting to see it rather than fully understanding it tonight.

---

## Close Day 2

> "You built the same pipeline twice. Once locally, once in the cloud. The cloud version is better - but it is still a pipeline without architecture. Tomorrow we fix that."
