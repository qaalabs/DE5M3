# HomeSphere Pipeline - Solution Diagram

*The completed medallion architecture after Day 3.*

```mermaid
flowchart LR
    subgraph SRC["Sources"]
        CSV_FILE["sales_raw.csv"]
        JSON_FILE["products_raw.json"]
    end

    subgraph BRZ["Bronze - raw, untouched"]
        BCSV["Files/bronze/<br/>sales_raw.csv"]
        BJSON["Files/bronze/<br/>products_raw.json"]
    end

    subgraph NB1["Notebook: Bronze to Silver"]
        CLEAN["clean + validate<br/>(strip £, parse dates,<br/>drop bad rows, assert checks)"]
        FLAT["flatten JSON<br/>(json_normalize)"]
    end

    subgraph SIL["Silver - cleaned & trusted"]
        SS["silver_sales"]
        SP["silver_products"]
    end

    subgraph NB2["Notebook: Silver to Gold"]
        JOIN["join on product_id<br/>compute line_value"]
    end

    subgraph GLD["Gold - business-ready"]
        GR["gold_revenue<br/>(revenue by category)"]
    end

    CSV_FILE --> BCSV
    JSON_FILE --> BJSON
    BCSV --> CLEAN
    BJSON --> FLAT
    CLEAN --> SS
    FLAT --> SP
    SS --> JOIN
    SP --> JOIN
    JOIN --> GR
```

| Layer  | Items | Rule |
|--------|-------|------|
| Bronze | `Files/bronze/sales_raw.csv`, `Files/bronze/products_raw.json` | Never modified after landing |
| Silver | `silver_sales`, `silver_products` | Cleaned, validated - safe to build from |
| Gold   | `gold_revenue` | Built from silver only - answers the business question |

---

### Diagram ~ Top to Bottom

```mermaid
flowchart TB
    subgraph SRC["Sources"]
        CSV_FILE["sales_raw.csv"]
        JSON_FILE["products_raw.json"]
    end

    subgraph BRZ["Bronze - raw, untouched"]
        BCSV["Files/bronze/<br/>sales_raw.csv"]
        BJSON["Files/bronze/<br/>products_raw.json"]
    end

    subgraph NB1["Notebook: Bronze to Silver"]
        CLEAN["clean + validate<br/>(strip £, parse dates,<br/>drop bad rows, assert checks)"]
        FLAT["flatten JSON<br/>(json_normalize)"]
    end

    subgraph SIL["Silver - cleaned & trusted"]
        SS["silver_sales"]
        SP["silver_products"]
    end

    subgraph NB2["Notebook: Silver to Gold"]
        JOIN["join on product_id<br/>compute line_value"]
    end

    subgraph GLD["Gold - business-ready"]
        GR["gold_revenue<br/>(revenue by category)"]
    end

    CSV_FILE --> BCSV
    JSON_FILE --> BJSON
    BCSV --> CLEAN
    BJSON --> FLAT
    CLEAN --> SS
    FLAT --> SP
    SS --> JOIN
    SP --> JOIN
    JOIN --> GR
```

---

### Mermaid Diagram Code

```text
flowchart LR
    subgraph SRC["Sources"]
        CSV_FILE["sales_raw.csv"]
        JSON_FILE["products_raw.json"]
    end

    subgraph BRZ["Bronze - raw, untouched"]
        BCSV["Files/bronze/<br/>sales_raw.csv"]
        BJSON["Files/bronze/<br/>products_raw.json"]
    end

    subgraph NB1["Notebook: Bronze to Silver"]
        CLEAN["clean + validate<br/>(strip £, parse dates,<br/>drop bad rows, assert checks)"]
        FLAT["flatten JSON<br/>(json_normalize)"]
    end

    subgraph SIL["Silver - cleaned & trusted"]
        SS["silver_sales"]
        SP["silver_products"]
    end

    subgraph NB2["Notebook: Silver to Gold"]
        JOIN["join on product_id<br/>compute line_value"]
    end

    subgraph GLD["Gold - business-ready"]
        GR["gold_revenue<br/>(revenue by category)"]
    end

    CSV_FILE --> BCSV
    JSON_FILE --> BJSON
    BCSV --> CLEAN
    BJSON --> FLAT
    CLEAN --> SS
    FLAT --> SP
    SS --> JOIN
    SP --> JOIN
    JOIN --> GR
```

