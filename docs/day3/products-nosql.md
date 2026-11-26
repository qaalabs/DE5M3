# MongoDB ~ Products in a NoSQL Database

!!! abstract "S7: Work with different types of data stores, such as SQL, NoSQL, and distributed file system."

## Could the product catalogue live in a NoSQL database?

HomeSphere's product catalogue arrives as JSON. Look at one product:

```json
{
  "product_id": "P001",
  "name": "Smart Thermostat Pro",
  "category": "Thermostats",
  "specs": {
    "rrp": 89.99,
    "warranty_years": 2,
    "colour": "White",
    "connectivity": "Wi-Fi"
  }
}
```

Each product is a self-contained record with a nested `specs` object inside it. In our pandas pipeline we flatten `specs` into columns so products can be joined to the sales data.

A **document database** doesn't need that flattening. It stores each product exactly as it is - nested object and all. MongoDB is the most widely used document database, and in this lab you load the HomeSphere products into it and query them.

### MongoDB in SQL terms

| Relational (SQL) | MongoDB |
|---|---|
| Database | Database |
| Table | Collection |
| Row | Document |
| Column | Field |
| Fixed schema - every row has the same columns | Flexible schema - documents in the same collection can have different fields |

---

## Initial Setup

We run MongoDB inside a **Docker container** - a self-contained, ready-to-run copy of the MongoDB server. Nothing gets installed on the VM itself, and when you're finished you can throw the container away.

- Login to your Virtual Machine
- On the desktop open: **Docker Desktop**

!!! warning "Wait for the Docker Engine to start"

Then open **Terminal** on your VM to get to a command prompt, and move into your `M3` folder:

```
cd Desktop\M3
```

---

## Step 1: Start MongoDB

Start MongoDB 4.4 (compatible with VMs without AVX support):

```
docker run -d -p 27017:27017 --name mongodb mongo:4.4
```

What this does:

- `docker run` - create and start a container
- `-d` - run it in the background
- `-p 27017:27017` - make MongoDB's port (27017) available on your VM
- `--name mongodb` - call the container `mongodb` so we can refer to it by name
- `mongo:4.4` - the image to use: MongoDB version 4.4

!!! note "Although version 5 has been released - v4.4 works on the virtual machines"

The first time you run this, Docker downloads the image, so it can take a minute.

Verify it's running:

```
docker ps
```

If MongoDB is running you should see something similar to the following:

```
CONTAINER ID  IMAGE      COMMAND                 CREATED      STATUS      PORTS                     NAMES
868de3409690  mongo:4.4  "docker-entrypoint.s…"  20 secs ago  Up 16 secs  0.0.0.0:27017->27017/tcp  mongodb
```

---

## Step 2: Copy the Products File into the Container

The products file is **`day3/data/products_nosql.json`**.

MongoDB is running inside the container, so the file needs to be in there too.

From your `M3` folder, run:

```
docker cp day3/data/products_nosql.json mongodb:/products_nosql.json
```

This copies the file from your VM into the root of the `mongodb` container.

---

## Step 3: Import the Products

MongoDB comes with a tool called `mongoimport` for loading files. We run it inside the container:

```
docker exec mongodb mongoimport --db homesphere --collection products --jsonArray --file /products_nosql.json
```

What this does:

- `docker exec mongodb` - run a command inside the `mongodb` container
- `--db homesphere` - load into a database called `homesphere`
- `--collection products` - load into a collection called `products`
- `--jsonArray` - the file is a JSON array: make each element a document
- `--file /products_nosql.json` - the file we just copied in

You should see:

```
9 document(s) imported successfully. 0 document(s) failed to import.
```

!!! note
    We didn't create the database, the collection or any table structure first. MongoDB created them when the data arrived.

---

## Step 4: Connect to the MongoDB Shell

```
docker exec -it mongodb mongo
```

You should see the MongoDB shell prompt: `>`

See all databases - `homesphere` was created by the import:

```javascript
show dbs
```

Switch to the `homesphere` database:

```javascript
use homesphere
```

---

## Step 5: Explore the Products

See collections in the current database:

```javascript
show collections
```

Count the products:

```javascript
db.products.countDocuments({})
```

See every product:

```javascript
db.products.find().pretty()
```

!!! note
    Each product has an `_id` field you didn't put in the file. MongoDB adds a unique `_id` to every document - it is the document's primary key.

See one product:

```javascript
db.products.findOne({ "product_id": "P001" })
```

---

### Hands-On Practice ~ Learners

**Task 1: Finding Products**

Find all cameras:

```javascript
db.products.find({ "category": "Cameras" }).pretty()
```

Show just the name of each product (1 = include the field, 0 = leave it out):

```javascript
db.products.find({}, { "name": 1, "_id": 0 })
```

Find all sensors - showing only name and category:

```javascript
db.products.find({ "category": "Sensors" }, { "name": 1, "category": 1, "_id": 0 })
```

**Task 2: Querying Inside the Nested Specs**

To reach a field inside `specs`, use **dot notation** - `"specs.colour"`. This is the query equivalent of the flattened `specs.colour` column you get in pandas.

Find all black products:

```javascript
db.products.find({ "specs.colour": "Black" }, { "name": 1, "_id": 0 })
```

Find products that connect over Zigbee:

```javascript
db.products.find({ "specs.connectivity": "Zigbee" }, { "name": 1, "_id": 0 })
```

Find products with an RRP over £50:

```javascript
db.products.find({ "specs.rrp": { $gt: 50 } }, { "name": 1, "specs.rrp": 1, "_id": 0 })
```

Find products with an RRP between £15 and £30:

```javascript
db.products.find({ "specs.rrp": { $gte: 15, $lte: 30 } }, { "name": 1, "specs.rrp": 1, "_id": 0 })
```

