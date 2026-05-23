# Facilitator Notes - What Made the Difference?

*Trainer-only. After PITCH-SHARE, before afternoon break.*
*Aim: 15 minutes.*

---

## After the share-back

Groups have just presented their stakeholder explanations. Now draw out what worked and what did not.

---

## Ask the group

**"What made you trust an explanation?"**

Things to draw out:
- Specific claims rather than vague reassurance - "we checked that every order has a valid product ID" vs "the data has been validated"
- Named limitations - an explanation that acknowledges caveats is more credible than one that claims perfection
- Plain language - explanations that avoided jargon were clearer, even when the underlying concept was technical
- Connection to a decision - "this tells you which product categories to focus marketing on" is more useful than "this shows revenue by category"

**"What made you sceptical?"**

Things to draw out:
- Unexplained jargon - "it's in a medallion architecture" means nothing to a stakeholder
- Blanket claims - "the data is clean and reliable" with no specifics
- Missing caveats - if there are no limitations, the stakeholder knows something is being hidden
- No answer to "so what?" - revenue numbers without a decision context are interesting but not useful

---

## Key point to make

> "A technical explanation and a stakeholder explanation are not the same thing. Technical: 'we validated row counts, dtypes, and referential integrity.' Stakeholder: 'we checked that every sale is matched to a product we actually sell.' Same fact, different frame."

The skill is translation - not simplification. You are not dumbing it down. You are reframing it in terms of what the listener cares about.

---

## Name the caveats clearly

A stakeholder explanation that is honest about limitations is more credible than one that is not.

Things the pipeline genuinely cannot guarantee:
- Whether the source file is complete - if the supplier sends a partial file, the pipeline cannot know
- Whether the product catalogue is up to date - if a product was added this week, it may not be in `silver_products`
- Historical data - the pipeline runs on today's file; it has no memory of previous runs

Naming these builds trust. It does not undermine confidence.

---

## Bridge to Session 4

> "You can now validate the pipeline, document it, and explain its value. The last thing to do is step back and ask: where does it go from here?"
