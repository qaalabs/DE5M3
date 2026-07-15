# Flatten, Join, and Answer

!!! question "The question we are trying to answer is:"
    - Which product categories generate the most revenue?

## What you are doing

You have a cleaned Sales dataset. You have a Product catalogue in nested JSON.
Your job is to combine them and answer the question:

> **Which product categories generate the most revenue?**

Open the notebook: **`local_join.ipynb`** and work through all parts.

---

## Part 1 - Flatten the Product data

The Product JSON cannot be joined directly because the fields you need (`category`, `name`) are mixed with nested `specs` data.

`pd.json_normalize` flattens the nested structure into a flat table. It creates columns named with dot notation - `specs.rrp`, `specs.warranty_years` - which you then rename.

Once flattened, select only the three columns you actually need for the join: `product_id`, `name`, `category`. Keeping unused columns out of the joined table avoids confusion later.

---

## Part 2 - Load cleaned Sales

Load the `cleaned_sales.csv` you saved in the previous session.
Use `parse_dates=['order_date']` so the date column comes in correctly typed.

---

## Part 3 - Join

Merge Sales to Products on `product_id` using a **left join**.

A left join keeps every Sales row, and adds the matching product columns where they exist. If a Sales row has a `product_id` that does not appear in Products, the product columns will be `NaN`.

Check the missing values after the join - any `NaN` in `category` means that Sales row could not be matched to a product.

---

## Part 4 - Calculate line value

Revenue for each order line is `quantity × unit_price`. Add a `line_value` column.

---

## Part 5 - Answer the question

Group by `category`, sum `line_value`, and sort highest to lowest.

!!! question "Are you now able to answer the question:"
    - Which product categories generate the most revenue?

---

## Discussion

- Why did we use a left join rather than an inner join? What would an inner join have done differently?
- After the join, are there any rows with a missing `category`? What does that tell you?
- What would have happened to the revenue totals if you had not removed the duplicate rows during cleaning?
- What cleaning step was essential before the join could work at all?
