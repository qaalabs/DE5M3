# Day 3, Session 4: Bringing It All Together

**Time**: 15:05-16:00 (55 mins)  
**Theme**: "From Patterns to Architecture: Making Design Decisions"

---

## Opening (5 mins)

**Recap the Journey**:
- Session 1: WHAT to load (full vs incremental, CDC)
- Session 2: WHEN to load (batch vs real-time)
- Session 3: WHERE from (multi-source, unstructured data)
- **Session 4**: HOW to architect it all

**Today's Question**: "You know the patterns. Now: how do you decide which to use?"

---

## Part 1: ELT vs ETL - Where Does Transformation Happen? (15 mins)

**The Fundamental Choice**:

**ETL (Extract-Transform-Load)**:
```
Source → Transform (Python/tool) → Load → Warehouse
```

- Day 1 approach: cleaned data BEFORE loading
- Transform in pipeline/code
- Load clean data to warehouse

**ELT (Extract-Load-Transform)**:
```
Source → Load → Warehouse → Transform (SQL/views)
```

- Load raw data first
- Transform INSIDE the warehouse
- Use SQL, stored procedures, or views

**Why ELT Emerged**:

- Modern warehouses are powerful (Snowflake, Synapse, BigQuery)
- Cloud compute is cheap and scalable
- Raw data preservation (can re-transform later)
- Separation of concerns (data engineers load, analysts transform)

**When to Use Which?**:

**Use ETL when**:

- Complex business logic (easier in Python than SQL)
- External APIs enrichment (like Day 1 postcode lookup)
- Data quality rules before loading
- Target system has limited compute
- Multiple destinations from same source

**Use ELT when**:

- Powerful target warehouse (cloud platforms)
- SQL-comfortable team
- Need to preserve raw data
- Iterative analysis (analysts experiment with transformations)
- Simple transformations (aggregations, joins)

**Discussion Questions** (5 mins):

- "Which approach does your organisation use?"
- "Where do most transformations happen - pipeline or warehouse?"
- "Who owns transformations - engineers or analysts?"

---

## Part 2: Where Do Cross-Cutting Concerns Fit? (15 mins)

**The Architecture Layer Cake**:

You've built pipelines, but where do these fit?

**1. Audit & Logging** (K11, K13):

- **Option A**: In the pipeline (Python logging)
- **Option B**: In the database (audit tables)
- **Option C**: Separate audit system (log aggregation tool)

**Their Day 1 pipeline**: Had some audit in SQL (last_loaded timestamp)

**Discussion**: "Where does your organisation track ETL runs?"

**2. Data Quality Checks**:

- **Option A**: In Extract phase (reject at source)
- **Option B**: In Transform phase (clean or reject)
- **Option C**: In Load phase (database constraints)
- **Option D**: After Load (validation queries)

**Their Day 1 pipeline**: Mostly Transform phase (data cleaning)

**Discussion**: "When do you catch bad data - early or late?"

**3. Security & Compliance** (K13):

- Encryption in transit vs at rest
- PII masking: where does it happen?
- Access controls: who can see what?
- Data residency: where is data stored?

**Questions for Them**:

- "Do you handle personal data? Where is it masked?"
- "Who can access raw vs processed data?"
- "Any compliance requirements (GDPR, SOX, HIPAA)?"

**4. Error Handling**:

- **Option A**: Fail fast (stop entire pipeline)
- **Option B**: Quarantine bad records (continue with good ones)
- **Option C**: Dead letter queue (process later)

**Discussion**: "What happens in your pipelines when one record fails?"

---

## Part 3: Introduction to Modern Architecture - Medallion Pattern (10 mins)

**Bridge from Today's Patterns to Tomorrow's Lab**:

"All the patterns we discussed today - they organize into layers..."

**The Medallion Architecture**:

```
Bronze Layer (Raw)
  ↓
Silver Layer (Cleaned)
  ↓
Gold Layer (Business)
```

**How Today's Patterns Map**:

**Bronze = Extract + Load**:

- ELT approach: load raw data first
- Full or incremental (Session 1 patterns)
- Batch or streaming (Session 2 patterns)
- Multi-source, unstructured (Session 3)
- **No transformation** (just land the data)

**Silver = Transform**:

