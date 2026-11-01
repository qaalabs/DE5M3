## Run the Pipeline Locally

Script version of the checks notebook - day4/pipeline.py runs, learners edit day4/checks.py

Activities:

- Part 1: run it - clean run, 30 rows in, 23 out, nothing complains
- Part 2: uncomment the notebook checks in get_failures() (Ctrl+/) - pipeline stops before cleaning. Provided so it doesn't depend on finishing the notebook
- Part 3: echo $LASTEXITCODE shows 1 - same signal as Day 2's Track Failure
- Part 4: move checks to get_warnings() until it completes
- Stretch: get_silver_failures() after cleaning; rejected.csv; timestamp

- Part 4 is the point: most bronze problems are already handled by cleaning, so stopping on them means the pipeline never runs. Failures are for what cleaning can't fix (3 rows, missing column)
- If $LASTEXITCODE shows nothing, they are in cmd not PowerShell - echo %errorlevel%
- Hints for the stretch extras: day4/solution-snippets.txt in the learner repo
