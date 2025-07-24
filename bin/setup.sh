#!/bin/bash

MODULE=$(basename $PWD)

# Git check must pass before this is run
git-check
if [ $? -ne 0 ]; then
  echo -e "\nERROR: git-check must pass BEFORE this can be run!"
  exit 1
fi

# MkDocs for the MODULE
echo "Create mkdocs.yaml for ${MODULE} ..."
uthisha-export --module "${MODULE}" --format "mkdocs" > mkdocs.yml

# Agenda for the DAY
echo -e "\nCreate daily agenda for  ${MODULE}:\n"
for i in {1..4}; do
  echo "uthisha-export --module ${MODULE} --format day-md --day-code D${i}"
        uthisha-export --module ${MODULE} --format day-md --day-code D${i} > "docs/tne/day${i}.md"
done

# Run git check again to see if files were changed
git-check
if [ $? -eq 0 ]; then
  echo -e "\nINFO: No files were changed."
  exit 0
fi

# Commit and push changes to GitHub
git add .
git commit -m "Updated files for MkDocs"
git push

# Run git check again
git-check

# Note to run mkdocs
echo -e "\nNOTE: Remember to run 'mkdocs gh-deploy' to push these changes!\n"

#EOF
