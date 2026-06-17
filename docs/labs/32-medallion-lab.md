# Lab 3.2 ~ HomeSphere Medallion Architecture

In this lab, you will restructure the HomeSphere data into three clearly separated layers: **bronze** (raw), **silver** (cleaned and trusted), and **gold** (business-ready output).

## Step 1: Start the Microsoft Fabric Playground

1. Navigate to the [QA Platform](https://bud.sso.app.qa.com/lab/microsoft-fabric-playground/) to access the **Microsoft Fabric Playground**.

2. Click **Start** to start the lab.

3. Make a note of your allocated **username** and **password**.

!!! warning "Wait until the lab status shows **Ready**, before continuing with the next step!"

!!! tip "Switch to your Virtual Machine to complete the steps listed below."

## Step 2: Logon to Azure and Microsoft Fabric

1. In your VM open a **private browsing window** (InPrivate in Edge, Incognito in Chrome).

2. Navigate to the [Microsoft Azure home page](https://portal.azure.com/) at: https://portal.azure.com

3. When prompted, sign in using:

    - **Username** from the QA Platform (used as the email address)
    - **Password** from the QA Platform (used as a Temporary Access Pass)

    - If prompted to "Stay signed in?", select **No**.

    !!! success "You are now signed in to the **Azure portal**. This confirms your lab account is active."

4. In the same private browsing window, **open a new tab**.

5. Navigate to the [Microsoft Fabric home page](https://app.fabric.microsoft.com/home?experience=fabric-developer) at: https://app.fabric.microsoft.com/home?experience=fabric-developer

6. If prompted, **re-enter your email address** to confirm access to Microsoft Fabric.

    !!! quote ""
        ![Fabric home page](img/qa-fabric-home.png)


## Step 3: Create a workspace

1. In the navigation pane on the left, select **Workspaces** (the icon looks similar to &#128455;).

2. Select **+ New workspace**, then create a workspace using the naming format below:

    - Start the name with `fab_workspace`
    - Add random numbers to make it unique (for example, `fab_workspace123`)
    - Leave all other options as the default values
    - Click **Apply**

    !!! quote ""
        ![Empty workspace in Fabric.](img/new-workspace.png)


## Step 4: Create a lakehouse

1. On the menu bar on the left, select **Create**. In the *New* page, under the *Data Engineering* section, select **Lakehouse**.

    - Name the lakehouse: `HomeSphere`

    !!! tip "If the **Create** option is not pinned to the sidebar, you need to select the ellipsis (…) option first."

    After a minute or so, a new empty lakehouse will be created.

    !!! quote ""
        ![New lakehouse.](img/new-lakehouse.png)


## Step 5: Create the bronze layer

The bronze layer holds raw data exactly as it arrived - no modifications.

1. In the **Explorer** pane, click the **...** menu for the **Files** folder and select **New subfolder**.

    - Name the subfolder: `bronze`

2. Click the **...** menu for the `bronze` folder and select **Upload** > **Upload files**.

3. Locate the following files in the `HomeSphere/data/` folder on your Desktop and upload both:

    - `sales_raw.csv`
    - `products_raw.json`

4. Select the `bronze` folder and confirm both files are visible.

    !!! tip "If the files do not automatically appear, select **Refresh** from the **...** menu."

    !!! note "Bronze is read-only by convention"
        Never write transformed data into the bronze folder. If you need to re-run the pipeline from scratch, bronze is your guaranteed clean starting point.


## Step 6: Create the Bronze to Silver notebook

Silver is where raw data becomes trusted. You apply cleaning, validation, and standardisation - but you do not yet answer any business question.

1. On the **Home** tab of the lakehouse, select **Open notebook** > **New notebook**.

2. Select the notebook name at the top of the page and rename it to `HomeSphere - Bronze to Silver`.

Work through the following cells in order, adding each one and running it before moving to the next.

### Cell 1 - Load the sales raw file

Paste the following into the first cell and run it:

```python
# Cell 1
import pandas as pd
import json

# Read raw sales from bronze
df = pd.read_csv('/lakehouse/default/Files/bronze/sales_raw.csv')

print(f'Bronze: {len(df)} rows')
```

### Cell 2 - Clean sales

Paste the following into the second cell and run it:

```python
# Cell 2 - Clean
df['unit_price'] = df['unit_price'].astype(str).str.replace('£', '', regex=False).astype(float)
df['order_date'] = pd.to_datetime(df['order_date'], format='mixed', dayfirst=True, errors='coerce')
df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
df = df.dropna(subset=['quantity'])
df['quantity'] = df['quantity'].astype(int)
df['status'] = df['status'].str.lower().str.strip()
df = df.drop_duplicates()
df = df.dropna(subset=['product_id'])
df['region'] = df['region'].fillna('Unknown')
df = df[df['unit_price'] > 0]
df = df[df['quantity'] > 0]

print(f'Silver: {len(df)} rows')
print(f'Dropped: {30 - len(df)} rows')
```

### Cell 3 - Validate before saving

Add a new cell and run the following validation checks - never save data you have not verified:

```python
# Cell 3 - Validate
assert pd.api.types.is_float_dtype(df['unit_price']), "unit_price should be float"
assert pd.api.types.is_integer_dtype(df['quantity']), "quantity should be int"
assert df['product_id'].isnull().sum() == 0, "product_id should have no nulls"
assert (df['unit_price'] > 0).all(), "all prices should be positive"
assert (df['quantity'] > 0).all(), "all quantities should be positive"

print('All validation checks passed')
print(df.dtypes)
```

### Cell 4 - Write silver_sales

Add a new cell and run it:

```python
# Cell 4 - Write
spark.createDataFrame(df).write.mode('overwrite').saveAsTable('silver_sales')

print('Saved: silver_sales')
```

### Cell 5 - Flatten products

Add a new cell and run it:

```python
# Cell 5 - Flatten
with open('/lakehouse/default/Files/bronze/products_raw.json') as f:
    products_data = json.load(f)

products = pd.json_normalize(products_data['products'])
products = products.rename(columns={
    'specs.rrp': 'rrp',
    'specs.warranty_years': 'warranty_years',
    'specs.colour': 'colour',
    'specs.connectivity': 'connectivity'
})

print(f'Products flattened: {len(products)} rows')
print(products.columns.tolist())
```

### Cell 6 - Write silver_products

Add a new cell and run it:

```python
# Cell 6 - Write
spark.createDataFrame(products).write.mode('overwrite').saveAsTable('silver_products')

print('Saved: silver_products')
```

!!! success "Refresh the **Tables** pane - `silver_sales` and `silver_products` should now be listed."

After running all five cells, on the toolbar use the :material-stop: (*Stop session*) button to stop the Spark session.


## Step 7: Explore the silver layer

Silver is the trust boundary - anyone querying these tables knows the data has been cleaned and validated.

1. In the left navigation bar, select your **HomeSphere** lakehouse.

2. Select **Analyze data with** and choose **SQL analytics endpoint**.

3. Run the following queries to explore the silver tables:

    ```sql
    SELECT status, COUNT(*) AS orders, ROUND(SUM(quantity * unit_price), 2) AS value
    FROM silver_sales
    GROUP BY status
    ORDER BY value DESC
    ```

    ```sql
    SELECT category, COUNT(*) AS products
    FROM silver_products
    GROUP BY category
    ORDER BY products DESC
    ```


## Step 8: Create the Silver to Gold notebook

Gold answers a specific business question. It is always built from silver - never from bronze directly.

1. In the left navigation bar, return to your **HomeSphere** lakehouse.

2. On the **Home** tab, select **Open notebook** > **New notebook**.

3. Select the notebook name at the top of the page and rename it to `HomeSphere - Silver to Gold`.

    !!! warning "If you receive a `TooManyRequestsForCapacity` error when running the first cell:"
        Make sure you stopped the session in the Bronze to Silver notebook before continuing.

Work through the following cells in order.

### Cell 1 - Join silver tables

Paste the following into the first cell and run it:

```python
# Cell 1 - Join
import pandas as pd

# Read from silver - not from bronze, not from raw files
sales = spark.read.table('silver_sales').toPandas()
sales['order_date'] = pd.to_datetime(sales['order_date'])

products = spark.read.table('silver_products').toPandas()
products = products[['product_id', 'name', 'category']]

# Join and compute line value
df = sales.merge(products, on='product_id', how='left')
df['line_value'] = df['quantity'] * df['unit_price']

print(f'Gold dataset: {len(df)} rows')
print(f'Total revenue: £{df["line_value"].sum():,.2f}')
```

### Cell 2 - Write gold_revenue

Add a new cell and run it:

```python
# Cell 2 - Write
spark.createDataFrame(df).write.mode('overwrite').saveAsTable('gold_revenue')

print('Saved: gold_revenue')
```

!!! success "Refresh the **Tables** pane - `gold_revenue` should now be listed."


## Step 9: Answer the business question

1. In the left navigation bar, select your **HomeSphere** lakehouse.

2. Select **Analyze data with** and choose **SQL analytics endpoint**.

3. Run the following query:

    ```sql
    SELECT
        category,
        ROUND(SUM(line_value), 2) AS total_revenue,
        COUNT(*) AS order_lines
    FROM gold_revenue
    GROUP BY category
    ORDER BY total_revenue DESC
    ```

    !!! note
        This is the same revenue answer as Day 1 and Day 2 - but now it comes from a clearly labelled gold table, built from trusted silver sources, which in turn came from untouched bronze data.


## Discussion

- You now have three layers. What does each one protect you against?
- If `gold_revenue` looked wrong, where would you investigate first?
- If a new analyst joined the team, which table would you point them to first?
- What would need to change if HomeSphere added a new sales region next month?
- How is this different from what you built on Day 2?


---

## Clean up resources

In this exercise, you restructured the HomeSphere ETL into a medallion architecture with three clearly separated layers: bronze for raw data, silver for cleaned and validated data, and gold for business-ready output.

Once you have finished exploring, you should delete the workspace you created for this exercise.

1. Navigate to Microsoft Fabric in your browser.

2. In the bar on the left, select the icon for your workspace to view all of the items it contains.

3. Select **Workspace settings** and in the **General** section, scroll down and select **Remove this workspace**.

4. Select **Delete** to delete the workspace.
