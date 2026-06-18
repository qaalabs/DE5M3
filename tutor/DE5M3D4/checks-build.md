## Checks Build

Learners open `day4/checks_practice.ipynb`. Four parts:

- Part 1: bare asserts on the raw file - stops at first failure (unit_price dtype). Warn learners this is expected.
- Part 2: try/except collects all failures. Two of the five checks throw TypeError (not AssertionError) because the column is object dtype and the comparison `> 0` crashes before reaching the assertion.
- Closer look cell: strips the £ prefix from unit_price, coerces to numeric, then reruns the comparison. Now it gives a proper AssertionError and shows the offending row - ORD-021 has a genuinely negative price (-89.99), not just a formatting problem. This is the hinge: TypeError means the check machinery broke; AssertionError means the check ran and found a real issue.
- Discussion: three options (proceed, stop, quarantine). No right answer - depends on downstream use.
- Part 3: learners add three more checks. The data has duplicate order_ids (2), inconsistent status casing, and a quantity value of 'two' - all findable from what they have already seen.

Note: we catch `Exception` not just `AssertionError` throughout, because dirty data can crash the check before the assertion runs.
