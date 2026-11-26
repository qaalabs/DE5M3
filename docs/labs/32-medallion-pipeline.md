# Lab 3.2 ~ Orchestrate the Medallion Notebooks with a Pipeline

!!! abstract "S4: Automate data pipelines such as batch, real-time, on demand and other processes using programming languages and data integration platforms with graphical user interfaces."

!!! info "This lab continues from Lab 3.1. You need your workspace, your `HomeSphere` lakehouse and both medallion notebooks."

At the end of Lab 3.1 you had two notebooks that must run in order:

1. `HomeSphere - Bronze to Silver`
2. `HomeSphere - Silver to Gold`

Someone still has to remember to run them, in the right order, every time new data arrives. In this lab you hand that job to a pipeline, then schedule it so nobody has to press **Run** at all.

You built a pipeline on Day 2, so the steps will feel familiar. This time you build it on the medallion design.


## Step 1: Stop any running notebook sessions

The pipeline starts its own session for each notebook. If your notebooks are still running a session, the pipeline may fail with a `TooManyRequestsForCapacity` error.

1. In the left navigation bar, select **Monitor**.

2. If any notebook shows as **In progress**, open it and use the :material-stop: (*Stop session*) button.


## Step 2: Create a pipeline

1. In the left navigation bar, select your workspace name to return to the workspace view.

2. Select **New item**, then search for and select **Pipeline**.

3. Name the pipeline: `HomeSphere Medallion Pipeline`

    !!! success "The pipeline designer canvas should open, ready for you to add activities."


## Step 3: Add the two notebook activities

1. In the pipeline canvas you should see: **Start with a blank canvas**

    - Select: **Pipeline activity**
    - Choose: **Notebook** (scroll down - it should be under the *Transform* heading)

2. In the activity properties pane below the canvas:

    - Set the **Name** to: `Bronze to Silver`

3. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `HomeSphere - Bronze to Silver`

4. Click the **Activities** tab and add a second **Notebook** activity to the canvas.

5. In the properties pane:

    - Set the **Name** to: `Silver to Gold`

6. Select the **Settings** tab and configure the following:

    - **Workspace**: *select your workspace*
    - **Notebook**: select `HomeSphere - Silver to Gold`

7. On the **Home** tab, click **Save**.


## Step 4: Connect the activities

1. Hover over the **Bronze to Silver** activity until small coloured arrows appear at its corners.

2. Drag the **green** (on success) arrow to the **Silver to Gold** activity.

!!! note "Why on success?"
    Gold must only ever be built from silver that passed its validation checks. If a check in **Bronze to Silver** fails, the notebook fails, and **Silver to Gold** never runs - so yesterday's gold stays in place instead of being rebuilt from bad data.


## Step 5: Run the pipeline

1. On the **Home** tab, use the :material-content-save: (*Save*) icon to save the pipeline.

2. Use the :material-play: **Run** button to run the pipeline.

3. Monitor the progress in the **Output** pane below the canvas.

    - Use the :material-refresh: (*Refresh*) icon to refresh the status.
    - Wait for both activities to show a green tick.

!!! success "Bronze to Silver and Silver to Gold should both show as **Succeeded**."


## Step 6: Verify the gold table

1. In the left navigation bar, return to your **HomeSphere** lakehouse.

2. Select **Analyze data with** and choose **SQL analytics endpoint**.

3. Run the same query you used in Lab 3.1:

    ```sql
    SELECT
        category,
        ROUND(SUM(line_value), 2) AS total_revenue,
        COUNT(*) AS order_lines
    FROM gold_revenue
    GROUP BY category
    ORDER BY total_revenue DESC
    ```

    !!! note
        The numbers should match Lab 3.1 - the pipeline ran exactly the same notebooks. What changed is *who* ran them.


## Step 7: Schedule the pipeline

A pipeline you have to run by hand is only half automated. A schedule removes the last manual step.

1. Return to your `HomeSphere Medallion Pipeline`.

2. On the **Home** tab, select **Schedule**.

3. Add a schedule that runs the pipeline **every 10 minutes**:

    - Turn the schedule **On**
    - **Repeat**: *By the minute*
    - **Every**: `10` minutes
    - Leave the start date and time zone as they are

4. Select **Apply**.

5. In the left navigation bar, select **Monitor**. After the next scheduled time passes, a new run of `HomeSphere Medallion Pipeline` should appear - this time with no one pressing **Run**.

!!! warning "Turn the schedule off when you have seen a scheduled run"
    Return to **Schedule**, turn it **Off** and select **Apply**. A pipeline running every 10 minutes uses capacity that the rest of the group needs.


## Discussion

- At the end of Lab 3.1 the group listed what was still not good enough. Which of those points has this pipeline fixed?
- What is *still* manual? Think about how the files got into `bronze`.
- Your schedule runs every 10 minutes, whether or not new data has arrived. Is that a problem? What would be better?
- If **Bronze to Silver** fails at 3am, who finds out - and how?


---

In this exercise, you orchestrated the medallion notebooks with a pipeline, so bronze to silver to gold runs in the right order with no one running notebooks by hand - and on a schedule, with no one pressing **Run** at all.

!!! info "Keep your workspace"
    Don't delete anything - your workspace, lakehouse, and `gold_revenue` table are needed for [Lab 3.3](33-powerbi-report.md).

    When you have finished, follow the [clean up steps at the end of Lab 3.3](33-powerbi-report.md#clean-up-resources).
