# Facilitator Notes — API Extraction Lab

*Trainer-only. Session 1, Day 3 — runs before the break. FRAGILE breakout follows.*

---

## Purpose

Introduce a new source requirement before the design critique begins. The product catalogue has moved from a static JSON file to a live API — learners update their pipeline to call it.

This is the first time the pipeline logic changes between days (Day 1 and Day 2 used the same code in different environments). The change is deliberate: the CSV still arrives as batch, the products now arrive on demand. That distinction — batch vs on-demand extraction — is what grounds KSB S4 in this module.

---

## Setup

Learners work individually, locally — same environment as Day 1. No Fabric, no OneLake. Just the notebook and a working Python environment.

The notebook is `day3/api/homesphere_api_todo.ipynb`. It is self-contained: narrative, Swagger exploration questions, the coding exercise, and two stretch tasks are all inside. The same narrative also exists as a learner-facing page - `swagger-lab.md` - for anyone who prefers to read it outside the notebook.

---

## Timing

| Phase | What learners do | Approx |
|---|---|---|
| Swagger exploration | Q1–Q6 in the browser, no code yet | 15 min |
| Core exercise | Write `extract_products_from_api()`, run the full pipeline | 15 min |
| Stretch 1 | Header authentication with `/product1` | fast finishers |
| Stretch 2 | Query parameter auth with `/product2` | fast finishers |

Close when the block ends regardless of where learners are. The stretch tasks exist to keep faster learners occupied -- not everyone needs to complete them.

---

## What to listen for

**During the Swagger phase** — learners who rush straight to the code skip the exploration questions. Worth a gentle prompt: "Before you write anything, what does the response actually look like?"

**During the coding phase** — the most common sticking point is the nested `specs` structure. If someone is stuck, ask: "What did `flatten_products()` do on Day 1? The structure is the same problem."

**On hardcoded keys (Stretch 1)** — the solution deliberately hardcodes the API key as a constant. This is intentional. The note in the notebook surfaces the problem and names the right patterns (env vars, secrets managers). You do not need to resolve it — just confirm that in production, the key would not live in the code.

---

## Closing the lab — transition to fragile breakout

Once most learners have a working pipeline, bring them back together before the break:

> "The product data is now live -- if a price changes, your pipeline picks it up automatically. That is one fragility fixed. After the break, you are going to name the rest."

The FRAGILE breakout picks this up after the break.
