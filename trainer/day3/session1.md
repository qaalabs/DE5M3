# Day 3, Session 1: Incremental vs Full Load + CDC Concepts

**Time**: 09:50-11:00 (70 mins)  
**Theme**: "When Your Data Grows: Smart Loading Strategies"

---

## Opening (5 mins)

**Hook**: "Day 1 you loaded 1,000 customer records. What if tomorrow it's 10,000? Next week 1 million? Can you still reload everything every night?"

**Learning objectives**:

- Understand when to use full load vs incremental load
- Recognise the business and technical trade-offs
- Introduction to Change Data Capture (CDC) concepts

---

## Part 1: The Full Load Problem (15 mins)

**Scenario Callback**: Day 1 customer pipeline

- Loaded all records: simple, reliable
- Runtime: 2 minutes for 1,000 records
- **Discussion**: "What happens at scale?"

**The Maths**:
- 1,000 records = 2 mins
- 100,000 records = 200 mins (3+ hours)
- 1,000,000 records = 2,000 mins (33+ hours!)

**Business Impact**:

- Batch window constraints (must finish by 8am)
- Database load (locking, performance)
- Network costs (cloud data transfer)
- Unnecessary processing (unchanged records)

**Discussion Questions** (5 mins):

- "What's your organisation's largest dataset?"
- "How long do ETL jobs take?"
- "What happens if they don't finish on time?"

---

## Part 2: Incremental Load Pattern (20 mins)

**The Concept**: Only process what changed since last run

**Simple Example - Timestamp-Based**:
```python
# Full load (Day 1 approach)
SELECT * FROM customers

# Incremental load
SELECT * FROM customers 
WHERE last_modified >= '2025-10-06'
```

**The Pattern**:
1. Track "last successful load" timestamp
2. Query for records modified after that timestamp
3. Process only those records
4. Update "last successful load" timestamp

**Requirements**:
- Source system must have timestamp column
- Clocks must be synchronised
- What about deletes? (Preview of CDC)

**Quick Demo** (5 mins):
- Show customer table with `last_modified` column
- Run full load query vs incremental query
- Compare record counts and execution time

**Discussion Questions** (5 mins):
- "Do your source systems have modification timestamps?"
- "How do you know if a record was deleted?"
- "What if timestamps are unreliable?"

---

## Part 3: Change Data Capture (CDC) Concepts (25 mins)

**The Problem with Timestamps**:
- Not all systems have them
- Deletes are invisible
- Updates might not change timestamp
- Multiple changes between loads lost

**What is CDC?**:
- Database feature that tracks all changes
- Captures: INSERT, UPDATE, DELETE
- Stores changes in special tables
- Provides complete audit trail

**How It Works** (conceptual):
1. Database logs every change operation
2. CDC reads transaction log
3. Writes changes to change tables
4. ETL reads change tables instead of main tables

**Types of CDC**:
- **Log-Based CDC**: Reads database transaction log (SQL Server CDC)
- **Trigger-Based CDC**: Database triggers capture changes
- **Timestamp/Version-Based**: Hybrid approach (what they saw in Part 2)

**Quick Demo** (10 mins):
- Show SQL Server CDC setup (don't configure, just show)
- Query change table: `cdc.dbo_customers_CT`
- See operation type: INSERT (1), UPDATE (2), DELETE (4)
- Discuss: complete change history

**The Trade-offs**:

| Approach  | Pros               | Cons                             |
|-----------|--------------------|----------------------------------|
| Full Load | Simple, reliable   | Slow, expensive at scale         |
| Timestamp | Fast, simple logic | Misses deletes, needs timestamps |
| CDC       | Complete tracking  | Complex setup, database overhead |

---

## Part 4: Decision Framework (10 mins)

**When to Use What?**:

**Full Load**:
- Small datasets (< 10,000 records)
- Infrequent loads (weekly, monthly)
- Source system changes unpredictably
- Simplicity more valuable than speed

**Incremental (Timestamp)**:
- Medium datasets (10,000 - 1M records)
- Reliable modification timestamps
- Deletes handled separately or don't matter
- Good balance of complexity vs performance

**CDC**:
- Large datasets (> 1M records)
- Need complete change history
- Regulatory/audit requirements
- Database supports CDC features

**Group Discussion** (5 mins):
- "Think about your workplace ETL jobs..."
- "Which approach do you use now?"
- "Are there jobs that should switch approaches?"
- "What would prevent you from implementing CDC?"

---

## Wrap-up (5 mins)

**Key Takeaways**:
- Full load is simple but doesn't scale
- Incremental load needs reliable change tracking
- CDC provides complete change history but adds complexity
- Choice depends on: data volume, change frequency, business requirements

**Bridge to Session 2**:
"We've talked about WHEN to load data. Next session: HOW OFTEN to load data - batch vs real-time processing."

---

## Teaching Notes

**Learner Actions**:
- Observe demos (not hands-on coding)
- Participate in discussions
- Connect to their workplace scenarios

**Materials Needed**:
- Customer table from Day 1 (with `last_modified` column added)
- CDC-enabled sample database (demo only)
- Comparison table slide
- Decision framework visual

**Discussion Facilitation**:
- Let them share experiences first
- Avoid "quiz" questions
- Focus on trade-offs, not "right answers"
- Connect patterns back to Day 1 customer pipeline
