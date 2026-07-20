# Lab 2.0 ~ Update the HomeSphere Files

!!! info "Your Virtual Machine has kept the files from Day 1. This step makes sure they are up to date before you start Day 2."

## Step 1: Open Terminal

Open **Terminal** on your Virtual Machine. It will open at: `C:\Users\Admin`


## Step 2: Navigate to the M3 folder

```
cd Desktop/M3
```


## Step 3: Pull the latest files

```
git pull
```

This updates the `HomeSphere` folder with anything added or changed since Day 1 -
you do not need to download anything again.


## Step 4: Confirm the files are there

```
cd HomeSphere
dir
```

Check that the `HomeSphere` folder still contains:

- `cloud/` - notebooks for Day 2
- `data/` - the raw source files
- `local/` - the notebooks from Day 1

!!! success "You are ready to start Day 2"

!!! tip "If `git pull` shows an error"
    Delete the `M3` folder and clone it again, the same way you did on Day 1:

    ```
    cd Desktop
    git clone https://github.com/QAADE5/M3.git
    ```
