# HomeSphere ~ Cloud: Clean the Sales Data in Fabric

**Scenario:** The same raw Sales and Product files you worked with locally are now sitting in your Fabric lakehouse.

Your job is to run the same cleaning pipeline you built when working locally.

But this time the data lives in OneLake, and the output will be saved as a Delta table rather than a CSV file.

---

## Part 1: Load the Sales Data

When working locally you loaded data from a local path.

In Fabric, files are uploaded to the lakehouse and are then available at: `/lakehouse/default/Files/`.

The path structure mirrors the folder you see in the **Lakehouse Explorer**.


```python
import pandas as pd
import json

# TODO: Load sales_raw.csv from the lakehouse Files folder
# Hint: the path is /lakehouse/default/Files/data/sales_raw.csv
df = # YOUR CODE HERE

print(f'Shape: {df.shape}')
df.head()
```


```python
# Same checks as Day 1 - confirm the data arrived as expected
print('Data types:')
print(df.dtypes)
print('\nMissing values:')
print(df.isnull().sum())
print(f'\nDuplicate rows: {df.duplicated().sum()}')
```

## Part 2: Clean the Sales Data

The same nine fixes as when working locally.

You have done this before - work through them without the notebook prompting you this time.


```python
# TODO: Apply all nine cleaning steps from Day 1
#
# 1. Strip £ from unit_price and cast to float
# 2. Parse order_date with pd.to_datetime
# 3. Coerce quantity to numeric, drop NaN rows, cast to int
# 4. Lowercase and strip status
# 5. Drop duplicate rows
# 6. Drop rows with missing product_id
# 7. Fill missing region with 'Unknown'
# 8. Remove rows with negative or zero unit_price
# 9. Remove rows with zero quantity

# YOUR CODE HERE


print(f'Rows after cleaning: {len(df)}')
print('\nData types:')
print(df.dtypes)
print('\nMissing values:')
print(df.isnull().sum())
```

## Part 3: Save as a Delta Table

When working locally, we saved a CSV file.

In Fabric, the native output is a **Delta table** stored in the lakehouse.

Delta tables are queryable via the SQL endpoint, versioned, and accessible to other Fabric workloads.

We convert the pandas DataFrame to a Spark DataFrame to write it as a Delta table.


```python
# spark is available automatically in Fabric notebooks — no import needed
# spark.createDataFrame() converts a pandas DataFrame to a Spark DataFrame
spark_df = spark.createDataFrame(df)

# TODO: Save spark_df as a managed Delta table named 'cleaned_sales'
# Hint: .write.mode('overwrite').saveAsTable('table_name')
# YOUR CODE HERE

print('Saved: cleaned_sales (Delta table)')
print(f'Rows: {spark_df.count()}')
```

## Part 4: Verify in the SQL Endpoint

Now that the table is saved, you can query it using SQL - without writing any more Python.

Switch to the **SQL analytics endpoint** in your lakehouse and run:


```sql
%%sql
SELECT
    status,
    COUNT(*) AS order_count,
    ROUND(SUM(quantity * unit_price), 2) AS total_value
FROM cleaned_sales
GROUP BY status
ORDER BY total_value DESC
```

### Discussion

- What changed between **working locally**, and **working in the cloud**?
- And what stayed exactly the same?
- The output is now a Delta table instead of a CSV - what does that enable that a CSV cannot do?
