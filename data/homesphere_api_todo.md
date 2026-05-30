## A new requirement

So far, HomeSphere's product catalogue has arrived as a file — `products_raw.json` — uploaded manually before the pipeline runs.

That works. But it has a problem.

What happens when a product is added? Or a price changes? Someone has to remember to upload a new file. And until they do, your pipeline is running on stale data.

HomeSphere has solved this by exposing their product catalogue through an API — a live endpoint your pipeline can call programmatically, whenever it needs fresh data.

Your job today is to understand that API and then update your pipeline to use it.

## What is an API?

An API (Application Programming Interface) is a way for one system to request data from another over a network.

Instead of a file sitting on disk, you send a request to a URL and get data back — usually in JSON format.

You have almost certainly used APIs without knowing it:
- a weather app requesting a forecast
- a payment system checking a card
- a map showing live traffic

Your pipeline is about to do the same thing.

## Introducing the HomeSphere Product API

HomeSphere's product API is documented and testable at:

🔗 https://api.qaalabs.com/homesphere/v1

This interface is called **Swagger UI** — it lets you explore and test an API without writing any code first.

Before you write a single line of Python, spend a few minutes reading the next section and then exploring the interface.

## Reading the Swagger UI

When you open the link you will see a list of endpoints — these are the URLs your pipeline can call.

Each endpoint shows:
- the **method** — GET means you are requesting data
- the **path** — the URL you call
- a short **description** of what it returns

You can click on any endpoint to expand it, then click **Try it out** to send a real request and see a real response.

Work through the questions below before writing any code.

## Explore the API

**Q1 — What endpoints are available?**  
List all the endpoints you can see. What pattern do you notice?

**Q2 — Try `/homesphere/v1/product`**  
Click Try it out → Execute. Look at the response.  
- How many products are returned?  
- How is the data structured — is it flat or nested?  
- Does this look familiar?

**Q3 — Try `/homesphere/v1/product/{id}`**  
Request a single product using the ID `P001`.  
- What does the response look like?  
- What would happen if you requested an ID that doesn't exist?

**Q4 — Try `/homesphere/v1/product1`**  
Click Try it out → Execute without filling anything in.  
- What happens?  
- What does the response tell you?  
- Now look at the endpoint description — what does it require?

**Q5 — Compare `/product`, `/product1`, and `/product2`**  
All three return the same data. What is different about each one?  
Why might a real API require authentication?

**Q6 — Before you write any code**  
Looking at the response from Q2 — what will you need to do to this data before you can join it to the sales data?  
Think about what `flatten_products()` did on Day 1.

## From exploration to code

You've seen what the API returns. Now you need to use it in Python.

In your Day 1 pipeline, `flatten_products()` read from a local file:

```python
with open("products_raw.json") as f:
    data = json.load(f)
```

That no longer works. The data isn't in a file — it's at a URL.

Your task is to write `extract_products_from_api()` that:
- calls the HomeSphere product API
- handles the nested `specs` structure
- returns a DataFrame in the same shape as `flatten_products()` did

The rest of your pipeline — the join, the aggregation — should not need to change.

## Setup

Run the cell below to import the libraries you will need.


```python
import requests
import pandas as pd
import json
```

## Exercise — extract products from the API

Replace `flatten_products()` with a function that pulls data from the HomeSphere product API instead of a local file.

The base URL is: `https://api.qaalabs.com/homesphere/v1`


```python
BASE_URL = "https://api.qaalabs.com/homesphere/v1"

def extract_products_from_api(base_url):
    # TODO: call the correct endpoint to retrieve all products
    # HINT: use requests.get() and check response.status_code
    
    # TODO: parse the JSON response
    
    # TODO: flatten the nested specs into columns
    # HINT: look at what flatten_products() did on Day 1
    
    # TODO: return a DataFrame with these columns:
    # product_id, name, category, rrp, warranty_years, colour, connectivity
    
    pass
```

## Test your function

Run the cell below to check your function returns the right shape.


```python
products = extract_products_from_api(BASE_URL)
print(f"Products loaded: {len(products)}")
print(f"Columns: {list(products.columns)}")
products.head()
```

## Does the rest of the pipeline still work?

Load the sales data and confirm the join still works — nothing downstream should need to change.


```python
sales = pd.read_csv("../data/sales_raw.csv")

# TODO: copy your clean_sales() and join_and_aggregate() functions from Day 1
# and confirm the pipeline still produces the same revenue summary
```

## Stretch 1 — what happens when the source requires authentication?

Change your function to call `/product1` instead of `/product`.

Run it without changing anything else first.

- What happens?
- What does the response tell you?
- What does this mean for your pipeline?

Now fix it. The endpoint requires a header:

`X-API-Key: training-key-header`

**Hint:** `requests.get()` accepts a `headers` parameter:

```python
requests.get(url, headers={"X-API-Key": "your-key-here"})
```

Once it works, think about this:

- where did you put the key in your code?
- is that a good place for it?
- what happens when the key changes?


```python
# TODO: write extract_products_from_api_auth() using /product1
# Remember to handle the X-API-Key header

pass
```

## Stretch 2 — query parameter authentication

`/product2` uses a different authentication pattern — instead of a header, the key is passed as a query parameter.

The key is: `training-key-param`

**Hint:** `requests.get()` accepts a `params` parameter:

```python
requests.get(url, params={"api_key": "your-key-here"})
```

- What is different about this approach compared to `/product1`?
- Which do you think is more secure, and why?


```python
# TODO: write extract_products_from_api_param() using /product2
# Remember to handle the api_key query parameter

pass
```
