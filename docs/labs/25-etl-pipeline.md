# Lab 2.5 ~ Orchestrate the HomeSphere ETL with a Pipeline

!!! abstract "S4: Automate data pipelines such as batch, real-time, on demand and other processes using programming languages and data integration platforms with graphical user interfaces."

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

!!! info "This lab continues from where you left off. Your workspace and lakehouse from the earlier session should be still available."


## Step 1: Return to your HomeSphere workspace

1. In the navigation pane on the left, select **Workspaces** (the icon looks similar to &#128455;).

2. Select your `fab_workspace` to open it.

!!! tip "If your workspace is no longer available, you will need to repeat the workspace setup from Lab 2.2 and Lab 2.3 before continuing."


## Step 2: Attach the solution notebooks to the lakehouse

You imported four notebooks in the setup.

So far you have only used the exercise notebooks. In this lab **you will use the solution notebooks** to build your pipeline.

1. In the left navigation bar, return to your lakehouse `HomeSphere`.

2. At the top-right of the Lakehouse page, select the **Analyze data with** dropdown and choose: **Notebook** > **Existing notebook**

    !!! abstract ""
        ![Lakehouse new notebook](img/qa-lakehouse-notebook.png)

3. In the *OneLake catalog* under the heading **Open existing notebook**

    - Choose: `cloud_clean_solution`

3. In the **Notebook Explorer** on the left, select **Data Items** and confirm that **HomeSphere** appears under **OneLake**.

4. Return to the lakehouse and repeat for **cloud_output_solution**:

    - Select: **Notebook** > **Existing notebook** 
    - Choose: `cloud_output_solution`

5. Confirm that **HomeSphere** appears under **Data Items** in the Notebook Explorer.

!!! success "Both solution notebooks should now be connected to the HomeSphere lakehouse."


## Step 3: Create two tracking notebooks

You will add two small notebooks to the pipeline, purely to record whether a run succeeded or failed - separate from the two notebooks that do the actual ETL work. Neither needs the lakehouse attached, since neither reads or writes any tables.

1. In the left navigation bar, select your workspace name to return to the workspace view.

2. Select **New item**, then search for and select **Notebook**.

3. Name the notebook: `Track Pipeline Success`

4. Select the existing empty cell and replace its contents with:

    ```python
    import requests
    ctx = dict(notebookutils.runtime.context)
    ctx["source"] = "de5m3-SUCCESS"

    try:
        requests.post("https://qapha-249748487450.us-east1.run.app/", json=ctx, timeout=5)
    except Exception:
        pass  # a dead endpoint must never fail the notebook run
    ```

    !!!! note "The notebook will save automatically."

6. Repeat steps 2-5 for a second notebook:

    - Name it: `Track Pipeline Failure`
    - Use the same cell contents, but change the `source` line to:

        ```python
        ctx["source"] = "de5m3-FAILURE"
        ```


## Step 4: Create a pipeline

A pipeline lets you orchestrate the four notebooks so they run automatically, rather than being triggered manually one at a time.

1. In the left navigation bar, select your workspace name to return to the workspace view.

    !!! abstract ""
        ![Workspace View](img/25-workspace-view.png)

2. Select **New item**, then search for and select **Pipeline**.

3. Name the pipeline: `HomeSphere ETL Pipeline`

    !!! success "The pipeline designer canvas should open, ready for you to add activities."


## Step 5: Configure the pipeline activities

You will add four Notebook activities - one for each solution notebook, and one for each tracking notebook - and connect them so each only runs when the activity before it reaches the right outcome.

1. In the pipeline canvas you should see: **Start with a blank canvas**

    - Select: **Pipeline activity**
    - Choose: **Notebook** (scroll down - it should be under the *Transform* heading)

2. In the activity properties pane below the canvas, set the **Name** to: `Clean Sales Orders`

3. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `cloud_clean_solution`

4. Click the **Activities** tab and add a second **Notebook** activity to the canvas. 

5. In the properties pane, set the **Name** to: `Build Output`

6. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `cloud_output_solution`

7. Add a third **Notebook** activity to the canvas.

8. In the properties pane, set the **Name** to: `Track Success`

9. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `Track Pipeline Success`

10. Add a fourth **Notebook** activity to the canvas.

11. In the properties pane, set the **Name** to: `Track Failure`

12. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `Track Pipeline Failure`

13. On the **Home** tab, click **Save**


## Step 6: Connect the four activities

1. Hover over the **Clean Sales Orders** activity until small coloured arrows appear at its corners. Drag the **green** (on success) arrow to the **Build Output** activity.

2. Hover over the **Clean Sales Orders** activity again. Drag the **red** (on failure) arrow to the **Track Failure** activity.

3. Hover over the **Build Output** activity. Drag the **green** (on success) arrow to the **Track Success** activity.

!!! abstract ""
    ![Pipeline with two connected notebook activities.](img/25-pipeline-activities-track.png)

!!! note "Why Track Failure only connects to Clean Sales Orders"
    - **Build Output** only ever runs after **Clean Sales Orders** succeeds, so if **Clean Sales Orders** fails, **Build Output** never runs at all.
    - An activity with more than one incoming dependency needs *all* of them satisfied before it runs - so if **Track Failure** also waited on a failure from **Build Output**, it would never fire in that case, because **Build Output** would never reach a failed state either.
    - **Track Success** will only run if **Build Output** completes without errors, so a success ping only ever reflects a fully successful pipeline run.
    - This is what makes a pipeline more reliable than running notebooks by hand.

!!! note "Before running the pipeline - select the Monitor tab and make sure no other notebook is still running."


## Step 7: Run the pipeline

1. On the **Home** tab, use the :material-content-save: (*Save*) icon to save the pipeline.

2. Use the :material-play: **Run** button to run the pipeline.

3. Monitor the progress in the **Output** pane below the canvas.

    - Use the :material-refresh: (*Refresh*) icon to refresh the status.
    - Wait for **Clean Sales Orders**, **Build Output**, and **Track Success** to show a green tick.

!!! success "Clean Sales Orders, Build Output, and Track Success should show as **Succeeded**. Track Failure should show as **Skipped** - that is expected, since its failure condition was never met."


## Step 8: Verify the results

The pipeline has run the same cleaning and output logic as the notebooks you ran manually earlier. You should now have two additional tables in your lakehouse.

1. In the left navigation bar, return to your **HomeSphere** lakehouse.

2. Select **Analyze data with** and choose **SQL analytics endpoint**.

3. Run the following queries to confirm the pipeline created the expected tables:

    ```sql
    SELECT COUNT(*) AS rows FROM cleaned_sales_solution
    ```

    Then run:

    ```sql
    SELECT category, ROUND(SUM(line_value), 2) AS total_revenue
    FROM sales_trusted_solution
    GROUP BY category
    ORDER BY total_revenue DESC
    ```

    !!! abstract ""
        ![Pipeline final output.](img/25-final-output.png)

    !!! success "Both tables should exist and return results"
        - The pipeline cleaned the data and built the trusted output automatically.


---

In this exercise, you built a pipeline to orchestrate the HomeSphere ETL process automatically. Rather than running notebooks by hand, a single pipeline run cleaned the data and built the trusted output in sequence.

!!! info "Keep your workspace"
    Don't delete anything - your workspace, lakehouse, and pipeline are all needed for the next lab.
