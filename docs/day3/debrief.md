# Facilitator Notes — What Is Actually Better?

*Trainer-only. After REFACTOR, before afternoon break.*
*Aim: 20 minutes.*

---

## Ask the group

**"What is concretely better about the medallion version?"**

Things to draw out:

- **Bronze is untouched** — you can always re-run from the original source data
- **Silver is validated** — the assert cells mean if something is wrong, the notebook fails loudly rather than silently producing bad gold
- **Gold reads from silver** — if `silver_sales` changes, `gold_revenue` benefits automatically on next run
- **Names encode meaning** — `silver_sales` tells you the layer; `cleaned_sales` tells you nothing about where it sits
- **Two notebooks, clear jobs** — bronze→silver is about trust; silver→gold is about answering questions

---

## Ask the group

**"What is still not good enough?"**

Things to draw out:

- Still manual — someone has to run both notebooks in order
- No scheduling — nothing triggers the pipeline when new data arrives
- No logging — if gold looks wrong, you have no record of when it was last run or what version of silver it read
- The validation checks are basic — they confirm types and nulls but not business rules (e.g. "are all product IDs valid?")

---

## Key point to make

> "Medallion is not a technology. It is a convention. You could implement bronze/silver/gold in local files, in Fabric, in Databricks, in any data platform. What matters is the discipline: raw stays raw, cleaned data is validated, business outputs are built from trusted sources."

---

## Bridge to the extension

> "The extension task asks you to apply that same discipline to a source you have not built yet. That is where you find out whether you understand the architecture or just followed the recipe."
