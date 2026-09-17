# Run the Pipeline Locally

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

!!! abstract "S8: Identify and troubleshoot issues with data processing pipelines."

So far you have run the HomeSphere pipeline in notebooks - one cell at a time.

A production pipeline runs as a script. No cells. No Run button. You execute it from the terminal and it either completes or it does not.

---

## Getting started

Open a terminal and navigate to the `day4` folder:

```
cd Desktop\M3\day4
```

Open VS Code in that folder:

```
code .
```

---

## Part 1 - Open and run the script

Open `pipeline.py`.

Read through it. The structure is the same as the notebooks you have been working in all week: load, validate, clean, output. The difference is that it runs top to bottom in one go.

Open the terminal in VS Code (`Ctrl+` `` ` ``) and run it:

```
python pipeline.py
```

!!! note "ModuleNotFoundError: No module named 'pandas'"
    If your VM resets each day, the terminal's Python may not have pandas installed, even though the notebook kernel does. Fix it with:

    ```
    pip install pandas
    ```

    Then run `python pipeline.py` again.

Watch the output. The pipeline loads the raw file, skips the validation (nothing is active yet), cleans the data, and writes `silver_sales.csv`.

---

## Part 2 - Make it fail

Find `get_failures()` in `checks.py`. Two example checks are commented out. Uncomment one - either one.

In VS Code you can select the lines and press `Ctrl+/` to toggle comments on and off.

Run the pipeline again:

```
python pipeline.py
```

The pipeline stops before cleaning. No output file is written. The terminal shows you exactly which check failed.

This is **fail fast**: a check in `get_failures()` stops the pipeline. The exit code `1` tells the operating system the pipeline failed - a scheduler or monitoring tool would use this to raise an alert.

---

## Part 3 - Make it warn

Now move the check you just uncommented from `get_failures()` into `get_warnings()`.

Run again:

```
python pipeline.py
```

The warning prints to the terminal. The pipeline continues. The output file is written.

---

## Think about it

You made the same decision twice today - once in the notebook this morning, and just now in the script.

- A check in `get_failures()`: the pipeline refuses to run on bad data
- A check in `get_warnings()`: the pipeline runs but flags what it found

Which would you choose for HomeSphere? Does it depend on who is reading the output?

---

## Stretch

If you finish early and know some Python:

- Add the failing rows to a separate file (`rejected.csv`) instead of just printing them
- Add a timestamp to the warning message so you know when the check ran
