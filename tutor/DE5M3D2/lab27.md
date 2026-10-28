## 🧪 <mark>Lab 2.7 ~ Rerun with a Schema Change</mark>

### Activities

1. Add the third batch
2. Rerun the pipeline
3. Check the status
4. Verify the results
5. Find out what happened

### Notes

- `price` not `unit_price` - Shape shows (39, 9)
- Raw 35 -> 39, cleaned/output stay 27, revenue stays 2268.52
- All 4 dropped by `df[df['unit_price'] > 0]` - still Succeeded
