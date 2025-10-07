## Day 3, Session 2: Batch vs Real-Time Processing

**Time**: 11:20-12:30 (70 mins)  
**Theme**: "How Fast Does Your Business Need Data?"

---

### Opening (5 mins)

**Hook**: "Session 1 was about WHAT data to load. Now: WHEN should data arrive?"

**Scenario**: 
- Customer changes address at 2pm Monday
- When does your sales team see the new address?
  - Tonight at midnight? (Batch)
  - In 15 minutes? (Near real-time)
  - Instantly? (Real-time streaming)

**Learning objectives**:
- Understand the spectrum from batch to real-time
- Recognise business requirements that drive timing decisions
- Introduction to streaming concepts (K18)

---

### Part 1: The Processing Spectrum (15 mins)

**Not Binary - It's a Spectrum**:

```
Batch          Near Real-Time        Real-Time         Streaming
|---------------|-------------------|-----------------|
Daily/Hourly    Every 15 mins       Seconds           Milliseconds
```

**Examples at Each Point**:

**Batch (Daily/Hourly)**:
- Day 1 customer pipeline (run overnight)
- Monthly sales reports
- Annual tax calculations
- Data warehouse refreshes

**Near Real-Time (Minutes)**:
- Inventory updates (every 15 mins)
- Website analytics dashboards
- Email campaign metrics
- Customer support ticket updates

**Real-Time (Seconds)**:
- Fraud detection (payment processing)
- Stock trading systems
- Traffic monitoring
- Online bidding systems

**Streaming (Continuous)**:
- IoT sensor data (temperature, pressure)
- Website clickstream analysis
- Social media sentiment monitoring
- Network security monitoring

**Discussion Questions** (5 mins):
- "What's the fastest data processing in your organisation?"
- "What happens if that data arrives late?"
- "Are there systems that should be faster?"

---

### Part 2: Batch Processing Deep Dive (15 mins)

**What is Batch Processing?**:
- Process data in scheduled chunks
- Typically overnight or hourly
- Day 1 Python pipeline was batch processing

**Characteristics**:
- **High latency**: Hours between data creation and availability
- **High throughput**: Can process millions of records
- **Predictable**: Runs on schedule
- **Simple**: Easier to develop and debug

**The Batch Window**:
```
20:00 - Extract data from sources
21:00 - Transform and validate
23:00 - Load to data warehouse
06:00 - Ready for business users
```

**When Batch Works Well**:
- Historical reporting and analysis
- Data warehouse loading
- Complex transformations (aggregations, joins)
- Regulatory reporting (monthly, quarterly)
- Large data volumes where real-time isn't critical

**The Day 1 Pipeline as Batch**:
```python
# This was batch processing!
df = pd.read_csv('customers.csv')  # Extract
df_clean = clean_data(df)           # Transform
df_clean.to_sql('customers', ...)  # Load
```

**Scheduled with**:
- Cron jobs (Linux)
- Windows Task Scheduler
- Azure Data Factory triggers
- Airflow/other orchestrators

**Discussion Questions** (3 mins):
- "How are your ETL jobs scheduled?"
- "What happens if batch jobs fail?"
- "Who gets notified?"

---

### Part 3: Real-Time & Streaming Concepts (20 mins)

**The Business Case for Speed**:

**Example 1: Fraud Detection**
- Customer uses card in London at 2pm
- Same card used in New York at 2:05pm
- **Batch**: Detected tomorrow morning (too late)
- **Real-time**: Detected in seconds, transaction blocked

**Example 2: Inventory Management**
- Last item sold online
- **Batch**: Overnight update, overselling happens
- **Real-time**: Immediate update, prevents overselling

**What Changes with Real-Time?**:

**Architecture Shift**:
```
Batch:     Source → [Wait] → ETL → [Wait] → Warehouse
Real-Time: Source → Stream → Process → Destination (continuous)
```

**Technology Shift**:
- **Batch**: Files, scheduled jobs, SQL queries
- **Real-Time**: Message queues, event streams, in-memory processing

**Key Concepts**:

**Event Streams**:
- Data flows continuously
- Each record processed individually
- Think: river of data, not lake

**Message Queues** (K18):
- Kafka, Azure Event Hubs, AWS Kinesis
- Buffer between source and processing
- Handle spikes in data volume

**Stream Processing**:
- Process data as it arrives
- Windowing: "last 5 minutes of transactions"
- Aggregations on moving data

