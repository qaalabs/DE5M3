## Day 4 - Supportable & Explainable

**Holding question**
What would it take for someone who did not build this pipeline to run it, trust it, and explain it to a stakeholder?

### Reconnect to the pipeline as it now stands

Start by reminding learners that the business output has not changed since Day 1, but the design has. Day 4 is about what happens after a pipeline is built and structured - can it be trusted, understood, and used by others?

### Validation and trust

Move into the idea that a pipeline can fail quietly. Discuss where silent failures could happen and what simple checks would make the flow more trustworthy. Keep this practical rather than theoretical:

* row counts
* null checks
* duplicate checks
* valid product IDs
* sensible quantities or values

Then let learners decide which checks matter most at different points in the pipeline, especially between bronze and silver, and between silver and gold.

### Minimum viable documentation

Shift from trust to handover. Ask what a new engineer would need in order to make sense of the pipeline without sitting beside the original builder. Focus on just enough documentation:

* what the sources are
* what each layer contains
* what depends on what
* what the gold output is for

A good task here is to get learners to produce a simple handover artefact - a diagram, a table, or a structured note.

### Reviewing documentation through another person’s eyes

Have pairs or small groups look at one another’s handover artefacts and ask whether they would genuinely help someone new orientate themselves. This is a good place for breakout rooms in WebEx because the task is clear and the comparison is useful.

### Explaining it to a stakeholder

Now shift audience. Learners no longer explain the pipeline to another engineer - they explain the business value to a stakeholder. The task is to describe:

* what the trusted output is
* what question it helps answer
* why it is more reliable than the raw sources
* what caveats still remain

The important point is that they should do this without disappearing into bronze/silver/gold language unless it genuinely helps.

### Next maturity steps

Once the pipeline is trusted and explainable, step back and ask what a more mature HomeSphere data team might do next. This is where IoT and Marketing fit nicely - not as core builds, but as honest examples of what further pipeline development could include. This helps show scope and boundaries rather than pretending the module covers everything.

### Module retrospective

Close by making the full journey visible:

* Day 1 - make it work
* Day 2 - make it work in the cloud
* Day 3 - make it more robust and well-architected
* Day 4 - make it supportable and explainable

Ask what learners would now do differently if they started the pipeline again, and where this module sits in the wider lifecycle of the programme.

## In simple terms, the day is really:

* make the pipeline more trustworthy
* make it understandable to another engineer
* make it explainable to a stakeholder
* show where it could grow next
* reflect on the full module journey

---

Possible timings:

Of course - here is a Day 4 outline in the same style as the others.

## Schedule for DE5M3: Day 4 - Supportable & Explainable

09:20  Day 4 (open)
09:30  🌅 Welcome to Day 4 of DE5 Module 3 (welcome)
09:40  Revisit the Day 3 pipeline - same business output, clearer structure - set the holding question: what would it take for someone else to run it, trust it, and explain it?
10:00  Silent failures and trust - where could this pipeline go wrong without anyone noticing? (discussion)
10:20  Decide simple checks for each layer - row counts, nulls, duplicates, valid product IDs, sensible values (practice)
10:40  ☕ Morning Break (break)
11:00  Add or sketch validation checks into the pipeline - what should be checked before data moves from bronze to silver and silver to gold? (practice)
11:30  What checks are essential? What is still unchecked? (discussion)
11:50  Minimum viable documentation - what would a new engineer need to understand first? sources, layers, outputs, dependencies
12:20  🥪🥤 Lunch Break (break)
13:20  Create a simple handover artefact - diagram, table, or structured note showing source -> silver -> gold and what each layer is for (practice)
14:00  Pair or small-group review - would this documentation help someone else orientate themselves? what is missing? (breakout)
14:30  ☕ Afternoon Break (break)
14:50  Explaining the pipeline to a stakeholder - focus on business value, not engineering detail
15:00  Pairs prepare a short explanation of orders_with_detail: what it is, what question it answers, why it is more trustworthy than the raw sources, and any caveats (breakout)
15:20  Share back explanations - what helped build trust, and what confused the message? (report-back)
15:35  Next maturity steps - introduce IoT and Marketing as realistic extensions, not core deliverables - what would a more mature HomeSphere pipeline include? (discussion)
15:45  Module retrospective - what changed from Day 1 to Day 4? what would you now do differently? where does this sit in the wider data engineering lifecycle? (discussion)
15:50  🎁 Wrap (wrap)
16:00  ❌ End of Day 4 (close)

This gives Day 4 a clear shape:

* trust
* handover
* explanation
* future growth
* reflection on the full 4-day journey

