# Run the Pipeline Locally

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

!!! abstract "S8: Identify and troubleshoot issues with data processing pipelines."

So far you have run the HomeSphere pipeline in notebooks - one cell at a time.

A production pipeline runs as a script. No cells. No Run button. You execute it from the terminal and it either completes or it does not.

---

## Getting started

Open VS Code in your `M3\day4` folder. There are two files to work with:

- `pipeline.py` - the pipeline: load, validate, clean, output. You do not need to change it.
- `checks.py` - your checks. This is the file you edit.

---

## Part 1 - Run the script

Open `pipeline.py` and read through it. The structure is the same as the notebooks you have used all week. The difference is that it runs top to bottom in one go.

Open the terminal in VS Code (`Ctrl+` `` ` ``) and run it:

```
python pipeline.py
```

!!! note "ModuleNotFoundError: No module named 'pandas'"
    If your VM resets each day, the terminal's Python may not have pandas installed, even though the notebook kernel does. Fix it with:

    ```
    pip install pandas
    ```

    You may see `Defaulting to user installation because normal site-packages is not writeable` at the start, and a yellow WARNING at the end ending `which is not on PATH` - both are expected. pandas is still installed.

    Then run `python pipeline.py` again.

Watch the output. The pipeline loads 30 rows, passes validation, cleans the data down to 23 rows and writes `silver_sales.csv`.

Seven rows dropped. Nothing complained.

---

## Part 2 - Switch on the checks

Open `checks.py`. Find `get_failures()`.

The checks from this morning's notebook are there, commented out. Select from the first `#if` down to the last `#errors.append` line and press `Ctrl+/` to switch them on.

!!! tip "If you wrote your own checks in the notebook, compare them. Different code that catches the same problems is fine."

Run the pipeline again:

```
python pipeline.py
```

The pipeline stops before cleaning. No output file is written. The terminal shows every check that failed.

---

## Part 3 - Did it fail?

The pipeline did not just print a message. It told the operating system it failed. Run this straight after the failed run:

```
echo $LASTEXITCODE
```

`1` means failed. `0` means it completed.

A scheduler or monitoring tool reads this number to decide whether to raise an alert or retry. A Fabric pipeline does the same thing when it decides whether to follow the on-success or the on-failure path.

---

## Part 4 - Failure or warning?

Your pipeline now refuses to run. But look at what it is refusing on.

The cleaning step already handles most of these problems: it drops rows with a missing `product_id`, drops duplicates, drops bad quantities, and fills a missing region with `"Unknown"`.

Stopping the pipeline for a problem it already knows how to handle means it never runs.

Move checks from `get_failures()` into `get_warnings()` until the pipeline completes. For each one, decide:

- **Failure** - the pipeline cannot safely carry on
- **Warning** - the pipeline can handle it, but someone should know

Run it after each move. The warnings still print - the problems are visible, but the pipeline completes.

---

## Think about it

You made the same decision twice today - once in the notebook, and again in the script.

- Which checks did you leave as failures? Why?
- What kind of problem *should* stop this pipeline? (What if the file arrived with 3 rows? Or no `product_id` column at all?)
- Does your answer change depending on who is reading the output?

---

## Stretch

### Check the cleaned data

Find `get_silver_failures()` in `checks.py`. It runs **after** cleaning, before the output is written. A failure here means the cleaning itself has gone wrong.

Add three checks:

- Cleaning dropped more than 25% of the rows (`raw_rows` tells you how many were loaded)
- Any `order_date` could not be read
- Any `status` is not `complete`, `pending` or `cancelled`

They should all pass. To prove a check works, change it to make it fail - for example change 25% to 10% - then change it back.

### More

- Add the failing rows to a separate file (`rejected.csv`) instead of just printing them
- Add a timestamp to the warning message so you know when the check ran
