# Lab 2.4 ~ Set Up the Afternoon Session

This lab sets up a fresh HomeSphere environment for the afternoon. By the end, your lakehouse will be ready and the `cleaned_sales` table will exist so you can continue straight into Lab 2.5.


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

    - Name the lakehouse `HomeSphere`
    - Leave **Lakehouse schemas** selected.

    !!! tip "If the **Create** option is not pinned to the sidebar, you need to select the ellipsis (…) option first."

    !!! quote ""
        ![New lakehouse.](img/new-lakehouse.png)


## Step 5: Upload the HomeSphere data files

1. In the **Explorer** pane of the lakehouse, click the **...** menu for the **Files** folder and select **New subfolder**.

    - Name the new subfolder: `data`
    - Click **Create**

2. Locate the following files in the `HomeSphere/data/` folder on your Desktop:

    - `sales_raw.csv`
    - `products_raw.json`

    !!! note "If you cannot find the `HomeSphere` folder, you may need to re-run the `git clone` clone command."

3. In the **...** menu for the `data` folder, select **Upload** and **Upload files**.

    - Upload both `sales_raw.csv` and `products_raw.json`

4. Select the `data` folder and confirm both files are visible.

    !!! tip "If the files do not automatically appear, in the **...** menu for the `data` folder, select **Refresh**."


## Step 6: Import the notebooks

1. In the left navigation bar, select your workspace name to return to the workspace view.

2. On the toolbar select **Import** and choose **Notebook**. Then select **From this computer**.

3. Browse to the `M3/HomeSphere/cloud/` folder on your Desktop and import:

    - `cloud_output.ipynb`

4. Browse to the `M3/day1/` folder on your Desktop and import:

    - `pm_setup.ipynb`

5. Import again - this time browse to the `HomeSphere/solution/` folder and import:

    - `cloud_clean_solution.ipynb`
    - `cloud_output_solution.ipynb`

    !!! success "All four notebooks should now appear as items in your workspace."


## Step 7: Attach the lakehouse to the notebooks

1. In the left navigation bar, return to your lakehouse `HomeSphere`.

2. On the **Home** tab:

    - Select **Open notebook** > **Existing notebook**
    - Choose: `cloud_output`

3. In the **Notebook Explorer** on the left, select **Data Items** and confirm **HomeSphere** appears under **OneLake**.

4. Return to the lakehouse and repeat for `pm_setup`:

    - select **Open notebook** > **Existing notebook**
    - Choose: `pm_setup`

5. Select **Data Items** in the Notebook Explorer and confirm that **HomeSphere** appears under **OneLake**.

    !!! success "Both notebooks are now connected to the HomeSphere lakehouse."


## Step 8: Run the `pm_setup` notebook

!!! note "This step creates the `cleaned_sales` table ready for Lab 2.5"

1. You should already have `pm_setup` open. Select **Run all**.

    !!! success "The `cleaned_sales` table should now appear in the **Tables** section of your lakehouse."

2. After the notebook finishes, select the **Run** tab above the ribbon and then select **Stop session**.


---

## Keep your workspace

Your HomeSphere environment is ready for the afternoon. The `cleaned_sales` table is in place and all notebooks are attached.

**Do not delete your workspace** - you will continue working in it in Lab 2.5.
