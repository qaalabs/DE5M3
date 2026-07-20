# Pandas 101

This is an optional notebook to get you up to speed with [pandas](https://pandas.pydata.org/docs/) in case you are new to it or need a refresher. We use pandas throughout this module to load, inspect, clean, and join data. The [official 10 minutes to pandas](https://pandas.pydata.org/docs/user_guide/10min.html) guide is a good deeper dive once you've been through this.

We'll work with a small sales dataset (`data/sales.csv`) so everything below runs against real data rather than toy examples.

## DataFrames and Series

Pandas gives us two main data structures:

- A **Series** is a single column of data (with an index).
- A **DataFrame** is a table made up of rows and columns - think of it as a collection of Series that share the same index.

By convention, we import pandas as `pd`:


```python
import pandas as pd
```

## Reading Data

We can load a CSV file straight into a DataFrame with `read_csv()`:


```python
df = pd.read_csv('data/sales.csv')
type(df)
```




    pandas.DataFrame



## Inspecting a DataFrame

Once we have loaded some data, the first thing to do is look at it. `.shape` tells us the number of rows and columns:


```python
df.shape
```




    (32718, 9)



`.head()` shows the first few rows (5 by default). We can pass a number to see more or fewer:


```python
df.head(3)
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
      <th>SalesOrderNumber</th>
      <th>SalesOrderLineNumber</th>
      <th>OrderDate</th>
      <th>CustomerName</th>
      <th>EmailAddress</th>
      <th>Item</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>TaxAmount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>SO43701</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Christy Zhu</td>
      <td>christy12@adventure-works.com</td>
      <td>Mountain-100 Silver, 44</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>1</th>
      <td>SO43704</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Julio Ruiz</td>
      <td>julio1@adventure-works.com</td>
      <td>Mountain-100 Black, 48</td>
      <td>1</td>
      <td>3374.99</td>
      <td>269.9992</td>
    </tr>
    <tr>
      <th>2</th>
      <td>SO43705</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Curtis Lu</td>
      <td>curtis9@adventure-works.com</td>
      <td>Mountain-100 Silver, 38</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
  </tbody>
</table>
</div>



`.dtypes` shows the data type pandas has inferred for each column. This matters - if a numeric column has been read in as text (`object`), calculations on it will fail or behave unexpectedly:


```python
df.dtypes
```




    SalesOrderNumber            str
    SalesOrderLineNumber      int64
    OrderDate                   str
    CustomerName                str
    EmailAddress                str
    Item                        str
    Quantity                  int64
    UnitPrice               float64
    TaxAmount               float64
    dtype: object



`.info()` combines several of these into one summary, including how many non-null values are in each column:


```python
df.info()
```

    <class 'pandas.DataFrame'>
    RangeIndex: 32718 entries, 0 to 32717
    Data columns (total 9 columns):
     #   Column                Non-Null Count  Dtype  
    ---  ------                --------------  -----  
     0   SalesOrderNumber      32718 non-null  str    
     1   SalesOrderLineNumber  32718 non-null  int64  
     2   OrderDate             32718 non-null  str    
     3   CustomerName          32718 non-null  str    
     4   EmailAddress          32718 non-null  str    
     5   Item                  32718 non-null  str    
     6   Quantity              32718 non-null  int64  
     7   UnitPrice             32718 non-null  float64
     8   TaxAmount             32718 non-null  float64
    dtypes: float64(2), int64(2), str(5)
    memory usage: 2.2 MB


## Selecting Columns

We can select a single column using square brackets with the column name. This returns a **Series**:


```python
df['Item']
```




    0               Mountain-100 Silver, 44
    1                Mountain-100 Black, 48
    2               Mountain-100 Silver, 38
    3                    Road-650 Black, 62
    4                      Road-150 Red, 62
                          ...              
    32713               Patch Kit/8 Patches
    32714             Road-550-W Yellow, 48
    32715    Short-Sleeve Classic Jersey, S
    32716                Mountain Tire Tube
    32717               Patch Kit/8 Patches
    Name: Item, Length: 32718, dtype: str



To select more than one column, pass a list of names. This returns a **DataFrame** (note the double square brackets - the outer `[]` is selecting, the inner `[]` is the list of column names):


```python
df[['Item', 'UnitPrice']]
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
      <th>Item</th>
      <th>UnitPrice</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Mountain-100 Silver, 44</td>
      <td>3399.9900</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Mountain-100 Black, 48</td>
      <td>3374.9900</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Mountain-100 Silver, 38</td>
      <td>3399.9900</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Road-650 Black, 62</td>
      <td>699.0982</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Road-150 Red, 62</td>
      <td>3578.2700</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>32713</th>
      <td>Patch Kit/8 Patches</td>
      <td>2.2900</td>
    </tr>
    <tr>
      <th>32714</th>
      <td>Road-550-W Yellow, 48</td>
      <td>1120.4900</td>
    </tr>
    <tr>
      <th>32715</th>
      <td>Short-Sleeve Classic Jersey, S</td>
      <td>53.9900</td>
    </tr>
    <tr>
      <th>32716</th>
      <td>Mountain Tire Tube</td>
      <td>4.9900</td>
    </tr>
    <tr>
      <th>32717</th>
      <td>Patch Kit/8 Patches</td>
      <td>2.2900</td>
    </tr>
  </tbody>
</table>
<p>32718 rows × 2 columns</p>
</div>



## Selecting Rows

The most common way to select rows is with a **boolean mask**. First, a comparison on a column gives us a Series of `True`/`False` values:


```python
df['UnitPrice'] > 3000
```




    0         True
    1         True
    2         True
    3        False
    4         True
             ...  
    32713    False
    32714    False
    32715    False
    32716    False
    32717    False
    Name: UnitPrice, Length: 32718, dtype: bool



Passing that mask back into `df[...]` keeps only the rows where the value was `True`:


```python
df[df['UnitPrice'] > 3000]
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
      <th>SalesOrderNumber</th>
      <th>SalesOrderLineNumber</th>
      <th>OrderDate</th>
      <th>CustomerName</th>
      <th>EmailAddress</th>
      <th>Item</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>TaxAmount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>SO43701</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Christy Zhu</td>
      <td>christy12@adventure-works.com</td>
      <td>Mountain-100 Silver, 44</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>1</th>
      <td>SO43704</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Julio Ruiz</td>
      <td>julio1@adventure-works.com</td>
      <td>Mountain-100 Black, 48</td>
      <td>1</td>
      <td>3374.99</td>
      <td>269.9992</td>
    </tr>
    <tr>
      <th>2</th>
      <td>SO43705</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Curtis Lu</td>
      <td>curtis9@adventure-works.com</td>
      <td>Mountain-100 Silver, 38</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>4</th>
      <td>SO43703</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Albert Alvarez</td>
      <td>albert7@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>5</th>
      <td>SO43697</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Cole Watson</td>
      <td>cole1@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>2200</th>
      <td>SO46603</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Clayton Sharma</td>
      <td>clayton27@adventure-works.com</td>
      <td>Mountain-100 Silver, 42</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>2201</th>
      <td>SO46599</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Sierra Parker</td>
      <td>sierra7@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2202</th>
      <td>SO46598</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Evelyn Chandra</td>
      <td>evelyn2@adventure-works.com</td>
      <td>Road-150 Red, 44</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2203</th>
      <td>SO46602</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Troy Martinez</td>
      <td>troy19@adventure-works.com</td>
      <td>Road-150 Red, 48</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2205</th>
      <td>SO46601</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Daniel Lee</td>
      <td>daniel13@adventure-works.com</td>
      <td>Mountain-100 Silver, 42</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
  </tbody>
</table>
<p>1947 rows × 9 columns</p>
</div>



We can combine conditions using `&` (and) and `|` (or). Each condition needs its own parentheses:


```python
df[(df['UnitPrice'] > 3000) & (df['Quantity'] > 0)]
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
      <th>SalesOrderNumber</th>
      <th>SalesOrderLineNumber</th>
      <th>OrderDate</th>
      <th>CustomerName</th>
      <th>EmailAddress</th>
      <th>Item</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>TaxAmount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>SO43701</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Christy Zhu</td>
      <td>christy12@adventure-works.com</td>
      <td>Mountain-100 Silver, 44</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>1</th>
      <td>SO43704</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Julio Ruiz</td>
      <td>julio1@adventure-works.com</td>
      <td>Mountain-100 Black, 48</td>
      <td>1</td>
      <td>3374.99</td>
      <td>269.9992</td>
    </tr>
    <tr>
      <th>2</th>
      <td>SO43705</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Curtis Lu</td>
      <td>curtis9@adventure-works.com</td>
      <td>Mountain-100 Silver, 38</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>4</th>
      <td>SO43703</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Albert Alvarez</td>
      <td>albert7@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>5</th>
      <td>SO43697</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Cole Watson</td>
      <td>cole1@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>2200</th>
      <td>SO46603</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Clayton Sharma</td>
      <td>clayton27@adventure-works.com</td>
      <td>Mountain-100 Silver, 42</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>2201</th>
      <td>SO46599</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Sierra Parker</td>
      <td>sierra7@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2202</th>
      <td>SO46598</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Evelyn Chandra</td>
      <td>evelyn2@adventure-works.com</td>
      <td>Road-150 Red, 44</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2203</th>
      <td>SO46602</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Troy Martinez</td>
      <td>troy19@adventure-works.com</td>
      <td>Road-150 Red, 48</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>2205</th>
      <td>SO46601</td>
      <td>1</td>
      <td>2020-05-30</td>
      <td>Daniel Lee</td>
      <td>daniel13@adventure-works.com</td>
      <td>Mountain-100 Silver, 42</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
  </tbody>
</table>
<p>1947 rows × 9 columns</p>
</div>



## String Methods

Text columns have a `.str` accessor that gives us string operations applied across every row at once. For example, checking which rows contain a word:


```python
df[df['Item'].str.contains('Mountain')].head(3)
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
      <th>SalesOrderNumber</th>
      <th>SalesOrderLineNumber</th>
      <th>OrderDate</th>
      <th>CustomerName</th>
      <th>EmailAddress</th>
      <th>Item</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>TaxAmount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>SO43701</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Christy Zhu</td>
      <td>christy12@adventure-works.com</td>
      <td>Mountain-100 Silver, 44</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
    <tr>
      <th>1</th>
      <td>SO43704</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Julio Ruiz</td>
      <td>julio1@adventure-works.com</td>
      <td>Mountain-100 Black, 48</td>
      <td>1</td>
      <td>3374.99</td>
      <td>269.9992</td>
    </tr>
    <tr>
      <th>2</th>
      <td>SO43705</td>
      <td>1</td>
      <td>2019-07-01</td>
      <td>Curtis Lu</td>
      <td>curtis9@adventure-works.com</td>
      <td>Mountain-100 Silver, 38</td>
      <td>1</td>
      <td>3399.99</td>
      <td>271.9992</td>
    </tr>
  </tbody>
</table>
</div>



Other common ones are `.str.upper()`, `.str.lower()`, and `.str.strip()` (removes leading/trailing whitespace) - useful when cleaning up messy, inconsistently-cased data.

## Missing Values

Our sales data happens to be complete, so let's build a small example with some gaps to show how pandas handles them:


```python
example = pd.DataFrame({
    'product': ['Kettle', 'Toaster', 'Blender', 'Iron'],
    'price': [24.99, None, 18.50, None]
})
example
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
      <th>product</th>
      <th>price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Kettle</td>
      <td>24.99</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Toaster</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Blender</td>
      <td>18.50</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Iron</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



`.isnull()` flags missing values; combined with `.sum()` we get a count per column:


```python
example.isnull().sum()
```




    product    0
    price      2
    dtype: int64



`.dropna()` removes any row containing a missing value:


```python
example.dropna()
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
      <th>product</th>
      <th>price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Kettle</td>
      <td>24.99</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Blender</td>
      <td>18.50</td>
    </tr>
  </tbody>
</table>
</div>



Alternatively, `.fillna()` replaces missing values rather than dropping the rows - here filling with the average price:


```python
example['price'].fillna(example['price'].mean())
```




    0    24.990
    1    21.745
    2    18.500
    3    21.745
    Name: price, dtype: float64



## Sorting

`.sort_values()` orders a DataFrame by one or more columns. Use `ascending=False` for highest first:


```python
df.sort_values('UnitPrice', ascending=False).head(3)
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
      <th>SalesOrderNumber</th>
      <th>SalesOrderLineNumber</th>
      <th>OrderDate</th>
      <th>CustomerName</th>
      <th>EmailAddress</th>
      <th>Item</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>TaxAmount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1364</th>
      <td>SO45508</td>
      <td>1</td>
      <td>2020-01-27</td>
      <td>Roberto Sanz</td>
      <td>roberto18@adventure-works.com</td>
      <td>Road-150 Red, 62</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>1804</th>
      <td>SO46133</td>
      <td>1</td>
      <td>2020-04-03</td>
      <td>Abigail Foster</td>
      <td>abigail68@adventure-works.com</td>
      <td>Road-150 Red, 48</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
    <tr>
      <th>1070</th>
      <td>SO45134</td>
      <td>1</td>
      <td>2019-12-11</td>
      <td>Eduardo Perez</td>
      <td>eduardo36@adventure-works.com</td>
      <td>Road-150 Red, 56</td>
      <td>1</td>
      <td>3578.27</td>
      <td>286.2616</td>
    </tr>
  </tbody>
</table>
</div>



## Saving Data

Once we've selected or transformed the data we want, `.to_csv()` writes it back out. `index=False` stops pandas writing its own row-number index as an extra column:


```python
expensive_items = df[df['UnitPrice'] > 3000]
expensive_items.to_csv('expensive_items.csv', index=False)
print(f'Saved {len(expensive_items)} rows')
```

    Saved 1947 rows


##### END
