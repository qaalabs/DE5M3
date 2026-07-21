# Stretch: Turn the Pipeline into a Script

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

!!! abstract "S4: Automate data pipelines such as batch, real-time, on demand and other processes using programming languages and data integration platforms with graphical user interfaces."

## What you are doing

You have run the full ETL pipeline in two notebooks.

**Now rebuild it as a single Python script that runs from the terminal** - no notebook, no cells, just `python etl_todo.py`.

!!! info "This is closer to how a pipeline would actually be deployed."

---

## Getting started

Open **`etl_todo.py`** from the `M3/day1/stretch` folder in the HomeSphere repo in Visual Studio Code.

The script has three functions for you to complete:

| Function               | What it does                                              |
|------------------------|-----------------------------------------------------------|
| `clean_sales()`        | Loads and cleans `sales_raw.csv`                          |
| `flatten_products()`   | Loads and flattens `products_raw.json`                    |
| `join_and_aggregate()` | Joins the two datasets and calculates revenue by category |

`main()` is already written - it calls your functions, saves the outputs, and prints the summary. Run it at any point to see how far you have got.

---

## Run the script

Open a terminal, navigate to the `M3/day1/stretch` folder in the HomeSphere repo, and run:

```
python etl_todo.py
```

When everything is working you should see output like:

```
=== HomeSphere ETL ===

Loaded sales: 30 rows, 7 columns
  Removed 2 duplicate rows
  ...
  Clean sales: 24 rows remaining
  Saved: cleaned_sales.csv

Loaded products: 8 rows
  Saved: sales_joined.csv

=== Revenue by Category (total £...) ===
  Smart Home           £  ...
  ...
```

---

## Tips

- Work through the `# TODO:` comments one at a time, exactly as you did in the notebooks.
- Run the script after each function to check your progress - Python will show you the error if something is wrong.
- The logic is identical to the notebooks - you are translating it, not rewriting it.
- If you get stuck, the notebooks are your reference. `etl_solution.py` is there if you need it.

---

## Discussion

- What is different about debugging a script compared with a notebook?
- The script prints a progress message after each step. Why might that be useful if this ran automatically every night?
- `main()` calls each function in order. What would happen if you called `join_and_aggregate()` before `clean_sales()` had finished?
- What would you need to change if the input files were in a different folder?

