## A new requirement

So far, HomeSphere's product catalogue has arrived as a file - `products_raw.json` - uploaded manually before the pipeline runs.

That works. But it has a problem.

What happens when a product is added? Or a price changes? Someone has to remember to upload a new file. And until they do, your pipeline is running on stale data.

HomeSphere has solved this by exposing their product catalogue through an API - a live endpoint your pipeline can call programmatically, whenever it needs fresh data.

Your job today is to understand that API and then update your pipeline to use it.

## What is an API?

An API (Application Programming Interface) is a way for one system to request data from another over a network.

Instead of a file sitting on disk, you send a request to a URL and get data back - usually in JSON format.

You have almost certainly used APIs without knowing it:
- a weather app requesting a forecast
- a payment system checking a card
- a map showing live traffic

Your pipeline is about to do the same thing.

## Introducing the HomeSphere Product API

HomeSphere's product API is documented and testable at:

🔗 https://api.qaalabs.com/homesphere/v1/

This interface is called **Swagger UI** - it lets you explore and test an API without writing any code first.

Before you write a single line of Python, spend a few minutes reading the next section and then exploring the interface.

## Reading the Swagger UI

When you open the link you will see a list of endpoints - these are the URLs your pipeline can call.

Each endpoint shows:
- the **method** - GET means you are requesting data
- the **path** - the URL you call
- a short **description** of what it returns

You can click on any endpoint to expand it, then click **Try it out** to send a real request and see a real response.

Work through the questions below before writing any code.

## Explore the API

**Q1 - What endpoints are available?**  
List all the endpoints you can see. What pattern do you notice?

**Q2 - Try `/homesphere/v1/product`**  
Click Try it out → Execute. Look at the response.  
- How many products are returned?  
- How is the data structured - is it flat or nested?  
- Does this look familiar?

**Q3 - Try `/homesphere/v1/product/{id}`**  
Request a single product using the ID `P001`.  
- What does the response look like?  
- What would happen if you requested an ID that doesn't exist?

**Q4 - Try `/homesphere/v1/product1`**  
Click Try it out → Execute without filling anything in.  
- What happens?  
- What does the response tell you?  
- Now look at the endpoint description - what does it require?

**Q5 - Compare `/product`, `/product1`, and `/product2`**  
All three return the same data. What is different about each one?  
Why might a real API require authentication?

**Q6 - Before you write any code**  
Looking at the response from Q2 - what will you need to do to this data before you can join it to the sales data?  
Think about what `flatten_products()` did on Day 1.

## From exploration to code

You've seen what the API returns. Now you need to use it in Python.

In your Day 1 pipeline, `flatten_products()` read from a local file:

```python
with open("products_raw.json") as f:
    data = json.load(f)
```

That no longer works. The data isn't in a file - it's at a URL.

Your task is to write `extract_products_from_api()` that:
- calls the HomeSphere product API
- handles the nested `specs` structure
- returns a DataFrame in the same shape as `flatten_products()` did

The rest of your pipeline - the join, the aggregation - should not need to change.

## Setup


```python
import requests
import pandas as pd
import json
```

## Solution - extract products from the API


```python
BASE_URL = "https://api.qaalabs.com/homesphere/v1"

def extract_products_from_api(base_url):
    response = requests.get(f"{base_url}/product")
    
    if response.status_code != 200:
        raise Exception(f"API request failed with status {response.status_code}")
    
    data = response.json()
    
    products = []
    for product in data:
        products.append({
            "product_id"     : product["product_id"],
            "name"           : product["name"],
            "category"       : product["category"],
            "rrp"            : product["specs"]["rrp"],
            "warranty_years" : product["specs"]["warranty_years"],
            "colour"         : product["specs"]["colour"],
            "connectivity"   : product["specs"]["connectivity"]
        })
    
    return pd.DataFrame(products)
```

## Test


```python
products = extract_products_from_api(BASE_URL)
print(f"Products loaded: {len(products)}")
print(f"Columns: {list(products.columns)}")
products.head()
```

## Does the rest of the pipeline still work?

The extraction has changed - the join and aggregation should not need to.