Cheapest first (1 = ascending, -1 = descending):

```javascript
db.products.find({}, { "name": 1, "specs.rrp": 1, "_id": 0 }).sort({ "specs.rrp": 1 })
```

**Task 3: Answer These Questions**

Write your own queries to answer:

1. How many products have a 2-year warranty?
2. Which is the most expensive product?
3. Which white products connect over Wi-Fi?

??? tip "Show the queries"
    **1.** How many products have a 2-year warranty?

    ```javascript
    db.products.countDocuments({ "specs.warranty_years": 2 })
    ```

    **2.** Which is the most expensive product?

    ```javascript
    db.products.find({}, { "name": 1, "specs.rrp": 1, "_id": 0 }).sort({ "specs.rrp": -1 }).limit(1)
    ```

    **3.** Which white products connect over Wi-Fi?

    ```javascript
    db.products.find({ "specs.colour": "White", "specs.connectivity": "Wi-Fi" }, { "name": 1, "_id": 0 })
    ```

**Task 4: Count Products per Category**

MongoDB's **aggregation pipeline** is its equivalent of `GROUP BY`:

```javascript
db.products.aggregate([
  { $group: { _id: "$category", products: { $sum: 1 } } }
])
```

---

### Discussion

- How does `"specs.rrp"` compare with the way we reach the same value in pandas?
- Did you need to know the structure of the data before you loaded it?

---

## Step 6: Flexible Schema

HomeSphere is launching a video doorbell. It has specs none of the other products have - a camera resolution and a battery life.

In a SQL table we would need to add new columns first, and every other product would get empty values in them. In MongoDB we just insert it:

```javascript
db.products.insertOne({
  product_id: "P010",
  name: "Smart Video Doorbell",
  category: "Cameras",
  specs: {
    rrp: 99.99,
    warranty_years: 2,
    colour: "Black",
    connectivity: "Wi-Fi",
    resolution: "1080p",
    battery_life_months: 6
  }
})
```

The other cameras are unchanged:

```javascript
db.products.find({ "category": "Cameras" }).pretty()
```

!!! note
    See how the new product has fields the others don't - this is the power of flexible schema!

---

### Hands-On Practice ~ Learners

**Task 1: Query a Field Only Some Products Have**

Find products that have a battery:

```javascript
db.products.find({ "specs.battery_life_months": { $exists: true } }, { "name": 1, "_id": 0 })
```

What happens when you query a field that most documents don't have?

```javascript
db.products.find({ "specs.resolution": "1080p" }, { "name": 1, "_id": 0 })
```

**Task 2: Add Your Own Product**

Insert a new HomeSphere product of your own - for example a smart light bulb with a `brightness_lumens` spec, or a smart lock with a `battery_life_months` spec.

Then write a query that finds it using one of its new spec fields.

---

### Discussion

**Right store for the right data**

- Why does a product catalogue suit a document database? Think about what happens as HomeSphere adds new kinds of product.
- Would `sales_raw.csv` suit a document database as well? Every sale has the same fields - what does flexible schema buy you there?
- If HomeSphere kept its catalogue in MongoDB, which part of our pipeline would change - extract, transform or load? Which parts would stay the same?
- Our pipeline joins products to sales. Where is that join easier - in MongoDB or in pandas?

---

## Wrap-Up

### What We've Learned

1. **Documents**: each product is stored as a whole document, nested `specs` and all - no flattening needed to store it

2. **Loading a file**: `mongoimport` loads a JSON array as one document per element

3. **Dot notation**: `"specs.rrp"` queries inside a nested object

4. **Flexible schema**: new products can bring new fields without changing the existing ones

5. **Right store for the right data**: varied product data suits a document store; uniform sales rows suit a table

---

## Quick Reference Commands

```javascript
// Database operations
use <database>              // Switch to database
show dbs                    // List databases
show collections            // List collections

// Finding
db.<collection>.find()                              // Find all documents
db.<collection>.find().pretty()                     // Format output nicely
db.<collection>.find({ field: value })              // Find with filter
db.<collection>.find({ "nested.field": value })     // Filter on a nested field
db.<collection>.find({}, { field: 1, _id: 0 })      // Show only some fields
db.<collection>.findOne({ field: value })           // Find the first match

// Comparison operators
{ field: { $gt: 50 } }              // greater than
{ field: { $gte: 15, $lte: 30 } }   // between (inclusive)
{ field: { $exists: true } }        // field is present

// Counting, sorting, grouping
db.<collection>.countDocuments({})                  // Count documents
db.<collection>.find().sort({ field: 1 })           // Sort (1=asc, -1=desc)
db.<collection>.find().limit(5)                     // Limit results
db.<collection>.aggregate([{ $group: { _id: "$field", n: { $sum: 1 } } }])   // Count per group

// Inserting
db.<collection>.insertOne({})                       // Insert one document
```

To leave the MongoDB shell, type `exit`.

---

## Troubleshooting

**Container not starting?**

```
docker logs mongodb
```

**"The container name "/mongodb" is already in use"?**

You already have a `mongodb` container on this VM. Start it instead of creating a new one:
```
docker start mongodb
```

**Can't connect to mongo shell?**

Check container is running:

```
docker ps
```

Restart if needed:

```
docker restart mongodb
```

**Import failed, or imported 1 document instead of 9?**

Check you are using `products_nosql.json` (not `products_raw.json`) and included `--jsonArray`. If anything was imported, drop the collection in the MongoDB shell and import again:
```javascript
db.products.drop()
```

**Want to start fresh?**

Stop and remove container:

```
docker stop mongodb
docker rm mongodb
```

Start new container:

```
docker run -d -p 27017:27017 --name mongodb mongo:4.4
```
