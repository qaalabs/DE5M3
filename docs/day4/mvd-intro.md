# Facilitator Notes - Minimum Viable Documentation

*Trainer-only. Opens Session 2 after morning break.*

---

## Frame the shift

Session 1 was about making the pipeline trustworthy for the machine - checks that fail loudly.
Session 2 is about making it trustworthy for a person - documentation that orients quickly.

> "The pipeline checks are for Python. The documentation is for the engineer who picks this up on Monday morning."

---

## Introduce the idea

Ask: "If you inherited a pipeline with no documentation, what is the first thing you would want to know?"

Things to draw out:

- What does it produce?
- What order do things run in?
- Where does the input come from?
- What is the output used for?

Then:

> "That list - that is your minimum viable documentation. Not API docs, not line-by-line comments. Just the things a competent engineer needs to orientate themselves in the first 15 minutes."

---

## What minimum viable means

Be explicit about scope. The goal is not:

- Explaining every cleaning step
- Documenting every column
- Writing architecture decision records

The goal is: could a new engineer look at this artefact and understand the pipeline's purpose and flow in under 10 minutes?

If the answer is yes - that is enough.

---

## Name the three formats

Tell the group they can choose their format:

- **Table** - layer by layer, name, contents, notes
- **Flow diagram** (even ASCII) - source → layer → output, left to right
- **Structured note** - short prose with clear headings

All three work. The best artefact is the one that would genuinely help the next person.

---

## Bridge to MVD-BUILD

> "Imagine you are going on leave Friday. Someone else is covering from Monday. Produce the minimum they would need. Not everything - the minimum that saves them an hour of confusion."

Send them in.

---

## What to watch for during MVD-BUILD

Common gaps:
- No mention of run order (which notebook first)
- No description of what the gold output is actually for
- No caveats - the artefact implies the pipeline is perfect
- Over-documented - trying to explain the code rather than the flow

If you see over-documentation, redirect: "If you removed that section, would a new engineer still be able to orientate themselves? Yes? Then it probably belongs in the code, not here."
