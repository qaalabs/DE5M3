# Where Are the Weaknesses?

## Your task

Look at the Day 2 pipeline you built in Fabric. Not at whether it works - it does.
Look at whether it is well-designed.

In your group, work through the questions below. For each one, agree on a specific answer
and be ready to share it.

---

## The Day 2 pipeline - what exists

```
Files/
  data/
    sales_raw.csv
    products_raw.json

Tables/
  cleaned_sales      ← output of first notebook
  sales_trusted      ← output of second notebook
```

Two notebooks. One runs after the other. Someone presses Run each time.

---

## Questions to work through

**On structure:**
- Where does raw data live? Where does cleaned data live? Are they clearly separated?
- If you came back in a month, could you tell which files are inputs and which are outputs?
- If `sales_trusted` looked wrong, where would you start investigating?

**On reliability:**
- What happens if the first notebook fails halfway through? What is the state of `cleaned_sales`?
- What would happen if `sales_raw.csv` arrived with a new column added?
- Is there anything that checks the data looks right before saving it?

**On reuse:**
- If another team wanted to use the cleaned Sales data, could they? Would they trust it?
- If a second business question needed a different gold output, where would it read from?

**On maintenance:**
- If you handed this workspace to a colleague, what would they need to know to run it?
- How would they know if the pipeline had run successfully?

---

## Output

Produce a short list of **design debts** - things that work but would cause problems at scale,
over time, or with another person involved.

Be specific. "It is not well organised" is not a design debt. "Raw and cleaned data sit in the
same folder with no naming convention" is.
