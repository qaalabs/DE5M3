# Day 3 - Make it more robust and well-architected

**Holding question**
How do we move from a working pipeline to one that other people can trust, reuse, and maintain?

---

## 1. Reconnect and reposition - 15 to 20 mins

**Focus**
Set up the day as a design day, not just another build day.

**Topics**

* recap Day 2 output
* remind learners what they said still felt fragile
* explain that today is about improving the design, not changing the business result

**Why this matters**
It helps learners see that architecture is a response to real problems, not just a theory topic.

---

## 2. Design review of the current pipeline - 30 to 40 mins

**Focus**
Surface the weaknesses before you introduce the solution.

**Activity**
Whole-class discussion first, then possibly pairs or small groups for 10 to 15 minutes.

**Prompts**

* where are raw and cleaned data mixed together?
* what would be hardest to debug?
* what would be hardest for another engineer to reuse?
* if a new source arrived tomorrow, where would it fit?
* if the gold output looked wrong, where would you investigate first?

**Output**
A visible list of fragilities or design debts.

**WebEx note**
This could work well as:

* 10 mins whole-class framing
* 10 to 15 mins breakout pairs
* 10 mins report-back

---

## 3. Bronze / Silver / Gold as the response - 30 to 40 mins

**Focus**
Introduce medallion architecture only after learners have articulated the need.

**Topics**

* bronze as landed raw data
* silver as cleaned, standardised, validated data
* gold as business-facing output
* why teams separate these layers

**Activity**
Map the current HomeSphere pipeline onto the model.

**Prompts**

* what in our current design is already bronze-like?
* what should count as silver?
* what should be gold?
* what needs to move or be separated?

**Output**
A first architecture map of the current pipeline.

---

## 4. Refactor the pipeline in Fabric - 50 to 70 mins

**Focus**
Take the Day 2 pipeline and improve its structure.

**Topics**

* keeping raw data untouched
* making Silver Sales explicit
* making Silver Product explicit
* making orders_with_detail explicit as gold
* adding a few validation checkpoints

**Learner activity**
Hands-on practical:

* reorganise storage or outputs
* define silver datasets clearly
* produce explicit gold output
* add simple checks

**Example checks**

* key fields not null
* row count sanity check
* valid product IDs before join
* no negative quantities or line values

**Output**
A clearer layered pipeline.

**WebEx note**
This is probably better as individual or pair work rather than full breakout rooms, with you circulating verbally and using screen share when needed.

---

## 5. Pause and interpret the redesign - 15 to 20 mins

**Focus**
Do not rush past the thinking.

**Discussion prompts**

* what is actually better now?
* what has become clearer?
* what has become easier to debug?
* what could another engineer understand more quickly now?

**Output**
Learners can explain why the redesign matters.

---

## 6. Group application to an extension source - 35 to 50 mins

**Focus**
Use breakout rooms to apply the same logic to a tougher source.

**Suggested sources**

* Inventory
* Support

You could assign different groups different sources, or variations of the same source.

**Task**
Each group decides:

* what bronze looks like
* what silver should contain
* what needs cleaning or standardising
* what makes the source awkward
* what gold output it could feed
* what checks should happen before it feeds gold

**Why this is valuable**
This is where learners start using the architecture as a design tool rather than just repeating the example.

**Output**
A short group design explanation.

**WebEx note**
This is the best place for breakout rooms on Day 3.

---

## 7. Report-back and comparison - 20 to 30 mins

**Focus**
Make the differences between sources visible.

**Prompts**

* which source was easier to fit into the layered model?
* which was awkward, and why?
* where did groups make different design choices?
* what does that tell us about real-world ETL design?

**Output**
A class-level view that not every source fits neatly, and that design judgement matters.

---

## 8. Close the day - 10 mins

**Focus**
Bridge to Day 4.

**Key message**
The pipeline still produces the same business result, but it now does so in a clearer and more trustworthy way.

**Bridge**
Tomorrow we ask what it would take for someone else to run it, trust it, and explain it.

---

# A simple structure for the whole day

If you want the day in very plain terms:

* reconnect to Day 2
* critique the current design
* introduce bronze/silver/gold
* refactor the real pipeline
* apply the same thinking in groups
* compare designs
* bridge to Day 4

# Where breakout rooms fit best

I would use breakout rooms for:

* the early fragility discussion
* the extension-source design task

I would not use them for:

* the medallion introduction
* the main refactor practical

Those parts probably work better with you guiding the whole room.

# What makes Day 3 valuable

The value is not in teaching more technology.
It is in helping learners answer:

* why this design?
* why this layer?
* why this check?
* why is this better than what we had yesterday?

That is the intellectual centre of the module.

