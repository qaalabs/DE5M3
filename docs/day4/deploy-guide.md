# Deploy a New Pipeline: Step-by-Step Guide

!!! abstract "K8: Deployment approaches for new data pipelines and automated processes."
!!! abstract "K13: The implications of financial, strategic and compliance regarding to security, scalability, compliance and cost of local, remote or distributed solutions."
!!! abstract "K20: Types and uses of data engineering tools and applications in own organisation."

!!! question "Could you hand this guide to a colleague and have them deploy a new pipeline correctly, without you in the room?"

## The task

> Create a step-by-step guide on deploying a new data pipeline using a chosen data integration platform in your organisation. Include considerations for security, scalability, and governance.

---

## Choose your platform

Pick a data integration platform you actually know - from your own organisation if you can, or one you have used on this course (Fabric, ADF, Airflow, dbt, Fivetran... whatever fits). Do not research a platform you have never touched - the guide needs to be grounded in something real.

---

## Your task

Write a guide with four sections:

1. **Deployment steps** - What has to happen, in order, to get a new pipeline live? Provisioning, connecting sources, configuring the pipeline logic, testing, deploying, monitoring.
2. **Security** - Who can access what? How are credentials and secrets handled? What happens to data in transit and at rest?
3. **Scalability** - What happens as data volume grows? Where are the limits - compute, concurrency, cost?
4. **Governance** - Who owns this pipeline once it is live? How is it documented, tracked, and changed safely? What compliance or retention rules apply?

---

## Prompts

- If a new starter followed this guide with no other context, where would they get stuck?
- Which of your four sections is thinnest right now - and why?
- What would your organisation's security or compliance team ask about, that you have not covered?

---

## What to avoid

- A guide that is only deployment steps with security, scalability, and governance bolted on as an afterthought - all four should carry real weight
- Vague statements ("access is controlled", "it scales well") without saying how
- Copying platform documentation - this should reflect how deployment actually works where you are, or would, using your chosen platform

---

## Keep it scoped

Aim for one page, not a full runbook. Enough to show you understand the considerations, not exhaustive operational detail.
