# Inspect the Source Data

## What you are doing

HomeSphere has given you two raw exports from their systems.
Before you clean or combine anything, your job is to look closely at what is actually in each file.

Open the notebook: **`day1_clean.ipynb`** and work through **Parts 1 and 2**.

---

## Part 1 — Sales data

The Sales file is a flat CSV of order lines exported from HomeSphere's order management system.

Run each cell in turn and pay attention to what pandas tells you.

Things to look for:

- What are the column names and data types?
- Which columns have missing values, and how many?
- Are there any duplicate rows?
- Look at the unique values in `status`, `unit_price`, `quantity`, and `order_date` — do they look consistent?

**Do not fix anything yet.** Just observe and make notes.

---

## Part 2 — Product data

The Product catalogue came from a different system and is stored as JSON, not CSV.

Run the two cells and look at the structure of the file.

Things to notice:

- The file has a top-level wrapper — the products are inside a key called `"products"`
- Each product has a nested `specs` object containing price, warranty, colour, and connectivity
- This structure cannot be used directly as a table — it needs flattening before you can join it

---

## Discussion

Before you move on, discuss these questions with your group:

- List every problem you spotted in the Sales data. How many did you find?
- Why would it be risky to use the raw Sales data for reporting without cleaning it first?
- What is different about the Product data compared to the Sales data?
- Which fields from Products will you need when you join to Sales?
