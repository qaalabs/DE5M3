# Facilitator Notes - Technical vs Stakeholder View

## Frame the shift

Session 2 was about explaining the pipeline to another engineer - someone who understands layers, dependencies, and run order.

Session 3 is a different audience entirely.

> "Everything you documented this morning is for the person who maintains this. What comes next is for the person who uses it - and who decides whether to trust it."

---

## The core distinction

Ask: "What does a stakeholder care about that an engineer does not?"

Things to draw out:

- Not how it works - what it produces
- Not how it was built - whether to trust the number
- Not bronze and silver - what decision the output supports

Then:

> "A technical explanation and a stakeholder explanation are not the same thing. You are not dumbing it down. You are reframing it."

Give a concrete example:

| Technical | Stakeholder |
|-----------|-------------|
| "We assert that `product_id` has no nulls before saving to silver" | "Every sale in this report is matched to a product we actually sell" |
| "The join is left on `product_id`" | "We kept all sales records, even if a product detail was missing" |
| "Gold reads from silver, not bronze" | "The numbers come from cleaned, validated data - not the raw export" |

Same fact. Different frame.

---

## What makes a stakeholder trust a number?

Ask the group. Things to draw out:

- **Specificity** - "we checked X" is more credible than "the data is clean"
- **Honest caveats** - naming limitations builds trust; hiding them destroys it when they surface
- **Connection to something they already know** - if they have a rough sense of expected revenue, confirming the figure is in that range helps
- **A clear "so what"** - the number should connect to a decision, not just exist

---

## What makes a stakeholder sceptical?

- Jargon they cannot follow - it signals the explainer has not thought about the audience
- No limitations mentioned - no real pipeline is perfect; claiming otherwise raises flags
- "It's been validated" with no specifics - that phrase means nothing without detail
- No answer to "what do I do with this?"

---

## Bridge to PITCH-PREP

> "Your task is to explain `gold_revenue` to the HomeSphere Head of Sales. She does not care about notebooks or layers. She wants to know what this tells her and whether she can trust it. In your end point assessment you will need to explain a data product to a non-technical audience - this is the first time you are practising that."

