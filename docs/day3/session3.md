# Day 3 ~ Session 3 Structure (75 mins)

**Multi-Source Integration + Unstructured Data Extraction (S16, S7, K17)**

## Approach: Show & Discuss Pattern

### **Part 1: Multi-Source Integration** (~30 mins)

- Combining SQL + NoSQL + files (their customer data extended)
- Schema conflicts and resolution strategies
- Discussion: their workplace data sources

### **Part 2: Unstructured Data Extraction (S16)** (~40 mins)

**Example 1**: Log file parsing (10 mins)

- Show the pattern: text → structured DataFrame
- Run the code, observe output
  
**Example 2**: PDF data extraction (10 mins)

- Library like PyPDF2 or pdfplumber
- Extract tables or text from invoice/report
- Run and see structured output

**Example 3**: Image text extraction (10 mins)

- OCR with pytesseract or similar
- Maybe a scanned receipt or document
- Show limitations and possibilities

**Example 4** (optional): JSON/XML parsing (5-10 mins)

- Semi-structured, but still needs extraction logic
- API responses, config files

### **Discussion**: Where does this fit? (5 mins)

- Which sources in their organisations?
- Integration into ETL pipelines
- When is it worth automating vs manual handling?

---

### Teaching Notes

Each example:

- **Pre-built code** (not writing from scratch)
- **Clear before/after** (unstructured input → structured output)
- **Run and observe** (not debugging or developing)
- **2-3 discussion questions** per example

This keeps momentum: concept → example → observe → discuss → next

## What You'll Need

For each example, prepare:

1. Sample unstructured file (log.txt, invoice.pdf, receipt.jpg, data.json)
2. Python notebook with extraction code
3. Output showing structured DataFrame
4. 2-3 discussion questions
