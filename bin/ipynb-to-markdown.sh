#!/bin/bash

# Convert the notebooks
#for nb in data/*.ipynb; do
  #jupyter nbconvert --to markdown "$nb"
#done

# Copy the markdown to docs/day1
cp data/ETL_data-enrichment_extract.md   docs/day1/extract-notebook.md
cp data/ETL_data-enrichment_transform.md docs/day1/transform-notebook.md
cp data/ETL_data-enrichment_load.md      docs/day1/load-notebook.md

#EOF
