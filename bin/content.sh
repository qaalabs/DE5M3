#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "The script expects at least one input. Exiting"
    exit 1
fi
DAY=$1
MODULE="$(basename $PWD)"

directory="/mnt/ssd/Applications/uthisha"
database="schedule.db"

sqlite3 ${directory}/${database} <<EOF
SELECT 'touch content/'||'${DAY}/'||lower(content_code)||'.md'
FROM schedule_blocks 
WHERE day_code = '${DAY}'
EOF

sqlite3 ${directory}/${database} <<EOF
SELECT
  'echo "**'||c.content||'** - https://barbourians.github.io/'||'${MODULE}/'||
  REPLACE(c.linkfile, '.md', '/')||
  '" >> content/'||'${DAY}/'||lower(sb.content_code)||'.md'
FROM schedule_blocks sb
LEFT JOIN content c
  ON sb.day_code = c.day_code AND sb.content_code = c.content_code
WHERE sb.day_code = '${DAY}'
AND c.linkfile is not null 
and c.linkfile != ''
EOF


