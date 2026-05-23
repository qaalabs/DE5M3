# Where Could This Go Wrong?

*Discussion - Session 1. Work in small groups, then share with the room.*
*Aim: 20 minutes.*

---

## The question

> "If this pipeline ran overnight and produced wrong numbers at 9am - how would you know?"

You probably would not. Not immediately. Someone would have to notice the numbers looked off.

A **silent failure** is when the pipeline runs, produces output, and raises no errors - but the output is wrong.
That is worse than a crash, because a crash tells you something went wrong.

---

## Map the risks

Work through each layer. For each one, write down:

- What could go wrong here?
- Would the pipeline stop - or would it carry on and produce bad output?

| Layer | What could go wrong? | Silent or loud? |
|-------|---------------------|-----------------|
| Bronze - raw file lands | | |
| Bronze→Silver - cleaning | | |
| Silver - validated tables | | |
| Silver→Gold - join | | |
| Gold - final output | | |

---

## Prompts to get started

Things that could go wrong silently:

- The source file arrives with **fewer rows than expected** - a supplier dropped 200 records
- A **new product ID** appears that does not exist in the products table - it gets dropped in the join
- A date column **changes format** in the source - dates start parsing as NaT silently
- A column that should never be null **has nulls** - calculations produce NaN without warning
- A **duplicate order ID** slips through - revenue is double-counted
- A region name changes spelling - a filter downstream misses it

---

## Discuss

1. Which of these would your current pipeline catch?
2. Which would it miss?
3. Is there a pattern to what kinds of failures are caught vs missed?

---

## Prepare to share

Pick one silent failure your group thinks is the most dangerous. Be ready to explain:

- What would go wrong?
- At which layer?
- What would a user see - and how long before they noticed?
