#!/bin/bash

MODULE=$(basename $PWD)

# Create slides
for i in {1..4}; do
  uthisha-slides --day ${MODULE}D${i} --output-dir /var/www/html/uthisha 
  echo ""
done

#EOF
