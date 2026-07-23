# Lab 4.1 ~ Get the Day 4 Files

!!! note "This only applies to those using a Learn On Demand (LOD) virtual machine"

Before you start running the pipeline locally, you may need to download the Day 4 project files to your machine.


## Step 1: Open Terminal

Open **Terminal** on your Virtual Machine. It will open at: `C:\Users\Admin`


## Step 2: Navigate to your Desktop

```
cd Desktop
```


## Step 3: Clone the repository

```
git clone https://github.com/QAADE5/M3.git
```

This will create a `M3` folder on your Desktop.
Inside that folder is a `day4` folder with all the files you will need for today.


## Step 4: Confirm the files are there

In Terminal (or File Explorer), check that the `day4` folder on your Desktop contains files. E.g:

```
dir
```

- `checks.py`
- `checks_practice.ipynb`
- `pipeline.py`
- `sales_raw.csv`


## Step 5: Install pandas

To prevent `ModuleNotFoundError: No module named 'pandas'` you need to install the Python pandas library:

Run the following in the same Terminal window:

```
pip install pandas
```

!!! success "You are ready to start."
