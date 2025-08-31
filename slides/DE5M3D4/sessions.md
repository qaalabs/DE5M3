## **Day 4 Session Design: Pipeline Design Patterns**

### **Session 1 (9:40-10:40) - Medallion Architecture**

**Opening Hook (5 mins):**
"Remember your messy customer data from Day 1? In real data platforms, we organise this into trust zones - Bronze (raw), Silver (cleaned), Gold (business-ready)."

**Core Activity (30 mins):**
**Medallion Mapping Exercise:**
- Give teams the original Day 1 messy data
- Challenge: "Map this through Bronze → Silver → Gold layers"
- Bronze: Raw CSV exactly as received
- Silver: Cleaned names, validated emails (Day 1 transformation)
- Gold: Customer 360 view with enriched data

**Implementation Options by Tier:**
- **L1**: Use provided templates, map data to each layer
- **L2**: Design the transformation rules between layers
- **L3**: Consider partitioning, schema evolution, lineage tracking

**Discussion (15 mins):**
*"How does medallion compare to your current data organisation? What are the benefits and challenges?"*

**Key Takeaway:** Progressive refinement - each layer adds trust and business value

---

### **Session 2 (11:00-12:10) - Incremental vs Full Load**

**Business Context (10 mins):**
"Your Day 1 pipeline processed 7 customers in seconds. Production systems have millions of customers - full reload takes hours. How do you handle daily updates?"

**Hands-on Comparison (45 mins):**

**Scenario:** Daily customer status updates
```python
# Yesterday's data: 1 million customers
# Today's changes: 1,000 status updates
# Question: Reload everything or just changes?
```

**Activity:** 
- L1: Compare execution times (simulated)
- L2: Implement change detection logic
- L3: Design CDC strategy with failure recovery

**Real-world Connection (15 mins):**
- Show Azure Data Factory incremental copy
- Discuss: watermarks, change tracking, delta files
- When full load is still needed (data quality fixes, schema changes)

**Key Takeaway:** Efficiency vs simplicity trade-offs

---

### **Session 3 (13:20-14:30) - Multi-source Integration**

**The Integration Challenge (10 mins):**
"Your customer data lives in CRM, billing system, support tickets. Each has different formats, update schedules, and quality levels. How do you create the single truth?"

**Conflict Resolution Lab (45 mins):**

**Scenario:** Same customer in 3 systems with conflicts:
```python
crm_system = {"customer_id": 1001, "name": "John Smith", "status": "active", "last_update": "2024-01-15"}
billing_system = {"cust_id": 1001, "customer_name": "J. Smith", "account_status": "suspended", "modified": "2024-01-20"}
support_system = {"id": 1001, "full_name": "John S.", "tier": "premium", "updated": "2024-01-18"}
```

**Challenge by Tier:**
- **L1**: Apply provided business rules for conflict resolution
- **L2**: Design master data management strategy
- **L3**: Build data quality scoring and confidence metrics

**Discussion (15 mins):**
*"How do you handle conflicting data in your organisation? What's the source of truth?"*

**Key Takeaway:** Integration requires business rules, not just technical joins

---

### **Session 4 (14:50-15:50) - Orchestrated Pipelines + Career**

**Orchestration Concepts (25 mins):**

**Visual Pipeline Design:**
- Show dependency mapping: "Customer data must load before orders"
- Error handling: "If customer API fails, what happens to dependent steps?"
- Scheduling: "Daily, hourly, or event-triggered?"

**Activity:**
- Teams design pipeline orchestration for their Day 1-3 work
- Consider: parallel execution, retry logic, monitoring alerts

**Career Progression Discussion (25 mins):**

**ETL Career Pathway:**
```
ETL Developer → Data Engineer → Data Architect → Chief Data Officer
```

**Skills Progression:**
- **Technical:** Python → SQL → Cloud platforms → Architecture
- **Business:** Data quality → Business requirements → Strategy
- **Leadership:** Individual contributor → Team lead → Director

**Reflection Questions:**
- "Where are you on this pathway?"
- "What's your next skill development priority?"
- "How will you apply this module's learning at work?"

**Key Takeaway:** ETL skills are the foundation for data engineering career growth

---

### **Wrap-up (15:50-16:00)**

**Pattern Summary:**
1. **Medallion:** Progressive data refinement
2. **Incremental:** Efficiency through change detection
3. **Multi-source:** Business rules for integration
4. **Orchestration:** Managing complex dependencies

**Module Bridge:**
"You now understand ETL execution and design. Module 4: How to plan these solutions as products - requirements gathering, costing, stakeholder management."

**Final Challenge:**
*"Design an ETL solution for your workplace using these patterns. What would you build differently now?"*

---

## **Key Design Elements:**

✅ **Builds on Days 1-3** - references their actual work
✅ **Practical patterns** - they'll use these in real projects
✅ **Career progression** - links technical skills to professional growth
✅ **Assessment evidence** - portfolio of design decisions
✅ **Module bridge** - sets up planning mindset for Module 4

Does this session design feel right for your learners' progression? Should we adjust the balance between hands-on activities and discussion?