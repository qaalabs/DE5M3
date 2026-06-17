---
title: Reading from an API
---

# The Problem with JSON

The metadata approach works for files. But what if the data comes from an API?

```json
{
  "product_id": "P001",
  "name": 2,
  "name": "Smart Thermostat Pro",
  "category": "Thermostats"
}
```

- The field names can change overnight
- Fields can be added or removed without warning
- You only find out when your pipeline breaks

> A JSON response is a promise with no contract.

Notes: This is the natural follow-on from the CSV/zip problem. Files at least sit still - APIs can change at any time and your code will fail silently or loudly depending on how defensive it is.

---

# APIs with a Spec

Some APIs publish a contract - a formal description of what they return.

- Which endpoints exist
- What parameters they accept
- What fields are in the response
- What data types each field is

This is called an **OpenAPI spec**.

*Swagger is the tool most commonly used to read and test it.*

Notes: Keep this brief - the live demo does the explaining. The point to land is "contract" - the API is promising you a structure, and you can hold it to that promise.

---

# Swagger in Practice

```
GET /homesphere/v1/product/{id}

Response:
  product_id    string
  name          string
  category      string
  specs         dict   ~ (rrp, warranty_years, colour, connectivity)
```

- You can read the spec before you write any code
- You can test it live in the browser
- If the spec changes, you know what broke and why

Notes: Switch to the live Swagger UI demo here. Show: (1) the endpoint list, (2) click an endpoint, (3) try it out - execute a call and show the response. Keep it to one endpoint. The goal is "I can see what this returns before I trust it."

---

# Two Problems. Same Solution.

| Problem                | Answer                          |
|------------------------|---------------------------------|
| How do I trust a file? | Wrap it ~ zip + metadata        |
| How do I trust an API? | Read the spec ~ Swagger/OpenAPI |

Both give you a **contract** before the data enters your pipeline.

Notes: This slide bridges into the breakout. The pattern is the same: don't trust data blindly, build in a way to verify it. Now ask them to think about their own workplaces.
