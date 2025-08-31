# Group 3: Regional Bank

## Business Context

You work for "Yorkshire Community Bank" - 50 branches, 150,000 customers, focusing on personal and small business banking.

## Current Data Challenges

- Fraud alerts arrive too late to prevent losses
- Customer service can't see complete relationship (savings + loans + credit cards)
- Regulatory reports are manual and time-consuming
- Cross-selling opportunities are missed
- Risk assessment relies on outdated information

## Your Data Sources

### CORE BANKING SYSTEM:

- customers: customer_id, name, address, risk_profile, relationship_manager
- accounts: account_id, customer_id, account_type, balance, opening_date
- transactions: transaction_id, account_id, amount, transaction_type, timestamp

### LENDING SYSTEM (separate):

- loans: loan_id, customer_id, amount, interest_rate, term, status
- loan_payments: payment_id, loan_id, amount, due_date, paid_date
- credit_assessments: assessment_id, customer_id, credit_score, assessment_date

### EXTERNAL SYSTEMS:

- Credit reference agencies: credit scores, payment history
- Open banking APIs: external account data (with consent)
- Fraud detection service: risk scores, alert flags

---

## Business Questions to Answer

- Who are high-value customers eligible for premium services? (Gold layer)
- Real-time fraud risk assessment (Silver layer)
- Regulatory capital adequacy reporting (Gold layer)
- Customer lifetime value and churn prediction (Gold layer)
- Branch performance and profitability analysis (Gold layer)

### Compliance Considerations

- FCA regulatory reporting requirements
- PCI DSS payment card security
- Open banking consent management
- Anti-money laundering (AML) monitoring

> Use the worksheet to design Bronze → Silver → Gold data layers for Yorkshire Community Bank.

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
