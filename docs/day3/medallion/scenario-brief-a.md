# Group A: E-commerce

## Business Context

You work for "TechStyle" - an online retailer selling electronics and fashion. 50,000 orders/month, 200,000 active customers.

## Current Data Challenges

- Customer service can't see complete order history
- Marketing sends emails to customers who've returned everything
- Finance struggles with refund reporting
- Website recommendations are based on stale data

## Your Data Sources

### WEBSITE DATABASE

- customer_profiles: ID, name, email, registration_date, preferences
- orders: order_id, customer_id, total_amount, order_date, status
- order_items: order_id, product_id, quantity, unit_price

### RETURNS SYSTEM (separate)

- returns: return_id, order_id, reason, return_date, refund_status
- return_items: return_id, product_id, condition, refund_amount

### EXTERNAL APIs

- Payment gateway: transaction details, payment methods
- Shipping provider: delivery status, tracking

---

## Business Questions to Answer

- Who are our most valuable customers? (Gold layer)
- Which products have high return rates? (Gold layer)
- Real-time order status for customer service (Silver layer)
- Daily sales dashboard for management (Gold layer)

> Use the worksheet to design Bronze → Silver → Gold data layers for TechStyle.

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
