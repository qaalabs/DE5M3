# Facilitator Notes - Design Review

*Trainer-only. Opens Day 3, ~20 minutes before the breakout.*

---

## Purpose

Reposition the day before anything else.

> "Day 1 proved the logic. Day 2 proved it in the cloud. Today we ask whether that is enough."

This is not a new build day. It is a day where they judge what they have already built.

---

## Show the Day 2 pipeline

Put the structure on screen - either your own workspace or a diagram:

```
Files/
  data/
    sales_raw.csv
    products_raw.json

Tables/
  cleaned_sales
  sales_trusted
```

Two notebooks. No structure. No labels. No validation. Someone presses Run.

Ask: **"If you inherited this workspace on Monday morning, what would you need to know?"**

Let a few people answer. Do not correct or elaborate yet - just surface the discomfort.

---

## Frame the breakout

> "In a moment you are going to look at this pipeline as if you were reviewing it - not as the person who built it, but as the person who has to maintain it. Your job is to find the design debts."

Explain what a design debt is: something that works today but will cause problems at scale, over time, or with another person involved.

Then send them into the breakout with the `fragile.md` page.

---

## What to listen for during the breakout

Walk the room. Groups that are doing well will produce specific, named problems:

- "Raw and cleaned data are in the same folder"
- "There is no check that the join produced the right number of rows"
- "The table name `sales_trusted` does not tell you how it was built"

Groups that are drifting will produce vague observations ("it is messy", "hard to read").
Redirect them with: "What specifically would confuse a new engineer?"
