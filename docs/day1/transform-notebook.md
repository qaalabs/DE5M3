# Customer Data ETL Challenge

**Scenario**: You work for a company that has customer data scattered across different systems. Your job is to clean and combine this data to create a unified customer view.

**Learning Objectives**:
- Understand real-world data quality issues
- Practice Extract, Transform, Load (ETL) concepts
- Learn to make data-driven decisions

**Instructions**: 
- Read each cell carefully
- Run the code and observe the output
- Complete the TODO sections
- Discuss your decisions with your peers

## Step 1: Import Libraries and Load Data

First, let's import the Python libraries we'll need and load our messy customer data.


```python
import pandas as pd
import numpy as np

# Our messy customer data from the CRM system
crm_data = {
    'customer_id': [1001, 1002, '', 1004, 1005, 1006, 1007],
    'first_name': ['John', 'jane', 'MIKE', '', 'Sarah', 'Bob', 'alice'],
    'last_name': ['Smith', 'DOE', 'Johnson', 'Wilson', '', 'Brown', 'Cooper'],
    'email': ['john@email.com', 'JANE@EMAIL.COM', 'mike@invalid', 
              'sarah@email.com', 'bob@email.com', '', 'alice@email.com'],
    'phone': ['01234567890', '0987654321', 'invalid', '', '01111111111', 
              '02222222222', '03333333333'],
    'status': ['active', 'ACTIVE', 'inactive', 'Active', 'suspended', 'active', '']
}

# Create a DataFrame (think of it as an Excel table in Python)
df = pd.DataFrame(crm_data)

print("Raw customer data from CRM system:")
print(df)
```

## Step 2: Investigate Data Quality Issues

Let's examine our data to identify problems. This is a crucial first step in any ETL process.


```python
print("=== DATA INVESTIGATION ===")
print(f"Total records: {len(df)}")
print(f"\nData types:")
print(df.dtypes)
print(f"\nMissing values:")
print(df.isnull().sum())
print(f"\nEmpty strings (not technically missing, but problematic):")
print((df == '').sum())
```

### 🤔 Discussion Point
Look at the output above. What problems do you notice with this data? 

Write your observations here:
- Problem 1: 
- Problem 2: 
- Problem 3: 

(*Hint: Look at customer IDs, name formatting, email addresses, and status values*)

## Step 3: Clean Customer IDs (Guided Example)

Customer ID is critical - we can't have records without valid IDs. Let's fix this first.


```python
print("Before cleaning - Customer IDs:")
print(df['customer_id'].tolist())

# Remove rows where customer_id is empty
df_clean = df[df['customer_id'] != ''].copy()

# Convert to integer (pandas often loads numbers as text)
df_clean['customer_id'] = df_clean['customer_id'].astype(int)

print("\nAfter cleaning - Customer IDs:")
print(df_clean['customer_id'].tolist())
print(f"\nRecords removed: {len(df) - len(df_clean)}")
```

## Step 4: Clean Names (Your Turn!)

Names should be properly formatted for consistency. Complete the TODO sections below.


```python
print("Before cleaning - Names:")
print("First names:", df_clean['first_name'].tolist())
print("Last names:", df_clean['last_name'].tolist())

# TODO: Clean first names
# Hint: Use .str.title() to make names like "jane" become "Jane"
# Hint: Handle empty strings by replacing them with 'Unknown'

# Example for first_name:
df_clean['first_name'] = df_clean['first_name'].replace('', 'Unknown')
df_clean['first_name'] = df_clean['first_name'].str.title()

# TODO: Now you do the same for last_name
# YOUR CODE HERE:


print("\nAfter cleaning - Names:")
print("First names:", df_clean['first_name'].tolist())
print("Last names:", df_clean['last_name'].tolist())
```

## Step 5: Validate Email Addresses

Email validation is crucial for marketing campaigns. Let's identify valid vs invalid emails.


```python
print("Current email addresses:")
print(df_clean['email'].tolist())

# Simple email validation - must contain @ and .
def is_valid_email(email):
    if email == '':
        return False
    return '@' in email and '.' in email

# TODO: Apply the validation function
# Hint: Use .apply() to run the function on each email
df_clean['email_valid'] = df_clean['email'].apply(is_valid_email)

# TODO: Standardise email format (lowercase)
# YOUR CODE HERE:
df_clean['email'] = df_clean['email'].str.lower()

print("\nEmail validation results:")
print(df_clean[['email', 'email_valid']])

# Count valid vs invalid
print(f"\nValid emails: {df_clean['email_valid'].sum()}")
print(f"Invalid emails: {(~df_clean['email_valid']).sum()}")
```

