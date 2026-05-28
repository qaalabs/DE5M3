# Facilitator Notes - Next Maturity Steps

*Trainer-only. Session 4, after afternoon break.*
# Facilitator Notes - Next Maturity Steps

*Trainer-only. Session 4, after afternoon break.*
*Aim: 20 minutes.*

---

## Frame it

> "A real pipeline is never finished. The real test of maturity is not whether 
> change happens - it is how well the pipeline copes when it does."

Then present the scenario:

> "HomeSphere's supplier has updated their system. From Monday, `sales_raw.csv` 
> arrives with different column names. `unit_price` is now `price`, `order_date` 
> is now `date`, and there is a new column called `discount` that did not exist before."

> "This is called schema drift. It is one of the most common real-world ETL 
> problems. Take five minutes on your own - not to find the right answer, but 
> to think about how you would respond on Monday morning."

---

## Individual thinking - 5 minutes

Put these questions on screen:

1. What from this week would you reach for first?
2. What does the current pipeline give you that Day 1 did not?
3. What would still be hard - what does the pipeline not yet protect you from?
4. What is the one thing you would add next to make this pipeline more resilient?

---

## Whole room discussion - 15 minutes

Do not go through the questions sequentially. Open it up:

> "Who wants to start - what would you reach for first?"

Let the conversation develop. Things worth drawing out if they do not emerge naturally:

- Bronze means you still have the original file - you can reprocess once you fix the code
- The assert checks would fail loudly rather than silently - you would know immediately
- The documentation means a new engineer knows where to look
- The discount column is interesting - it does not break anything, but it quietly changes what revenue means. That is worth naming as a new kind of risk: silent drift

---

## Close the discussion

> "The point of architecture, validation, and documentation is not to make the 
> pipeline look tidy. It is to make change easier to absorb. That is what maturity 
> means - not a perfect pipeline, but one that is easier to fix, easier to explain, 
> and easier to hand to someone else."

---

## Bridge to retrospective

> "You now know what the pipeline can handle and where its limits are. 
> That is what it means to own a pipeline rather than just build one."
