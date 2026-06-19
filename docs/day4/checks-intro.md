# Facilitator Notes - Make It Safe to Run

## Session frame

Session 1 is the strongest practical of the day - give it room.

The arc:

1. Short whole-group setup (CHECKS-INTRO + SILENT-FAIL, ~20 min) - frame the problem, walk through 4 scenarios together
2. Demo one check live in the notebook (~5 min, start of CHECKS-BUILD)
3. Learners work through the notebook TODOs (~20 min)
4. Stretch: move checks into functions in a `.py` file (fast finishers)
5. Short debrief: what should happen when a check fails? (last ~5 min before break)

---

## Opening frame

Say:

> "A crash is honest. The pipeline stops. You know something went wrong. A silent failure is worse - the pipeline runs, produces output, and nobody raises an error. The report lands in someone's inbox and looks fine."

Then:

> "Session 1 is about making it safe to run. That means deciding what could go wrong, choosing what to check for, and making those failures visible."

---

## Walk through the scenarios

The four scenarios are on `silent-fail.md`. Walk through them together - do not send learners to read independently.

For each one, ask the group:

1. What went wrong?
2. What check would catch it?
3. Where in the pipeline should that check live - bronze, silver, or gold?

Keep this quick. Its job is to build shared vocabulary before the practical, not to generate a complete answer.

**What to listen for**

Good responses will name a layer and a specific check:

- "After the join, check whether any sales rows came back with a null product category"
- "Before cleaning, check the row count is above a minimum"

Redirect vague answers: "What would the output look like if that happened? Would anyone notice immediately?"

---

## Bridge to the demo

> "We know the pipeline can fail silently. Now let's put some checks in place. I'll show you the pattern in the notebook, then you continue from there."

Move directly into CHECKS-BUILD. Do not dwell here.
