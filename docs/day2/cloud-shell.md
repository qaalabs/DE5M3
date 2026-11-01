# Run the ETL Script in the Cloud

!!! abstract "K14: The uses of on-demand Cloud computing platform(s) in a public or private environment such as Amazon AWS, Google Cloud, Hadoop, IBM Cloud, Salesforce and Microsoft Azure."

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."

Yesterday you ran the HomeSphere pipeline as a single script, from the terminal on your Virtual Machine.

Now you run the same script, unchanged, on a machine in Microsoft Azure.

---

## Open the Azure portal

1. In the QA Platform, select **Open** on the Microsoft Fabric Playground lab.

2. Sign in with the lab account details shown in the QA Platform.

    The Azure portal home page opens.

---

## Start Cloud Shell

1. In the top bar of the Azure portal, select the **Cloud Shell** icon (it looks like `>_`).

2. When asked to choose an environment, select **Bash**.

3. In the **Getting started** pane:

    - Select **No storage account required**
    - Leave the subscription as the default
    - Select **Apply**

    After a few seconds, a terminal opens at the bottom of the page.

    !!! info "Cloud Shell is a small Linux machine in Azure, which you use through your browser. Nothing is installed on your Virtual Machine."

---

## Get the code

Clone the M3 repository and move into it:

```
git clone https://github.com/QAADE5/M3.git
cd M3
```

!!! tip "Linux folder names are case-sensitive: `cd m3` will not work. Use a capital `M`."

---

## Install pandas

Cloud Shell has Python, but not pandas. Install it:

```
pip install --user pandas
```

!!! note "Without `--user`, the install fails. You do not have admin rights on this machine, so pandas is installed for your user only."

---

## Run the script

Run the same script you ran yesterday:

```
python day1/stretch/etl_solution.py
```

!!! note "Linux paths use forward slashes `/`, not the backslashes `\` you used on Windows."

The script prints a revenue summary at the end, and saves `cleaned_sales.csv` and `sales_joined.csv` in the `stretch` folder.

Check the files are there:

```
ls day1/stretch
```

---

## Check the answer

Look at the **Revenue by Category** table at the bottom of the output.

- Does it match the answer you got yesterday?
- What did you have to change in the script to make it run in the cloud?

---

## Think about it

The script ran in the cloud. But is it a cloud data pipeline?

- Where are `cleaned_sales.csv` and `sales_joined.csv` saved? Who else can see them?
- You chose **No storage account required**. What happens to the files when you close Cloud Shell?
- Who starts the script? What happens if nobody is logged in?
- If the script failed overnight, how would anyone find out?

Keep your answers. You will come back to them as you build the same pipeline in Microsoft Fabric.
