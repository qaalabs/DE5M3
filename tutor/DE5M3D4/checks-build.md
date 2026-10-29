## Checks Build

Notebook practical - "Make it safe to run". Checks now run on sales_raw before cleaning.

Activities:

- Core: fail loudly on bronze (4 x if/raise), then collect into an errors list
- Stretch: functions, clean then re-check on silver, one raise at the end

- Demo TODO 1 live (null product_id) - it fires straight away; use if/raise, not assert
- Get them to Run All after Part 1 - it stops at TODO 1, one problem per run
- Part 2 should list 5 problems; the missing region question leads into errors vs warnings (next block)
- Part 5 ties to Day 2's Track Failure - a notebook only fails if it raises
- No solution in the learner repo - day 4, they do what they can. Sample answers: day4/checks-solution.md (not in nav)
- Debrief before break: stop / warn / quarantine - does the answer change between bronze and silver?
