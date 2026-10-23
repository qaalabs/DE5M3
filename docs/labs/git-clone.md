# Get the M3 Files

!!! info "Download the M3 project files to your Virtual Machine."
    - Do this on Day 1, and again on any morning your VM has been reset.


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

This will create the `M3` folder on your Desktop.

!!! note "fatal: destination path 'M3' already exists"
    - Your VM was not reset - the files from an earlier day are still on your Desktop.
    - There is nothing to do, you are ready to start.


## Step 4: Confirm the files are there

```
cd M3
```

```
dir
```

In Terminal (or File Explorer), check that the `M3` folder on your Desktop contains:

- `HomeSphere/` - the HomeSphere project: raw data, notebooks and solutions
- `day1/` to `day4/` - extra files for each day

!!! success "You are ready to start"
