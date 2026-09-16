## <mark>Breakout into groups ~ Identify Weaknesses</mark>

- Frame it: "You're reviewing this pipeline as the person who has to maintain it, not the person who built it. Find the design debts."
- Design debt = something that works today but causes problems at scale, over time, or with another person involved

### Review Day 2 pipeline, find the design debts

- Where are raw and cleaned data mixed?
- What is hardest to debug?
- What is hardest for another engineer to reuse?
- K13 lens (security, scalability, compliance, cost) - use "On cost and risk" to surface it explicitly, not just structure/reliability

This is where DAY3-REVIEW's question actually gets answered. The list this group builds is what MEDALLION-M3 responds to directly - so push for specific, named debts, not vague discomfort.
