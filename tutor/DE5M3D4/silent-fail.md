## Silent Fail

Four HomeSphere scenarios - run through together as a group, not independent reading

- A: row count drops (12 rows not 30), nothing alerts
- B: date format changes, to_datetime mis-parses silently
- C: unmatched product_id silently dropped from join, revenue understated
- D: £ symbol causes silent NaN, row dropped
- Learners fill the table: what went wrong, what check, where in the pipeline
