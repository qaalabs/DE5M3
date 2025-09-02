# Group 4: Manufacturing Plant

## Business Context

You work for "Northern Steel Manufacturing" - automotive parts production, 3 production lines, 24/7 operations, 2 million parts annually.

## Current Data Challenges

- Equipment breakdowns cause expensive production delays
- Quality issues discovered too late in the process
- Energy costs are high but poorly understood
- Maintenance is reactive rather than predictive
- Production planning relies on outdated data

## Your Data Sources

### IoT SENSOR NETWORK

- machine_sensors: sensor_id, machine_id, temperature, pressure, vibration, timestamp
- production_line: line_id, production_rate, downtime_minutes, shift_datetime
- quality_sensors: sensor_id, part_id, dimensions, weight, defect_flags

### MAINTENANCE SYSTEM (separate)

- work_orders: order_id, machine_id, issue_type, scheduled_date, completion_date
- spare_parts: part_id, machine_id, stock_level, cost, supplier
- maintenance_history: history_id, machine_id, maintenance_type, technician, notes

### EXTERNAL SYSTEMS

- Energy supplier: usage data, tariff rates, demand charges
- Supplier systems: raw material delivery schedules, quality certificates
- Customer orders: order_id, part_specifications, delivery_requirements

---

## Business Questions to Answer:

- Which machines need predictive maintenance? (Gold layer)
- Real-time production line efficiency (Silver layer)
- Quality control trending and root cause analysis (Gold layer)
- Energy consumption optimisation (Gold layer)
- Overall Equipment Effectiveness (OEE) reporting (Gold layer)

### Operational Considerations:

- High-frequency data (sensors every 30 seconds)
- 24/7 operations - no maintenance windows
- Safety-critical systems requiring immediate alerts
- Integration with production planning systems

> Use the worksheet to design Bronze → Silver → Gold data layers for Northern Steel Manufacturing.

---

## Question worksheet

```none
BRONZE Layer (Raw)

- What data arrives? (format, frequency, quality)
- Who owns this data?
- Any compliance/privacy concerns?

SILVER Layer (Cleaned)

- What cleaning rules apply?
- How do you handle quality issues?
- What validation checks are needed?

GOLD Layer (Business Ready)

- What business questions does this answer?
- Who are your end users?
- What aggregations/metrics do you create?
```

---

## Report back

- Describe your scenario
- Present your medallion design
- Class questions/feedback
