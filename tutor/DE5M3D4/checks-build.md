## Checks Build

Notebook practical - "Make it safe to run"

- Demo TODO 1 live (row count) - use if/raise, not assert
- Learners continue: TODO 2 null check, TODO 3 join quality, TODO 4 value sanity
- Each TODO: risk + check + what should happen if it fails
- Stretch: move checks into reusable functions (check_not_empty, check_no_nulls)
- Debrief last 5 min before break: stop / warn / quarantine - which response fits each check and why

---

*Before break, come back together for a few minutes.*

The question is not "did your checks work?" It is:

**What should the pipeline do when a check fails?**

Three options:

- **Stop** ~ raise an error and halt. Nothing downstream runs. Safe but inflexible.
- **Warn and continue** ~ print the failure and keep going. Risky if downstream code consumes bad data.
- **Quarantine** ~ write the failing rows to a rejected file, continue with the clean rows.

No single right answer. Depends on what the downstream consumer expects and how bad the failure is.

Ask: For each of the four checks they wrote - which response makes most sense and why?