## Step 6: Standardise Status Values

Business systems need consistent status values. Let's fix the inconsistent capitalisation.


```python
print("Current status values:")
print(df_clean['status'].tolist())
print("\nUnique status values:")
print(df_clean['status'].unique())

# TODO: Standardise status values
# 1. Convert to lowercase
# 2. Handle empty strings (what should the default status be?)

# YOUR CODE HERE:
df_clean['status'] = df_clean['status'].str.lower()
df_clean['status'] = df_clean['status'].replace('', 'unknown')

print("\nAfter standardisation:")
print("Status values:", df_clean['status'].tolist())
print("Unique status values:", df_clean['status'].unique())

# Count each status
print("\nStatus distribution:")
print(df_clean['status'].value_counts())
```

## Step 7: Handle Phone Numbers (Challenge)

Phone numbers are tricky! Let's create a simple validation.


```python
print("Current phone numbers:")
print(df_clean['phone'].tolist())

# TODO: Create a function to validate UK phone numbers
# Simple rule: Must be 11 digits starting with 0
def is_valid_uk_phone(phone):
    if phone == '':
        return False
    # TODO: Check if phone is 11 digits and starts with 0
    # Hint: Use .isdigit() to check if string contains only numbers
    # Hint: Use len() to check length
    
    # YOUR CODE HERE:
    if len(phone) == 11 and phone.startswith('0') and phone.isdigit():
        return True
    return False

# Apply validation
df_clean['phone_valid'] = df_clean['phone'].apply(is_valid_uk_phone)

print("\nPhone validation results:")
print(df_clean[['phone', 'phone_valid']])
```

## Step 8: Create Data Quality Report

Always document your data quality findings for stakeholders.


```python
print("=== DATA QUALITY REPORT ===")
print(f"Total records processed: {len(df_clean)}")
print(f"Records removed (missing customer ID): {len(df) - len(df_clean)}")
print()
print("Field Quality Summary:")
print(f"- Valid emails: {df_clean['email_valid'].sum()}/{len(df_clean)} ({df_clean['email_valid'].mean():.1%})")
print(f"- Valid phone numbers: {df_clean['phone_valid'].sum()}/{len(df_clean)} ({df_clean['phone_valid'].mean():.1%})")
print(f"- Unknown first names: {(df_clean['first_name'] == 'Unknown').sum()}")
print(f"- Unknown last names: {(df_clean['last_name'] == 'Unknown').sum()}")
print()
print("Customer Status Distribution:")
for status, count in df_clean['status'].value_counts().items():
    percentage = count / len(df_clean) * 100
    print(f"- {status.title()}: {count} ({percentage:.1f}%)")
```

## Step 9: Final Clean Dataset

Let's see our cleaned data and save it for further processing.


```python
# Create final dataset with just the cleaned core fields
final_df = df_clean[['customer_id', 'first_name', 'last_name', 'email', 'phone', 'status']].copy()

print("=== FINAL CLEANED DATASET ===")
print(final_df)

# Save to CSV
output_file = 'cleaned_customer_data.csv'
final_df.to_csv(output_file, index=False)
print(f"\n✅ Clean data saved to: {output_file}")
```

## Step 10: Reflection and Next Steps

### 🎯 Learning Check
1. **Extract**: Where did our data come from?
2. **Transform**: What cleaning steps did we perform?
3. **Load**: Where did we save our clean data?

### 💭 Discussion Questions
1. **Business Impact**: How might invalid email addresses affect a marketing campaign?
2. **Decision Making**: Should we keep customers with invalid phone numbers? Why?
3. **Scalability**: What if we had 1 million customer records instead of 7?
4. **Automation**: How could we make this process run automatically each night?

### 🚀 Extension Challenges
**Ready for more?** Try these advanced challenges:

1. **Add order data integration** - Combine with transaction history
2. **Create customer segments** - Group customers by activity level
3. **Build in VS Code** - Convert this notebook to a proper Python script
4. **Add error handling** - What happens if the input file is corrupted?
5. **Create automated tests** - How would you verify your cleaning worked correctly?

### 📝 Real-World Applications
This type of data cleaning is essential in:
- CRM system migrations
- Marketing campaign preparation
- Data warehouse loading
- Regulatory compliance reporting
- Customer analytics projects
