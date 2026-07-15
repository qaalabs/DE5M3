## Run the Pipeline Locally

Stretch task after Checks Build - script at day4/pipeline.py

- Part 1: run with no checks active - just seeing it run as a script, terminal output not cells
- Part 2: uncomment a check (Ctrl+/) - pipeline stops, sys.exit(1), no output file
- Part 3: switch to Option B - warning printed, pipeline continues, output file written
- Name the connection: same fail/warn decision they just made in the notebook
- sys.exit(1) - schedulers (cron, Task Scheduler, Fabric pipelines) use this to decide retry/alert
- Stretch: write failing rows to output/rejected.csv instead of printing
