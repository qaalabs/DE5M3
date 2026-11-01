## Checks Build

Notebook practical - "Make it safe to run". Checks run on sales_raw before cleaning.

Activities:

- Parts 1-2: fail loudly on bronze (4 x if/raise), then collect into an errors list
- Parts 3-5: functions, clean then re-check on silver, one raise at the end

- Treat the whole notebook as stretch - day 4, they go as far as they can. The next block doesn't depend on it
- No solution in the learner repo - tell them up front so it's not a surprise. Sample answers: day4/checks-solution.md (not in nav)
- Really new to Python? Point them to day1/python101.ipynb or day1/pandas101.ipynb instead
- Demo TODO 1 live (null product_id) - it fires straight away; use if/raise, not assert
- Part 5 ties to Day 2's Track Failure - a notebook only fails if it raises
- Debrief before break: stop / warn / quarantine - does the answer change between bronze and silver?
