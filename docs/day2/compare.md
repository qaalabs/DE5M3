# Local vs Cloud: A Comparison

## Your task

In your group, compare the Day 1 pipeline (local, on your VM) with the Day 2 pipeline (Fabric, in the cloud).

Use the framework below. You have 20 minutes - pick the dimensions that generate the most discussion rather than trying to cover everything.

---

## Comparison framework

| Dimension | Day 1 - Local | Day 2 - Fabric |
|-----------|--------------|----------------|
| **Where data lives** | VM filesystem | OneLake |
| **Who can access output** | Just you | Anyone in the workspace |
| **How output is stored** | CSV file | Delta table |
| **How to query results** | Python / pandas | Python, SQL endpoint, or both |
| **What happens if VM is off** | Data unavailable | Data always available |
| **How to share results** | Email a file | Share a workspace link |
| **What happens when data changes** | Re-run notebook manually | Re-run notebook manually |
| **Scale** | Limited by laptop RAM | Distributed compute |

---

## Discussion questions

Choose two or three that feel most relevant to your group:

1. Which approach would you choose for a dataset that 10 people need to query daily?
2. Which approach is easier to debug when something goes wrong?
3. What would a business stakeholder notice about the difference - or would they notice anything?
4. What are you giving up by moving to the cloud? What are you gaining?
5. At what point does the local approach become genuinely inadequate?

---

## Prepare to share

Pick one insight from your group to share back with the room:

- Something that surprised you
- A dimension where the answer was less obvious than you expected
- A situation where local would still be the right choice
