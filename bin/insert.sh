#!/bin/bash

day1_desc=" Day 1 - ETL Foundations in Python"
day2_desc=" Day 2 - Visual ETL Design"
day3_desc=" Day 3 - Production ETL Patterns"
day4_desc=" Day 4 - Advanced ETL & Modern Architecture"

course_code="DE5"
course_desc="${course_code} ~ Data Enginering"

module_code="${course_code}M3"
module_desc="Data Processing, Transformation & ETL"

directory="/mnt/ssd/Applications/uthisha"
database="schedule.db"

sqlite3 ${directory}/${database} <<EOF
DELETE FROM day_descriptions WHERE module_code = '${module_code}';

INSERT INTO day_descriptions VALUES
('${module_code}D1','${day1_desc}','${module_code}','${module_desc}','${course_code}','${course_desc}'),
('${module_code}D2','${day2_desc}','${module_code}','${module_desc}','${course_code}','${course_desc}'),
('${module_code}D3','${day3_desc}','${module_code}','${module_desc}','${course_code}','${course_desc}'),
('${module_code}D4','${day4_desc}','${module_code}','${module_desc}','${course_code}','${course_desc}')
EOF

