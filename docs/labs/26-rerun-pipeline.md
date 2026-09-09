# Lab 2.6 ~ Rerun the Pipeline with New Data

!!! abstract "S8: Identify and troubleshoot issues with data processing pipelines."

!!! info "This lab continues from Lab 2.5. Your pipeline should still exist and have run successfully."

Your pipeline already works. This lab does not change it. You are going to run it
twice and check whether **Succeeded** actually means what you think it means.

## Step 1: Establish the baseline

Before anything changes, record what your pipeline has already produced.

1. Reopen the `cloud_clean_solution` notebook and note the `Shape:` line printed
   after the first cell runs - this is your **raw row count**.

2. Switch to the **SQL analytics endpoint** in your lakehouse and run:

    ```sql
    SELECT COUNT(*) AS rows FROM cleaned_sales_solution
    ```

    This is your **cleaned row count**.

3. Run:

    ```sql
    SELECT COUNT(*) AS rows, ROUND(SUM(line_value), 2) AS revenue
    FROM sales_trusted_solution
    ```

    This gives you the **output row count** and **revenue**.

4. Check the pipeline's run history and confirm both activities show **Succeeded**.

5. Record all four numbers:

    | Run         | Input         | Raw rows | Cleaned rows | Output rows | Revenue | Status |
    |-------------|---------------|----------|--------------|-------------|---------|--------|
    | Initial run | sales_raw.csv |          |              |             |         |        |

## Step 2: Add a second batch of orders

A new batch of orders has arrived - five additional orders, the same schema,
a familiar mix of data-quality issues.

1. Locate `sales_raw_batch26.csv` alongside your other HomeSphere data files.

2. In your lakehouse, upload it into `Files/data/`, **next to** the existing
   `sales_raw.csv`.

    !!! note "Do not delete or rename anything"
        Both files should now sit side by side in `Files/data/`.

## Step 3: Rerun the pipeline

1. Go to your **HomeSphere ETL Pipeline**.

2. Select **Run**. This is the same pipeline from Lab 2.5 - you have not changed it.

3. Wait for both activities to show **Succeeded**.

## Step 4: Verify the results

1. Re-run the same queries from Step 1.

2. Add a second row to your table:

    | Run          | Input                 | Expected change        | Raw rows | Cleaned rows | Output rows | Revenue | Status |
    |--------------|-----------------------|-------------------------|----------|--------------|-------------|---------|--------|
    | Second batch | sales_raw_batch26.csv  | Five additional orders |          |              |             |         |        |

## Step 5: Check your work

Look at your two rows side by side.

- Did **raw rows** increase by 5?
- Did **cleaned rows** and **output rows** increase by the same amount?
- If not - where do you think the missing row went, and why?

Don't guess. Go and find the actual row in the data if you need to.

!!! question "The pipeline said Succeeded both times. Does that tell you the output is correct?"
