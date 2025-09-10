# Apply activity ~ Document

## Develop and document a simple automated data pipeline

### Develop
- actually build something working. Not a diagram only.

### Simple automated data pipeline
- a flow of data from source → some transformation → destination, that runs with little or no manual intervention.

  * Example: CSV file in storage → transform columns → load into a database or data warehouse.
  * "Automated" means it can be triggered (scheduled, event-based, or scripted) without clicking through steps every time.

### Document
- write up what was done, with explanations, screenshots, or code comments so others can understand and reproduce it.

---

## Using a programming language and a graphical data integration platform

Need to show *both* approaches in the same task:

### Programming language
- e.g. Python, SQL, or even PySpark. They might code an ETL script.

### Graphical data integration platform
- drag-and-drop tool like SSIS, Talend, Azure Data Factory, AWS Glue Studio, Google Dataflow (with GUI), or even Alteryx.

*The expectation is to compare or combine both, not just stick to one.*

---

## Highlight the security, scalability, and governance measures implemented

This is the "so what?" part. Not just show the pipeline works, but also explain *how it meets enterprise standards*. 

For example:

### Security

* Use of secure connections (SSL, HTTPS).
* Masking or excluding sensitive data.
* Role-based access control (who can run or edit pipeline).

### Scalability

* Ability to process more data (parallelism, cloud scaling, batch vs streaming).
* Configurable so it’s not hard-coded to just one file.

### Governance

* Logging what happened (audit trail).
* Version control of code/pipeline definitions.
* Clear documentation of lineage (where data came from, where it went).

Don't have to solve these perfectly but must show *awareness*.

---

> Build a small end-to-end data pipeline twice: once by writing code, and once using a drag-and-drop data integration tool. Show how the pipeline runs automatically. Then explain what steps you took (or could take) to keep it secure, make it able to scale, and ensure it is properly governed.

