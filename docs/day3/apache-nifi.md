# Lab 3.2 - Apache NiFi: Your First Data Pipeline

## Overview

Apache NiFi is an open-source data flow tool used to move and route data 
between systems. It is used across industries for data ingestion, routing, 
and basic transformation.

In this lab you will build a simple pipeline that reads a CSV file, 
processes it through NiFi, and writes it to an output directory. You will 
watch data move through the pipeline in real time.

## Learning Objectives

- Understand how NiFi fits into the data engineering tool landscape
- Build a simple Extract → Load pipeline using a visual canvas
- Observe real-time data flow monitoring

## Before You Start

Make sure NiFi is running. Open a terminal and check:

```bash
docker ps
```

You should see the NiFi container listed. Then open your browser and go to:

https://localhost:8443/nifi

Accept the certificate warning and log in:

- **Username**: admin
- **Password**: admin123456789

## Step 1 - Prepare Your Data

Open a terminal and run the following commands to create your working
directories and sample data file:

```bash
mkdir -p /tmp/nifi-input /tmp/nifi-output
```

```bash
cat > /tmp/nifi-input/customers.csv << 'EOF'
customer_id,first_name,last_name,email,status
1001,John,Smith,john@email.com,active
1002,Jane,Doe,jane@email.com,active
1003,Mike,Johnson,mike@email.com,inactive
1004,Sarah,Wilson,sarah@email.com,active
1005,Bob,Brown,bob@email.com,suspended
EOF
```

Verify the file is there:

```bash
cat /tmp/nifi-input/customers.csv
```

## Step 2 - Add the GetFile Processor

The **GetFile** processor is the Extract step - it reads files from a
directory on the local file system.

1. In the NiFi toolbar at the top of the screen, drag the **Processor**
icon onto the canvas
2. In the search box type `GetFile`
3. Select **GetFile** and click **Add**
4. You will see the processor appear on the canvas with a yellow warning
triangle - this is normal until it is configured

**Configure GetFile:**

1. Double-click the GetFile processor to open the configuration panel
2. Click the **Properties** tab
3. Set the following properties:

| Property | Value |
|---|---|
| Input Directory | `/tmp/nifi-input` |
| Keep Source File | `true` |

4. Click **Apply**

> Setting **Keep Source File** to `true` means NiFi will not delete your
> input file after processing. Useful for testing.

## Step 3 - Add the LogAttribute Processor

The **LogAttribute** processor logs information about each file that passes
through it. This lets you see the pipeline working in real time.

1. Drag another **Processor** onto the canvas
2. Search for `LogAttribute`
3. Select **LogAttribute** and click **Add**
4. Double-click to configure it
5. No properties need changing - click **Apply**

## Step 4 - Add the PutFile Processor

The **PutFile** processor is the Load step - it writes files to a directory
on the local file system.

1. Drag another **Processor** onto the canvas
2. Search for `PutFile`
3. Select **PutFile** and click **Add**
4. Double-click to configure it
5. Click the **Properties** tab
6. Set the following properties:

| Property | Value |
|---|---|
| Directory | `/tmp/nifi-output` |
| Conflict Resolution Strategy | `replace` |

7. Click **Apply**

## Step 5 - Connect the Processors

Now connect the three processors to create the pipeline flow.

1. Hover over the **GetFile** processor until you see a grey arrow appear
in the centre
2. Drag the arrow to the **LogAttribute** processor
3. A connection dialog will appear - select **success** and click **Add**
4. Repeat - hover over **LogAttribute**, drag to **PutFile**
5. Select **success** and click **Add**

You should now have three processors connected in a line:

GetFile → LogAttribute → PutFile

**Handle the unmatched relationship on LogAttribute:**

LogAttribute has a `success` output that you have connected. But it also
has other outputs that need to be handled. Right-click **LogAttribute** and
select **Configure**. Under the **Relationships** tab, tick
**Automatically Terminate** for any unconnected relationships.

Do the same for **PutFile**.

## Step 6 - Start the Pipeline

1. Click on an empty area of the canvas to deselect everything
2. Right-click the canvas and select **Start**
3. All three processors will turn green

Watch the **connections between processors** - you will see numbers appear
showing how many files are queued between each step.

## Step 7 - Verify the Output

Open a terminal and check the output directory:

```bash
ls /tmp/nifi-output/
cat /tmp/nifi-output/*
```

You should see your customers.csv file has been processed and written to
the output directory.

## Step 8 - Stop the Pipeline

Right-click the canvas and select **Stop**.

> Always stop your pipeline when you are done. A running GetFile processor
> will keep polling the input directory continuously.

## Step 9 - Export Your Flow Definition

NiFi saves your pipeline as a JSON file called a **flow definition**. This
is how flows are moved between environments in production - from development
to test to production.

1. Right-click on the canvas
2. Select **Download flow definition**
3. Open the downloaded JSON file in a text editor

You will see your pipeline described in JSON - every processor, every
property, every connection is captured in this file.

```json
{
  "formatVersion": 1,
  "flowContents": {
    "processors": [
      {
        "name": "GetFile",
        "type": "org.apache.nifi.processors.standard.GetFile",
        "properties": {
          "Input Directory": "/tmp/nifi-input",
          "Keep Source File": "true"
        }
      }
    ]
  }
}
```

This file can be:

- Stored in **version control** (Git) alongside your other pipeline code
- Imported into another NiFi instance using **Upload template**
- Deployed to a production NiFi cluster by your infrastructure team

> In production, NiFi flows are version controlled in **NiFi Registry** -
> a separate service that works like Git specifically for NiFi flow
> definitions. What you have just exported is the development version of
> what would be promoted through dev → test → production environments.

## What This Means in Practice

The visual pipeline you built today is not just a learning exercise. The
same flow definition file could be deployed to a cluster of NiFi nodes
running in production, processing millions of records per day.

This is the bridge between development and production - and it connects
directly to **K8** in your KSBs: deployment approaches for new data
pipelines.

---

## What You Have Built

```
/tmp/nifi-input/customers.csv
↓
[ GetFile ]        ← Extract
↓
[ LogAttribute ]     ← Monitor
↓
[ PutFile ]        ← Load
↓
/tmp/nifi-output/customers.csv
```

This is a complete Extract → Load pipeline built entirely visually with no
code written.

## Reflection Questions

Think about these before the debrief discussion:

1. How does building this pipeline in NiFi compare to writing Python code
on Day 1?
2. What does NiFi show you that Python could not?
3. NiFi is open source and runs anywhere. Fabric runs in Microsoft's cloud.
What are the implications of that difference for a business?
4. Where in your organisation could a tool like NiFi be useful?

## Extension - L3 and L4 Learners

If you have finished early, explore the following:

- Add a second **PutFile** processor and route the flow so the file is
written to two different output directories simultaneously
- Look at the **Provenance** view (top right menu) - this shows the complete
history of every file that has passed through NiFi. This is **data lineage**
- a record of where data has been and what happened to it
- Search for the **FetchHTTP** processor - what do you think this does?
How could it replace the API calls from Day 1?





