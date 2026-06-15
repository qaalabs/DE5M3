# DE5M3 - Data Processing, Transformation & ETL

## Day 1 - Building the pipeline locally

Day 1 is where you meet the project you'll be working on for the whole module and start building a data pipeline from scratch, using Python in a Jupyter notebook on your virtual machine.

### Morning - Exploring and cleaning the data

After getting set up, you'll be introduced to HomeSphere - a fictional smart home company whose messy, multi-source data you'll be working with across all four days. A short warm-up in a Python notebook makes sure you're comfortable with the environment before the real work begins.

The morning's main focus is two raw data files: a sales orders CSV and a product catalogue JSON. You'll inspect each one in turn - not to fix anything yet, but to understand what is in them, what is missing, and what looks wrong. A short class discussion lets you compare what everyone found before you move into cleaning the sales data. The cleaning step involves real quality issues: missing values, inconsistent formats, and records that need a judgement call, not just a rule.

### Afternoon - Joining, analysing, and investigating

After lunch you'll learn why the product catalogue needs to be reshaped (flattened) before it can be joined to the sales data, and you'll do that join yourself. The result is a single trusted dataset that combines both sources. You'll use it straight away to answer a business question: which product categories generate the most revenue?

The day closes with a group investigation into the product side of the pipeline, looking at what an ETL approach might look like for a different source. Groups share their findings, and the class reflects on what Day 1 has covered and what is coming next.

---

## Day 2 - Moving the pipeline to the cloud

Day 2 takes the pipeline you built locally and moves it into Microsoft Fabric, a cloud data platform. The logic stays the same - the environment changes. By the end of the day you'll have a working cloud pipeline and a clear view of what that buys you and what it doesn't.

### Morning - Getting oriented in Fabric

You'll start by exploring the Fabric Lakehouse environment - the cloud equivalent of the local file and notebook setup from Day 1. You'll land your raw data files into the Lakehouse, then run your cleaning steps in the cloud. A discussion helps you identify what felt familiar and what felt different. A breakout activity then asks you to research different approaches to data architecture and think about the trade-offs between them.

### Afternoon - Building and comparing

The afternoon builds out the full cloud pipeline - creating the trusted output dataset and connecting the steps into an end-to-end ETL pipeline inside Fabric. You'll then do a structured comparison of the local and cloud approaches across four dimensions: security, scalability, governance, and cost. The day closes with an honest reflection on what is working well in the cloud pipeline - and what is brittle or poorly designed.

---

## Day 3 - Redesigning for robustness

Day 3 is a design day. You are not starting from scratch - you are looking critically at the pipeline you have built and refactoring it into something more reliable and better structured. The pattern you'll learn and apply is called medallion architecture, which organises data into three layers: bronze, silver, and gold.

### Morning - APIs, weaknesses, and the medallion pattern

The morning opens with a review of where Day 2 left off, followed by two short sessions on techniques from the Day 2 extensions: adding metadata to a file and reading data from a live API. You'll then get hands-on with a live API yourself using Swagger, making real requests and working with the responses.

After the break, the focus shifts to your existing pipeline. In a group activity you'll identify where it is fragile - places where it could fail silently, produce wrong results, or be hard for someone else to take over. That discussion leads into an introduction to medallion architecture. Before lunch you'll map the HomeSphere pipeline onto the three layers and discuss what would need to move and why.

### Afternoon - Rebuilding and applying to new scenarios

After setting up a fresh Fabric environment, you'll refactor the HomeSphere pipeline into bronze, silver, and gold layers. This is the main lab of the day and brings together everything from the morning. A group discussion follows on what is genuinely better about the refactored version.

The day closes with a group scenarios exercise. Four industry groups - e-commerce, healthcare, banking, and manufacturing - each apply medallion thinking to a different set of data sources and business problems, then report back to the class. This gives you a chance to see how the same pattern applies in very different contexts, before Day 4 focuses on making the pipeline supportable.

---

## Day 4 - Making the pipeline supportable

Day 4 answers a question that rarely comes up in early data work: what happens after you build it? You'll add validation to catch problems, write the documentation a new engineer would actually need, and practise explaining your work to someone who is not a data engineer.

### Morning - Validation checks and a handover document

The morning starts with a discussion about silent failures - situations where bad data passes through the pipeline without raising an error, and nobody notices until something downstream goes wrong. You'll design which checks matter most for the HomeSphere pipeline, then build them into your notebooks.

After the break, the focus shifts to documentation. The idea of a "minimum viable document" - the least you could write and still leave someone else able to support this pipeline - frames the activity. You'll produce a handover artefact covering what the pipeline does, the layer structure, the run order, and the known limitations. You'll then review a partner's artefact, reading it as if you were the engineer arriving on Monday morning.

### Afternoon - Explaining your work

The afternoon changes the audience. You'll prepare a short explanation of the HomeSphere pipeline aimed at a non-technical stakeholder - someone who needs to understand what it does and why it matters, but not how it works in detail. Groups share their explanations and discuss what made the difference between a clear explanation and a confusing one.

The day closes with a look at what a more mature version of this pipeline might include, a full module retrospective, and a short evaluation.
