# From Troubleshooting to Design Review

On Day 2, you ran the HomeSphere pipeline in Fabric and investigated cases where execution status did not tell you whether the output was correct. Today you will use that learning to judge and improve its design.

## Start with your own investigation

Revisit your Day 2 **S8** annotation and the unresolved issue you marked. S8 asks you to **identify and troubleshoot issues with data processing pipelines**.

Work individually:

> You explained an issue and traced its cause. What does it reveal about the pipeline's design?

Mark that design question beside your existing notes. You do not need to rewrite the diagnosis or propose a solution yet. If the cause is still uncertain, carry that uncertainty into your question.

## Check against what exists

Use the diagram from the Mermaid introduction to locate the part of the pipeline your question concerns.

The Day 2 build already has:

- Raw source files in **Files/data**, with cleaned and trusted output stored as managed **Tables**.
- Two ETL notebooks, with a saved cleaned Sales table that the output notebook reads.
- A pipeline with dependencies controlling notebook execution after you start the run manually.
- Inspection outputs and queries you used to check results, but no automatic checks that prevented the silent data losses you investigated.

The diagram uses `cleaned_sales` and `sales_trusted` to show the data flow. Your later pipeline investigations used the corresponding `_solution` tables written by the supplied notebooks.

Adjust your question if it assumes a feature is missing when it already exists. Mark any gap you need help to resolve.

## Carry the question forward

In the design-debt activity, you will consider the consequences of the limitation and evaluate an improvement. This develops your reasoning towards **K13**, which concerns the financial, strategic and compliance implications of solutions, including security, scalability and cost.

Keep this question with your notes as you explore metadata and API extraction. Those activities may inform your reasoning; the design review will use the Day 2 Fabric pipeline as its starting point.

