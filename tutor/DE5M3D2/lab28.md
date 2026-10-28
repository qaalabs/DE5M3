## 🧪 <mark>Lab 2.8 ~ Rerun with a Hard Failure</mark>

### Activities

1. Add the fourth batch
2. Rerun the pipeline
3. Check the status
4. Find out why
5. Update your record

### Notes

- ORD-040 region `Wales, near Cardiff` - unquoted comma, 9 fields
- `ParserError: Expected 8 fields in line 4, saw 9` in Clean Sales Orders
- Clean fails, Log Failure runs, Build Output and Log Success don't
- Hold cleanup until after the S8 reflection
