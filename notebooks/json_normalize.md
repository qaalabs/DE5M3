```python
import json
import pandas as pd
```


```python
with open('../data/products_raw.json') as f:
    products_data = json.load(f)
```


```python
# Before - nested structure
print(products_data['products'][0])
# {'product_id': 'P001', 'name': 'Smart Thermostat Pro',
#  'category': 'Thermostats',
#  'specs': {'rrp': 89.99, 'warranty_years': 2, ...}}
```

    {'product_id': 'P001', 'name': 'Smart Thermostat Pro', 'category': 'Thermostats', 'specs': {'rrp': 89.99, 'warranty_years': 2, 'colour': 'White', 'connectivity': 'Wi-Fi'}}



```python
# After - flat table
products = pd.json_normalize(products_data['products'])
products.head()
# product_id | name | category | specs.rrp | specs.warranty_years | ...
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>product_id</th>
      <th>name</th>
      <th>category</th>
      <th>specs.rrp</th>
      <th>specs.warranty_years</th>
      <th>specs.colour</th>
      <th>specs.connectivity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>P001</td>
      <td>Smart Thermostat Pro</td>
      <td>Thermostats</td>
      <td>89.99</td>
      <td>2</td>
      <td>White</td>
      <td>Wi-Fi</td>
    </tr>
    <tr>
      <th>1</th>
      <td>P002</td>
      <td>Smart Thermostat Lite</td>
      <td>Thermostats</td>
      <td>59.99</td>
      <td>1</td>
      <td>White</td>
      <td>Wi-Fi</td>
    </tr>
    <tr>
      <th>2</th>
      <td>P003</td>
      <td>Motion Sensor</td>
      <td>Sensors</td>
      <td>24.99</td>
      <td>1</td>
      <td>White</td>
      <td>Zigbee</td>
    </tr>
    <tr>
      <th>3</th>
      <td>P004</td>
      <td>Door Sensor</td>
      <td>Sensors</td>
      <td>18.99</td>
      <td>1</td>
      <td>White</td>
      <td>Zigbee</td>
    </tr>
    <tr>
      <th>4</th>
      <td>P005</td>
      <td>Smart Camera Indoor</td>
      <td>Cameras</td>
      <td>129.99</td>
      <td>2</td>
      <td>Black</td>
      <td>Wi-Fi</td>
    </tr>
  </tbody>
</table>
</div>




```python

```
