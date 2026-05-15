# Open Sales Data

## What you are doing

HomeSphere has exported their order lines from the order management system as a CSV.
Before you clean or combine anything, your job is to look closely at what is actually in it.

Open the notebook: **`day1_clean.ipynb`** and work through **Part 1**.

---

## What to look for

Run each cell in turn and pay attention to what pandas tells you:

- What are the column names and data types?
- Which columns have missing values, and how many?
- Are there any duplicate rows?
- Look at the unique values in `status`, `unit_price`, `quantity`, and `order_date` - do they look consistent?

**Do not fix anything yet.** Just observe and make notes in the Discussion cell.

---

## Discussion

- List every problem you spotted. How many did you find?
- Why would it be risky to use this data as-is for reporting?