```python
def clean_sales(path="../HomeSphere/data/sales_raw.csv"):
    df = pd.read_csv(path)
    df["unit_price"] = df["unit_price"].astype(str).str.replace("£", "", regex=False).astype(float)
    df["order_date"] = pd.to_datetime(df["order_date"], format="mixed", dayfirst=True, errors="coerce")
    df["quantity"] = pd.to_numeric(df["quantity"], errors="coerce")
    df = df.dropna(subset=["quantity"])
    df["quantity"] = df["quantity"].astype(int)
    df["status"] = df["status"].str.lower().str.strip()
    df = df.drop_duplicates()
    df = df.dropna(subset=["product_id"])
    df["region"] = df["region"].fillna("Unknown")
    df = df[df["unit_price"] > 0]
    df = df[df["quantity"] > 0]
    return df

def join_and_aggregate(sales, products):
    df = sales.merge(products, on="product_id", how="left")
    df["line_value"] = df["quantity"] * df["unit_price"]
    revenue = (
        df.groupby("category")["line_value"]
        .sum()
        .sort_values(ascending=False)
        .reset_index()
    )
    revenue.columns = ["category", "total_revenue"]
    revenue["total_revenue"] = revenue["total_revenue"].round(2)
    return df, revenue

sales = clean_sales()
products = extract_products_from_api(BASE_URL)
joined, revenue = join_and_aggregate(sales, products)

total = joined["line_value"].sum()
print(f"=== Revenue by Category (total £{total:,.2f}) ===")
for _, row in revenue.iterrows():
    print(f"  {row['category']:<20} £{row['total_revenue']:>8,.2f}")
```

## Stretch 1 - header authentication

Solution using `/product1` with `X-API-Key` header.


```python
API_KEY = ""  # <-- Get this from your trainer

def extract_products_from_api_auth(base_url):
    headers = {"X-API-Key": API_KEY}
    
    response = requests.get(f"{base_url}/product1", headers=headers)
    
    if response.status_code != 200:
        raise Exception(f"API request failed with status {response.status_code}")
    
    data = response.json()
    
    products = []
    for product in data:
        products.append({
            "product_id"     : product["product_id"],
            "name"           : product["name"],
            "category"       : product["category"],
            "rrp"            : product["specs"]["rrp"],
            "warranty_years" : product["specs"]["warranty_years"],
            "colour"         : product["specs"]["colour"],
            "connectivity"   : product["specs"]["connectivity"]
        })
    
    return pd.DataFrame(products)

products = extract_products_from_api_auth(BASE_URL)
print(f"Products loaded: {len(products)}")
products.head()
```

### A note on hardcoded keys

`API_KEY = "<training-key>"` works - but it is not a good pattern.

The key is now sitting in your code. If this notebook is committed to a Git repository, the key is exposed to anyone who can read it. If the key changes, you have to find and update every place it appears.

In production pipelines, credentials are typically handled in one of these ways:

- **Environment variables** - the key lives outside the code, set on the machine or in the pipeline configuration
- **Secrets manager** - a dedicated service (Azure Key Vault, AWS Secrets Manager) stores and rotates credentials securely

For now, a hardcoded constant is fine for a training exercise. In your workplace pipeline, it should not be.

## Stretch 2 - query parameter authentication

Solution using `/product2` with `api_key` query parameter.


```python
API_KEY_PARAM = ""  # <-- Get this from your trainer

def extract_products_from_api_param(base_url):
    params = {"api_key": API_KEY_PARAM}
    
    response = requests.get(f"{base_url}/product2", params=params)
    
    if response.status_code != 200:
        raise Exception(f"API request failed with status {response.status_code}")
    
    data = response.json()
    
    products = []
    for product in data:
        products.append({
            "product_id"     : product["product_id"],
            "name"           : product["name"],
            "category"       : product["category"],
            "rrp"            : product["specs"]["rrp"],
            "warranty_years" : product["specs"]["warranty_years"],
            "colour"         : product["specs"]["colour"],
            "connectivity"   : product["specs"]["connectivity"]
        })
    
    return pd.DataFrame(products)

products = extract_products_from_api_param(BASE_URL)
print(f"Products loaded: {len(products)}")
products.head()
```

### Header vs query parameter - which is more secure?

Query parameters appear in the URL:

```
https://api.qaalabs.com/homesphere/v1/product2?api_key=<training-key>
```

That URL can appear in:
- browser history
- server access logs
- network monitoring tools

Headers are not part of the URL. They travel in the request but are not logged in the same way.

For this reason, header-based authentication is generally preferred over query parameter authentication in production APIs.
