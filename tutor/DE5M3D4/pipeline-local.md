## Run the Pipeline Locally

Script is at `day4/pipeline.py`. Learners open it in VS Code, run from the terminal, then switch between fail fast and warn modes.

Three parts:

- Part 1: run with no checks active - pipeline completes, output written. The point is just seeing the pipeline run as a script with terminal output.
- Part 2: uncomment a check - pipeline stops before cleaning, `sys.exit(1)`, no output file. VS Code `Ctrl+/` toggles comments. Both example checks give a clean AssertionError on the raw data.
- Part 3: comment out Option A, uncomment Option B - pipeline runs with a warning, output file written.

The fail/warn decision is the same one they debated in the notebook this morning. Name that connection explicitly before they start.

`sys.exit(1)` is worth a sentence: the exit code tells the OS the pipeline failed - schedulers (cron, Task Scheduler, Fabric pipelines) use this to decide whether to retry or alert.

In Module 6 they will do the same thing with Great Expectations and a live Flask dashboard - fail rules turn rows red, warning rules turn them amber. The concept is identical, the tooling is richer. Worth a one-line forward reference if the group is engaged.

Stretch goal (fast groups): write failing rows to `output/rejected.csv` instead of just printing. A few lines of pandas.
