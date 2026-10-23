# Run the ETL Script

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

!!! abstract "S4: Automate data pipelines such as batch, real-time, on demand and other processes using programming languages and data integration platforms with graphical user interfaces."

Today you built the HomeSphere pipeline in two notebooks, one cell at a time.

Now we run the whole pipeline as a single script, from the terminal, together.

---

## Open VS Code

Open a terminal and navigate to the `M3` folder:

```
cd Desktop\M3
```

Open VS Code in that folder:

```
code .
```

In the Explorer panel, open **`day1/stretch/etl_solution.py`** and read through it. It is the same clean, flatten and join steps as your notebooks, written as functions.

---

## Run the script

Open the terminal in VS Code (`Ctrl+` `` ` ``). It starts in the `M3` folder. Run:

```
python day1\stretch\etl_solution.py
```

!!! note "ModuleNotFoundError: No module named 'pandas'"
    If your VM resets each day, the terminal's Python may not have pandas installed, even though the notebook kernel does. Fix it with:

    ```
    pip install pandas
    ```

    You may see `Defaulting to user installation because normal site-packages is not writeable` at the start, and a yellow WARNING at the end ending `which is not on PATH` - both are expected. pandas is still installed.

    Then run `python day1\stretch\etl_solution.py` again.

The script saves `cleaned_sales.csv` and `sales_joined.csv` in the same `stretch` folder, and prints a revenue summary at the end.

---

## Check the answer

Look at the **Revenue by Category** table at the bottom of the output.

- Which category earns the most?
- Does it match the answer from your notebooks?
