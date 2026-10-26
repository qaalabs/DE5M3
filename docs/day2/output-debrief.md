# Trusted Output Consolidation

In [Lab 2.4 - Build the Trusted Output](../labs/24-cloud-output.md), you combined cleaned Sales data with the Product catalogue, calculated revenue and queried the output.

## Connect the activity to the KSBs

> **K17:** Approaches to data integration and how combining disparate data sources delivers value to an organisation.

> **S9:** Query and manipulate data using tools and programming such as SQL and Python. Manage database access, and implement automated validation checks.

Identify what K17 asks you to understand about **combining sources** and **delivering value**. In S9, identify the actions you practised when you **queried and manipulated data**. Managing database access and implementing automated validation checks are wider parts of S9 that this lab did not ask you to perform.

## Write it down

Work individually in your personal learning notes. A few bullets beside an existing query and result are enough:

1. **Combine and explain:** What data did you join, on which key, and what could HomeSphere learn from the combined data that Sales alone could not tell it? Explain how this relates to K17.
2. **Query and interpret:** Keep one SQL query and a result from your run. Explain what the result means and how the query produces it. Use this to explain the querying or manipulation part of S9.

Keep this brief and use your actual work. Say where you used guidance or a solution, and note any uncertainty. Build on earlier notes rather than repeat the cleaning reflection or the full local-versus-cloud comparison.

## Check your understanding

Check your explanation against the join code, SQL and output. Would grouping Sales by `product_id` alone answer the category revenue question? Use this to check why the Product catalogue adds value. Revise your existing bullets or mark a gap for feedback; no separate answer is needed.

## What comes next?

You now have two ETL notebooks, a saved `cleaned_sales` table and a saved `sales_trusted` table. The cleaned Sales table can be reused; the flattened Products data is not saved as a separate reusable table.

So far, you have run the notebooks individually. In the next lab, you will connect the supplied solution notebooks in a pipeline so their execution follows the dependencies you configure.
