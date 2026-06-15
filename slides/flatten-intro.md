---
title: Why Flatten and Join?
---

# How to Flatten and Join

## Use: `json_normalize`

```python
# Before - nested structure
print(products_data['products'][0])
# {'product_id': 'P001', 'name': 'Smart Thermostat Pro',
#  'category': 'Thermostats',
#  'specs': {'rrp': 89.99, 'warranty_years': 2, ...}}
```

```python
# After - flat table
products = pd.json_normalize(products_data['products'])
products.head()
# product_id | name | category | specs.rrp | specs.warranty_years | ...
```