**Quick Comparison Demo** (5 mins):

Show two approaches to same problem:

**Batch Version** (what they know):
```python
# Runs every hour
df = read_transactions_last_hour()
summary = df.groupby('customer').sum()
write_to_database(summary)
```

**Streaming Concept** (new):
```
For each transaction (as it arrives):
  - Update running total for customer
  - Check if threshold exceeded
  - Trigger alert if needed
```

**The Trade-offs**:

| Aspect | Batch | Real-Time |
|--------|-------|-----------|
| Latency | Hours | Seconds |
| Complexity | Low | High |
| Cost | Lower | Higher |
| Debugging | Easier | Harder |
| Data Volume | High | Can be high |
| Use Cases | Reports, Analytics | Monitoring, Alerts |

**Discussion Questions** (5 mins):
- "What data in your organisation needs to be faster?"
- "What's stopping real-time implementation?"
- "Is the business willing to pay for real-time processing?"

---

### Part 4: The Middle Ground - Micro-Batching (10 mins)

**The Compromise**: Not pure streaming, not overnight batch

**What is Micro-Batching?**:
- Process small batches frequently
- Every 5 minutes, every 15 minutes
- Easier than streaming, faster than batch

**Example**:
```python
# Instead of running once daily at midnight
# Run every 15 minutes throughout the day

while True:
    df = get_last_15_minutes_data()
    process_and_load(df)
    sleep(15 * 60)  # Wait 15 minutes
```

**When Micro-Batching Works**:
- Business needs "near real-time" (not instant)
- Existing batch code can be reused
- Lower complexity than true streaming
- Good transition step from batch to real-time

**Examples**:
- Website analytics (update every 10 mins)
- Inventory checks (refresh every 15 mins)
- Social media monitoring (every 5 mins)
- Customer activity dashboards (every 30 mins)

**Discussion**: "Could any of your overnight jobs run every hour instead?"

---

### Part 5: Decision Framework (10 mins)

**How to Choose Processing Speed?**

**Questions to Ask**:

1. **Business Impact**: "What happens if data is 1 hour old? 1 day old?"
   - If answer is "nothing bad", use batch
   - If answer is "we lose money/customers", consider real-time

2. **Data Volume**: "How much data per hour/day?"
   - Small volumes: Any approach works
   - Large volumes: Batch might be only option

3. **Complexity Tolerance**: "Can we manage streaming infrastructure?"
   - Limited team: Stick with batch
   - Mature team: Consider real-time

4. **Cost**: "What's the business value of faster data?"
   - Real-time infrastructure costs more
   - Is faster data worth the investment?

**Group Activity** (5 mins):

Present 3 scenarios, discuss which approach:

**Scenario A**: Monthly financial reporting
- **Answer**: Batch (daily or less frequent)

**Scenario B**: Credit card fraud detection
- **Answer**: Real-time streaming

**Scenario C**: Product recommendations on website
- **Answer**: Near real-time (micro-batch) or pre-computed (batch)

**Their Turn**: "Share one ETL job from your workplace - which approach does it use? Should it be different?"

---

### Wrap-up (5 mins)

**Key Takeaways**:
- Batch, near real-time, and streaming serve different needs
- Choice driven by business requirements, not technology preference
- Most organisations use a mix of approaches
- Start with batch, move to real-time only when business justifies it

**Bridge to Lunch**:
"Session 1: WHAT data to load (full vs incremental)  
Session 2: WHEN to load data (batch vs real-time)  
Session 3 (after lunch): WHERE data comes from (multiple sources, unstructured data)"

---

## Teaching Notes

**Learner Actions**:
- Observe streaming concepts (not building streaming pipelines)
- Discuss timing requirements in their organisations
- Understand trade-offs, not implementation details

**Materials Needed**:
- Processing spectrum visual
- Batch window timeline diagram
- Trade-offs comparison table
- 3 scenario cards for group activity
- (Optional) Azure Stream Analytics or Fabric EventStream demo

**Facilitation Tips**:
- Emphasise: most orgs use batch successfully
- Real-time is not "better", just different
- Connect back to Day 1 pipeline (was batch, could be other approaches)
- Avoid deep technical streaming details (that's Day 4 if needed)

**Connection to KSBs**:
- K18: Streaming, batching, on-demand services ✅
- S15: Optimise data ingestion frameworks ✅

