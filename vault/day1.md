# Day 1
Objective: **we have raw data, it is messy, and by the end of the day we have made it usable.**

## Day 1 - Make it work

**Holding question**
How do we take messy source data and turn it into something usable?

**Main sources**

* Sales
* Product

**Main outcome**
A trusted order-level dataset with product detail.

**Business-facing proof**
Use that dataset to answer a simple question such as:
which product categories are generating the most revenue?

---

## Welcome

**Purpose**
Set the scene and make the day feel purposeful.

**What you do**

* Introduce HomeSphere
* Explain that Module 3 focuses on the middle of the lifecycle: source data already exists, and our job is to ingest, transform, and prepare it for use
* Show the two Day 1 raw sources:

  * Sales
  * Product
* Explain the finish line for the day:

  * not a dashboard
  * not a perfect warehouse
  * a trusted joined dataset

**Key message**
Today is about making the first working path from raw data to useful data.

---

## Session 1 - Meet the raw data

**Purpose**
Learners touch the sources and notice what is wrong before they start fixing anything.

**Content**

* What is a raw source?
* Why raw data is rarely analysis-ready
* What “landing” or ingesting data means in simple terms

**Learner activity**

* Open the Sales data
* Inspect columns, values, row counts, missing values, odd formats, duplicates
* Ask: what would stop us using this confidently?
* Then introduce Product as a second source and inspect its structure
* Notice that Product is JSON and has nested fields

**Debrief questions**

* What quality problems did you spot in Sales?
* What is different about Product compared with Sales?
* Why would it be risky to go straight from this raw data to reporting?

**Output from the session**

* A shared list of data quality issues
* A first understanding of the two source shapes

---

## Session 2 - Clean the Sales data

**Purpose**
Turn raw Sales into something more trustworthy.

**Content**

* Transforming data as a response to specific problems
* Typical cleaning moves:

  * nulls
  * types
  * duplicates
  * standardisation
* Keep the teaching tied to the actual data, not generic theory

**Learner activity**

* Clean the Sales dataset
* Fix data types
* Handle missing values where appropriate
* Remove or identify duplicates
* Standardise fields such as dates or status values
* Add one or two simple validation checks

**Your role**

* Model the first step or two
* Let learners complete the rest with support
* Keep asking why each transformation is needed

**Debrief questions**

* Which fixes were straightforward?
* Which fixes required judgement?
* What is now better about the data?

**Output from the session**

* A cleaned Sales dataset - effectively the first silver-style output, even if you do not name it that yet

---

## Session 3 - Flatten Product and join the sources

**Purpose**
Show that not all sources look the same, and that value comes from combining them.

**Content**

* Why nested JSON needs flattening
* Why joining sources creates more useful data than cleaning one source in isolation

**Learner activity**

* Flatten the Product JSON into a usable table
* Select the fields needed for Day 1
* Join cleaned Sales to Product on product ID
* Create the trusted order-level dataset with:

  * customer
  * order date
  * product name
  * category
  * quantity
  * line value

**Debrief questions**

* What did Product add that Sales alone could not provide?
* What problems can happen when joining sources?
* Why is this dataset more useful than the raw files?

**Output from the session**

* Trusted order summary with product detail

---

## Session 4 - Use it and reflect

**Purpose**
Let learners see the business value of what they built and begin noticing fragility.

**Content**

* A usable dataset should answer questions
* A working pipeline is good, but not the same as a robust one

**Learner activity**

* Use the trusted dataset to answer a simple business question:

  * which product categories generate the most revenue?
* Then review the pipeline in groups:

  * what worked?
  * what still feels brittle?
  * what depends too much on manual steps?
  * what would be hard for someone else to understand?

**Debrief questions**

* What is the value of the final dataset?
* What would break if new data arrived tomorrow?
* What feels untidy or fragile in the current approach?

**Output from the session**

* A simple business answer from the joined dataset
* A first list of weaknesses to carry forward

---

## Wrap-up

**Purpose**
Close the day and point to Day 2.

**Summarise**

* We started with raw Sales and Product data
* We cleaned and reshaped them
* We joined them into a trusted dataset
* We proved it could answer a business question
* Tomorrow we take the same pipeline into the cloud

---

## What learners should leave with

By the end of Day 1, learners should be able to say:

* I can inspect a raw source and spot quality issues
* I can clean structured data into a more trustworthy form
* I can flatten a semi-structured source
* I can join sources to create a more useful dataset
* I can explain why ETL is about making data usable, not just moving it

## What you need prepared

To run this day, I would prepare:

* one Sales raw file or table
* one Product JSON file
* a short list of deliberate issues in each
* a starter notebook or script scaffold
* the final expected columns for the trusted output
* one simple business question for the end

