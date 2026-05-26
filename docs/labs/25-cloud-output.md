# Lab 2.5 ~ Build the Trusted Output

This lab continues from Lab 2.4. Your HomeSphere lakehouse and the `cleaned_sales` table should already be in place.


## Step 1: Open the cloud_output notebook

1. In the left navigation bar, select your **HomeSphere** lakehouse.

2. On the **Home** tab, select **Open notebook** > **Existing notebook**, and choose `cloud_output`.

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

3. Run all remaining cells and confirm the notebook completes without errors.

    !!! success "The `sales_trusted` table should now appear in the **Tables** section of your lakehouse."

4. After running the last cell, select the **Run** tab above the ribbon and then select **Stop session**.

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

**Do not delete your workspace** - you will continue working in it in Lab 2.6.