- Data quality rules applied
- Standardization, deduplication
- Their Day 1 customer cleaning happens here
- Still general-purpose, not business-specific

**Gold = Business Logic**:

- Aggregations, metrics, KPIs
- Denormalized for reporting
- Customer 360 views
- Department-specific needs

**Why This Architecture?**:

- **Separation of concerns**: Raw vs clean vs business
- **Reusability**: One Silver, many Golds
- **Auditability**: Can always trace back to Bronze
- **Flexibility**: Re-transform without re-extracting

**Where Cross-Cutting Concerns Fit**:

- **Audit**: Track transformations between layers
- **Quality**: Gates between Bronze→Silver, Silver→Gold
- **Security**: Different access per layer
- **Compliance**: PII masked in Silver or Gold, not Bronze

**Preview Day 4**: "Tomorrow you'll build this hands-on in Fabric"

---

## Part 4: Design Decision Framework (5 mins)

**When Planning an ETL Solution, Ask**:

### **Volume & Velocity** (Sessions 1-2):
- How much data? → Full or incremental
- How fast needed? → Batch or real-time

### **Source Complexity** (Session 3):
- How many sources? → Integration strategy
- Structured or unstructured? → Extraction approach

### **Transformation Location** (Session 4):
- Where to transform? → ETL or ELT
- Who transforms? → Engineers or analysts

### **Operational Requirements** (Session 4):
- Audit needs? → Logging strategy
- Compliance? → Security approach
- Failure handling? → Error strategy

### **Architecture Pattern** (Session 4):
- Single destination? → Direct load
- Multiple uses? → Medallion/layered

**This is Module 4 Prep**: Planning a Data Engineering Product

---

## Part 5: Group Discussion & Reflection (10 mins)

**Facilitated Discussion**:

"Think about a current ETL challenge in your organisation..."

**Prompts**:

- "Which patterns would help solve it?"
- "What design decisions would you make differently now?"
- "What questions would you ask stakeholders?"
- "Where are the biggest pain points?"

**Share Out** (volunteer basis):

- 2-3 learners share their scenarios
- Group suggests patterns/approaches
- Instructor connects to day's learning

**Key Message**: 

"There's no 'perfect' architecture. It's about:

- Understanding your requirements
- Knowing your options (patterns)
- Making informed trade-offs
- Documenting your decisions"

---

## Wrap-up (5 mins)

### **Day 3 Summary**:
- **Session 1**: Loading strategies (full, incremental, CDC)
- **Session 2**: Processing timing (batch, real-time, streaming)
- **Session 3**: Source diversity (multi-source, unstructured)
- **Session 4**: Architecture decisions (ETL vs ELT, medallion intro)

### **Skills Bridge**:
- Day 1: Built ETL (hands-on Python)
- Day 2: Rebuilt visually (Fabric Data Factory)
- Day 3: Understood patterns (design thinking)
- **Day 4**: Modern architecture (medallion hands-on)

### **Module 4 Connection**: 
"Today was about patterns and decisions. Module 4 (Planning) will be all about making these decisions before you build. You now have the vocabulary and concepts."

### **Tomorrow Preview**: 
"Day 4: Hands-on medallion architecture lab in Fabric, plus [other Day 4 content you decide]"

### **Final Reflection** (optional, if time):
"One thing you'll apply at work from today?"

---

## Teaching Notes

### **Session Goals**:
- Synthesize three sessions of patterns
- Introduce architectural thinking
- Bridge to Module 4 (Planning)
- Set up Day 4 (Medallion lab)

### **Facilitation Approach**:
- More discussion-heavy than earlier sessions
- Draw out their experiences
- Connect patterns to real decisions
- Avoid prescriptive "always do X"

### **Materials Needed**:
- ETL vs ELT diagram
- Medallion architecture visual
- Decision framework checklist
- Discussion prompt cards

### **Connection to KSBs**:
- K8: Deployment approaches ✅
- K11: Security, ethical practices ✅
- K13: Financial, strategic, compliance implications ✅
- K17: Integration approaches ✅
- Prepares for B3: Technical debt and continuous improvement

### **Time Flexibility**:
- Part 2 (cross-cutting concerns) could expand if good discussion
- Part 5 (group discussion) could contract if running late
- Medallion intro (Part 3) is critical for Day 4 setup

---

