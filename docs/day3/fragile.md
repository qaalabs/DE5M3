# Design Debts: Explain, Challenge, Improve

!!! abstract "K13: The implications of financial, strategic and compliance regarding to security, scalability, compliance and cost of local, remote or distributed solutions."

A **design debt** is a limitation that creates risk or makes a pipeline harder to operate, maintain or extend.

## Start from what you know

Use the Day 2 S8 annotation and design question you revisited this morning. You have already investigated the issue; use that explanation rather than repeat the diagnosis.

Your starting point is the **Day 2 Fabric pipeline**: raw files in `Files/data`, managed cleaned and trusted tables, and two ETL notebooks connected by pipeline dependencies. You initiate the pipeline run manually. The later runs used the supplied solution notebooks and their `_solution` tables.

The local API extraction you explored this morning is a separate change. You can use it or the metadata demonstration to inform a proposed improvement, but do not assume either is already part of the Day 2 Fabric build.

## Unpack K13

K13 asks you to understand **implications**, including financial and strategic consequences and considerations of security, scalability, compliance and cost across local, remote or distributed solutions.

For this activity, use the implications relevant to your issue. A missing batch may affect reported revenue or decisions; it does not by itself establish a security incident or compliance breach. Identify assumptions and questions you would need to check. This activity contributes to K13 without covering every part of it.

## Explain individually

Extend your existing notes with one short explanation:

> The issue I investigated reveals… My observation supporting this is… For HomeSphere, this could mean… I would improve… This would help because… It would still leave…

Make the consequence plausible and specific to HomeSphere. Include one trade-off, such as extra processing, maintenance or cost, where relevant. If the cause remains uncertain, state what needs checking before recommending a change.

## Challenge the explanation together

Take turns explaining your reasoning in your group. Help each other check:

- Does the observation support the claimed design limitation?
- Does the proposed improvement address it, and is the consequence plausible?
- What remains unresolved, or what trade-off does the improvement introduce?

Challenge the reasoning respectfully. Use your code, recorded results and the pipeline description to resolve disagreements; mark anything you cannot settle for trainer feedback.

## Revise and retain

Improve your own explanation after the peer review. Keep a few useful bullets in your personal notes, including the relevant K13 implication and any change to your reasoning. No separate worksheet or repeated run table is needed.

As a group, choose one explanation to contribute to the design review. Another group can test its reasoning; everyone can use that challenge to correct their own notes.

## Prepare for the next activity

When medallion architecture is introduced, test which of your design debts it could address and which need other measures. Clear layers and reusable tables can improve organisation and reuse; naming layers alone would not prevent the silent data losses you observed.
