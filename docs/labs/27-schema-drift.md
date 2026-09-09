# Lab 2.7 ~ Rerun with a Schema Change

!!! abstract "S8: Identify and troubleshoot issues with data processing pipelines."

!!! info "This lab continues from Lab 2.6. Your pipeline and both sales files should still be in place."

A third batch of orders has arrived. This time, nothing about the data itself is
wrong - every row is valid. But the file was produced by a different system,
and one column has a different name.

## Step 1: Add the third batch

1. Locate `sales_raw_batch27.csv` alongside your other HomeSphere data files.

2. Open it and compare its columns to `sales_raw.csv`.

    !!! question "What's different?"

3. Upload it into `Files/data/`, next to the other two files. Don't delete or
   rename anything.

## Step 2: Rerun the pipeline

1. Go to your **HomeSphere ETL Pipeline** and select **Run**.

2. Wait for both activities to finish.

## Step 3: Check the status

!!! question "Before you check the numbers - what do you expect the pipeline status to say?"

Note what it actually says.

## Step 4: Verify the results

1. Open `cloud_clean_solution` and run just the first code cell (the one with
   `glob.glob(...)` and `pd.concat(...)`). Don't run the rest of the notebook -
   you only need this cell's output.

    Look at the printed `Shape:` line - the first number is your **raw row
    count**. The `Files read:` line above it also confirms all three files were
    picked up.

    !!! tip "Why just this cell?"
        Running the whole notebook would redo the write step and produce the
        exact same result the pipeline already gave you. You only need this
        one cell to see how many raw rows came in - the rest of your numbers
        come from SQL, below.

2. Run the same SQL queries as before for cleaned rows, output rows, and revenue.

3. Add a third row to your table:

    | Run         | Input                | Expected change        | Raw rows | Cleaned rows | Output rows | Revenue | Status |
    |-------------|-----------------------|------------------------|----------|--------------|-------------|---------|--------|
    | Third batch | sales_raw_batch27.csv | Four additional orders |          |              |             |         |        |

## Step 5: Find out what happened

Compare this run to Lab 2.6's second batch.

- In Lab 2.6, one row out of five went missing. This time, how many of the four
  new orders actually made it into `sales_trusted_solution`?
- The renamed column still exists in the raw file - it just isn't the column the
  notebook is looking for. Trace through `cloud_clean_solution` and find the
  exact line where that batch's data gets silently dropped.
- Would you have noticed this without doing Steps 1-4?

!!! question "The pipeline succeeded. An entire batch of valid orders is missing from the trusted output. What does 'Succeeded' actually guarantee?"
