#!/bin/bash

# See if VENV is activated
filename=$(whereis jupyter | cut -d" " -f2)
if [[ ! -f ${filename} ]]; then
  echo "ERROR: Program not found - jupyter"
  exit 9
fi

FROM="/mnt/ssd/projects/QAADE5/HomeSphere"
dirname=${FROM}
if [[ ! -d ${dirname} ]]; then
  echo "$0 ERROR: Directory does not exist - $dirname"
  exit 1
fi

DESTINATION="/mnt/ssd/projects/qaalabs/DE5M3/data"
dirname=${DESTINATION}
if [[ ! -d ${dirname} ]]; then
  echo "$0 ERROR: Directory does not exist - $dirname"
  exit 1
fi

SCRIPT="ipynb-to-markdown.sh"
filename="/mnt/ssd/ops/${SCRIPT}"
if [[ ! -f ${filename} ]]; then
  echo "$0 ERROR: File does not exist - $filename"
  exit 1
fi

# Convert each file
find ${FROM} -type f -name "*.ipynb" | while IFS= read -r file; do
  /mnt/ssd/ops/${SCRIPT} $file ${DESTINATION}
done

#EOF
