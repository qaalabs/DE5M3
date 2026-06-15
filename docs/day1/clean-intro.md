# Facilitator Notes - Cleaning Moves Overview

## The approach to establish upfront

> "We fix one thing at a time and verify before moving on."

This is not just good practice for today - it is the habit that saves you when something breaks in production and you need to know exactly which step caused it.

Three principles to state clearly:

1. **One fix, one check.** Run the verification cell after each step before moving to the next.
2. **Some fixes are mechanical, some are decisions.** Know which is which and be explicit about it.
3. **Record what you dropped and why.** The data quality report at the end is not optional - it is the evidence trail.

---

## Live demo - strip the £ symbol

Do this in front of the group before they open their notebooks. It takes two minutes and sets the pattern for everything that follows.

```python
# Show the problem first
df['unit_price'].dtype      # object - not float
df['unit_price'].head()     # some have £, some don't

# The fix
df['unit_price'] = df['unit_price'].astype(str).str.replace('£', '', regex=False).astype(float)

# Verify
df['unit_price'].dtype      # float64
df['unit_price'].describe() # min/max look sensible
```

**Why this one first:** It is the most visually obvious - learners have already seen `£129.99` in the data. It also introduces the chain pattern (`.astype().str.replace().astype()`) that will feel familiar when they hit similar problems.

**What to point out:** The reason for `astype(str)` first - some rows already have a float value with no `£`, so we normalise everything to string before operating on it. Without that, mixed types cause errors.

---

## Hand over

> "You have nine problems to fix. The notebook walks you through them one at a time. The first one we just did together - work through the rest, run the check after each step, and we will debrief when you are done."
