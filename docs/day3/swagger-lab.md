# Swagger ~ Read from a Live API

!!! abstract "K18: How to use streaming, batching and on-demand services to move data from one location to another."

!!! abstract "S16: Develop algorithms and processes to extract structured data from unstructured sources."

## A new requirement

So far, HomeSphere's product catalogue has arrived as a file - `products_raw.json` - uploaded manually before the pipeline runs.

That works. But it has a problem.

What happens when a product is added? Or a price changes? Someone has to remember to upload a new file. And until they do, your pipeline is running on stale data.

HomeSphere has solved this by exposing their product catalogue through an API - a live endpoint your pipeline can call programmatically, whenever it needs fresh data.

Your job today is to understand that API and then update your pipeline to use it.

Open the notebook: **`day3/api/homesphere_api_todo.ipynb`** and work through it alongside this page.

---

## What is an API?

An API (Application Programming Interface) is a way for one system to request data from another over a network.

Instead of a file sitting on disk, you send a request to a URL and get data back - usually in JSON format.

You have almost certainly used APIs without knowing it:

- a weather app requesting a forecast
- a payment system checking a card
- a map showing live traffic

Your pipeline is about to do the same thing.

---

## Introducing the HomeSphere Product API

HomeSphere's product API is documented and testable at:

🔗 https://api.qaalabs.com/homesphere/v1/

This interface is called **Swagger UI** - it lets you explore and test an API without writing any code first.

Before you write a single line of Python, spend a few minutes reading this page and then exploring the interface.

---

## Explore the API

Work through these before writing any code:

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

---

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

The base URL is: `https://api.qaalabs.com/homesphere/v1`

---

## Stretch 1 - what happens when the source requires authentication?

Change your function to call `/product1` instead of `/product`. Run it without changing anything else first.

- What happens?
- What does the response tell you?
- What does this mean for your pipeline?

Now fix it. The endpoint requires a header: `X-API-Key: <training-key>`

```python
requests.get(url, headers={"X-API-Key": "your-key-here"})
```

Once it works, think about this:

- Where did you put the key in your code?
- Is that a good place for it?
- What happens when the key changes?

---

## Stretch 2 - query parameter authentication

`/product2` uses a different authentication pattern - instead of a header, the key is passed as a query parameter.

```python
requests.get(url, params={"api_key": "your-key-here"})
```

- What is different about this approach compared to `/product1`?
- Which do you think is more secure, and why?

---

## Discussion

- The product data used to arrive as a batch file. Now it arrives on demand. What actually changed about your pipeline - and what stayed the same?
- If a price changes on HomeSphere's system right now, how long before your pipeline would see it?
- What would happen to your pipeline if the API was temporarily unavailable?
