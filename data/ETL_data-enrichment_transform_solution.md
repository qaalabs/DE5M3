# Customer Data ETL Challenge - SOLUTION

This notebook contains suggested solutions to the ETL lab. Remember: in real ETL work, there are often multiple valid approaches. The key is understanding **why** you make each decision.

**Note for instructors**: Use this to guide discussions, not as the "only correct answer".

## Setup and Data Loading (Same as original)


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

df = pd.DataFrame(crm_data)
print("Raw customer data from CRM system:")
print(df)
```

## Step 4 Solution: Clean Names

**Business Decision**: We'll use 'Unknown' for missing names rather than removing records, as customers might still be valuable even without complete name data.


```python
# First, handle customer IDs (from guided example)
df_clean = df[df['customer_id'] != ''].copy()
df_clean['customer_id'] = df_clean['customer_id'].astype(int)

print("Before cleaning - Names:")
print("First names:", df_clean['first_name'].tolist())
print("Last names:", df_clean['last_name'].tolist())

# SOLUTION: Clean first names
df_clean['first_name'] = df_clean['first_name'].replace('', 'Unknown')
df_clean['first_name'] = df_clean['first_name'].str.title()

# SOLUTION: Clean last names
df_clean['last_name'] = df_clean['last_name'].replace('', 'Unknown')
df_clean['last_name'] = df_clean['last_name'].str.title()

print("\nAfter cleaning - Names:")
print("First names:", df_clean['first_name'].tolist())
print("Last names:", df_clean['last_name'].tolist())

print("\n💡 TEACHING POINT:")
print("- .str.title() converts 'jane' to 'Jane' and 'MIKE' to 'Mike'")
print("- We chose 'Unknown' over removing records - business decision!")
print("- Alternative approaches: use 'N/A', 'Not Provided', or remove entirely")
```

## Step 5 Solution: Email Validation and Standardisation

**Business Decision**: We'll flag invalid emails but keep the records, as customers might update their email later.


```python
print("Current email addresses:")
print(df_clean['email'].tolist())

# Simple email validation function
def is_valid_email(email):
    if email == '':
        return False
    return '@' in email and '.' in email

# Apply validation
df_clean['email_valid'] = df_clean['email'].apply(is_valid_email)

# SOLUTION: Standardise email format (lowercase)
# Only convert non-empty emails to lowercase
df_clean['email'] = df_clean['email'].str.lower()

print("\nEmail validation results:")
print(df_clean[['email', 'email_valid']])

# Show invalid emails for review
invalid_emails = df_clean[~df_clean['email_valid']]
print("\nInvalid email records for manual review:")
print(invalid_emails[['customer_id', 'first_name', 'last_name', 'email']])

print("\n💡 TEACHING POINTS:")
print("- Simple validation: checks for @ and . (not perfect but practical)")
print("- .str.lower() standardises case: 'JANE@EMAIL.COM' → 'jane@email.com'")
print("- We flag invalid emails rather than removing records")
print("- Production systems might use regex for more sophisticated validation")
```

## Step 6 Solution: Status Standardisation

**Business Decision**: Default status will be 'unknown' rather than assuming 'active'.


```python
print("Current status values:")
print(df_clean['status'].tolist())
print("\nUnique status values:")
print(df_clean['status'].unique())

# SOLUTION: Standardise status values
# Step 1: Convert to lowercase for consistency
df_clean['status'] = df_clean['status'].str.lower()

# Step 2: Handle empty strings
df_clean['status'] = df_clean['status'].replace('', 'unknown')

# Optional: Validate against allowed values
allowed_statuses = ['active', 'inactive', 'suspended', 'unknown']
invalid_status = ~df_clean['status'].isin(allowed_statuses)

if invalid_status.any():
    print(f"Warning: Found {invalid_status.sum()} records with unexpected status values")
    print(df_clean[invalid_status]['status'].unique())

print("\nAfter standardisation:")
print("Status values:", df_clean['status'].tolist())
print("Unique status values:", df_clean['status'].unique())

# Business intelligence: Status distribution
print("\nStatus distribution:")
status_counts = df_clean['status'].value_counts()
for status, count in status_counts.items():
    percentage = (count / len(df_clean)) * 100
    print(f"- {status.title()}: {count} ({percentage:.1f}%)")

print("\n💡 TEACHING POINTS:")
print("- .str.lower() handles 'ACTIVE', 'Active', 'active' consistently")
print("- We validate against business rules (allowed status values)")
print("- Status distribution gives business insights")
print("- Consider: should we default to 'active' or 'unknown'? Business decision!")
```

## Step 7 Solution: Phone Number Validation

**Business Decision**: UK phone number format validation - this would vary by country/business requirements.


```python
print("Current phone numbers:")
print(df_clean['phone'].tolist())

# SOLUTION: UK phone number validation function
def is_valid_uk_phone(phone):
    """
    Validate UK phone numbers.
    Simple rule: 11 digits starting with 0
    """
    if phone == '':
        return False
    
    # Check if it's exactly 11 digits and starts with 0
    if len(phone) == 11 and phone.startswith('0') and phone.isdigit():
        return True
    
    return False

# Apply validation
df_clean['phone_valid'] = df_clean['phone'].apply(is_valid_uk_phone)

print("\nPhone validation results:")
validation_results = df_clean[['customer_id', 'phone', 'phone_valid']].copy()
print(validation_results)

# Show invalid phones for manual review
invalid_phones = df_clean[~df_clean['phone_valid'] & (df_clean['phone'] != '')]
if not invalid_phones.empty:
    print("\nInvalid phone numbers for manual review:")
    print(invalid_phones[['customer_id', 'first_name', 'last_name', 'phone']])

# Summary statistics
total_phones = len(df_clean)
valid_phones = df_clean['phone_valid'].sum()
empty_phones = (df_clean['phone'] == '').sum()
invalid_phones = total_phones - valid_phones - empty_phones

print("\nPhone number summary:")
print(f"- Valid: {valid_phones}/{total_phones} ({valid_phones/total_phones:.1%})")
print(f"- Empty: {empty_phones}/{total_phones} ({empty_phones/total_phones:.1%})")
print(f"- Invalid: {invalid_phones}/{total_phones} ({invalid_phones/total_phones:.1%})")

print("\n💡 TEACHING POINTS:")
print("- .isdigit() checks if string contains only numbers")
print("- .startswith('0') checks UK format")
print("- len(phone) == 11 ensures correct length")
print("- Real systems might handle international formats, extensions, etc.")
print("- Business decision: keep invalid phones or require correction?")
```

## Enhanced Data Quality Report

This is what you'd present to stakeholders - clear, actionable insights.


```python
print("=== COMPREHENSIVE DATA QUALITY REPORT ===")
print(f"Report Date: {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M')}")
print(f"Source: CRM System Export")
print("=" * 50)

print("\n📊 RECORD SUMMARY:")
print(f"- Original records: {len(df)}")
print(f"- Processed records: {len(df_clean)}")
print(f"- Records removed: {len(df) - len(df_clean)} (missing customer ID)")

print("\n🔍 FIELD QUALITY ANALYSIS:")

# Customer ID quality
print("\nCustomer IDs:")
print(f"  ✅ Valid: {len(df_clean)}/{len(df)} ({len(df_clean)/len(df):.1%})")
print(f"  ❌ Missing: {len(df) - len(df_clean)} records removed")

# Name quality
unknown_first = (df_clean['first_name'] == 'Unknown').sum()
unknown_last = (df_clean['last_name'] == 'Unknown').sum()
print("\nNames:")
print(f"  ✅ Complete first names: {len(df_clean) - unknown_first}/{len(df_clean)} ({(len(df_clean) - unknown_first)/len(df_clean):.1%})")
print(f"  ✅ Complete last names: {len(df_clean) - unknown_last}/{len(df_clean)} ({(len(df_clean) - unknown_last)/len(df_clean):.1%})")
print(f"  ⚠️  Unknown first names: {unknown_first}")
print(f"  ⚠️  Unknown last names: {unknown_last}")

# Email quality
valid_emails = df_clean['email_valid'].sum()
print("\nEmail Addresses:")
print(f"  ✅ Valid format: {valid_emails}/{len(df_clean)} ({valid_emails/len(df_clean):.1%})")
print(f"  ❌ Invalid/missing: {len(df_clean) - valid_emails}")

# Phone quality
valid_phones = df_clean['phone_valid'].sum()
empty_phones = (df_clean['phone'] == '').sum()
print("\nPhone Numbers:")
print(f"  ✅ Valid UK format: {valid_phones}/{len(df_clean)} ({valid_phones/len(df_clean):.1%})")
print(f"  ⚠️  Empty: {empty_phones}")
print(f"  ❌ Invalid format: {len(df_clean) - valid_phones - empty_phones}")

# Status distribution
print("\nCustomer Status Distribution:")
for status, count in df_clean['status'].value_counts().items():
    percentage = count / len(df_clean) * 100
    print(f"  📈 {status.title()}: {count} ({percentage:.1f}%)")

print("\n🎯 BUSINESS IMPACT:")
marketing_ready = df_clean['email_valid'].sum()
sms_ready = df_clean['phone_valid'].sum()
active_customers = (df_clean['status'] == 'active').sum()

print(f"- Customers ready for email campaigns: {marketing_ready} ({marketing_ready/len(df_clean):.1%})")
print(f"- Customers ready for SMS campaigns: {sms_ready} ({sms_ready/len(df_clean):.1%})")
print(f"- Active customers: {active_customers} ({active_customers/len(df_clean):.1%})")

print("\n📋 RECOMMENDATIONS:")
if (len(df) - len(df_clean)) > 0:
    print("- 🔧 Fix missing customer ID process in source system")
if valid_emails < len(df_clean) * 0.8:
    print("- 📧 Email collection process needs improvement")
if valid_phones < len(df_clean) * 0.8:
    print("- 📱 Phone number validation needed at data entry")
if unknown_first > 0 or unknown_last > 0:
    print("- 👤 Name fields should be mandatory in source system")

print("\n💡 TEACHING MOMENT:")
print("This report format is what data engineers provide to stakeholders.")
print("Notice: percentages, business impact, actionable recommendations!")
```

## Alternative Solutions and Discussion Points

**Important**: Show learners that ETL decisions aren't always black and white!


```python
print("=== ALTERNATIVE APPROACHES FOR DISCUSSION ===")

print("\n1. HANDLING MISSING NAMES:")
print("   Option A: Use 'Unknown' (our choice)")
print("   Option B: Use first name from email (e.g., 'john@email.com' → 'John')")
print("   Option C: Remove records entirely")
print("   💭 Which is best? Depends on business needs!")

# Demonstrate Option B
def extract_name_from_email(email):
    if '@' in email:
        return email.split('@')[0].title()
    return 'Unknown'

# Show what this would look like
demo_df = df_clean.copy()
mask = demo_df['first_name'] == 'Unknown'
demo_df.loc[mask, 'first_name'] = demo_df.loc[mask, 'email'].apply(extract_name_from_email)

print("\n   Example of Option B (extract from email):")
print(demo_df[['first_name', 'email']].head())

print("\n2. EMAIL VALIDATION LEVELS:")
print("   Level 1: Check for @ and . (our choice - simple)")
print("   Level 2: Regex pattern matching")
print("   Level 3: DNS/MX record checking")
print("   Level 4: Send verification email")

print("\n3. PHONE NUMBER APPROACHES:")
print("   Option A: Country-specific validation (our choice)")
print("   Option B: International format handling")
print("   Option C: Store as entered, flag for review")

print("\n4. DATA QUALITY THRESHOLDS:")
print("   Question: At what point is data quality too poor to use?")
print(f"   Our dataset: {valid_emails/len(df_clean):.1%} valid emails")
print(f"   Business decision: Is this acceptable for marketing?")

print("\n💡 KEY LEARNING:")
print("ETL isn't just technical - it requires business understanding!")
print("Always document your decisions and reasoning.")
```

## Final Clean Dataset with Metadata

Production ETL processes should include metadata about the cleaning performed.


```python
# Create final dataset with metadata
final_df = df_clean[['customer_id', 'first_name', 'last_name', 'email', 'phone', 'status', 
                     'email_valid', 'phone_valid']].copy()

# Add processing metadata
final_df['processed_date'] = pd.Timestamp.now().strftime('%Y-%m-%d')
final_df['data_quality_score'] = (
    (final_df['first_name'] != 'Unknown').astype(int) +
    (final_df['last_name'] != 'Unknown').astype(int) +
    final_df['email_valid'].astype(int) +
    final_df['phone_valid'].astype(int)
) / 4 * 100  # Score out of 100

print("=== FINAL CLEANED DATASET WITH METADATA ===")
print(final_df)

print("\nData Quality Score Distribution:")
print(final_df['data_quality_score'].describe())

# Save with timestamp
timestamp = pd.Timestamp.now().strftime('%Y%m%d_%H%M%S')
output_file = f'cleaned_customer_data_{timestamp}.csv'
final_df.to_csv(output_file, index=False)

print(f"\n✅ Clean data saved to: {output_file}")

# Create summary file for business users
summary_file = f'data_quality_summary_{timestamp}.txt'
with open(summary_file, 'w') as f:
    f.write(f"Customer Data Cleaning Summary\n")
    f.write(f"Processed: {pd.Timestamp.now()}\n")
    f.write(f"Records processed: {len(final_df)}\n")
    f.write(f"Average quality score: {final_df['data_quality_score'].mean():.1f}%\n")
    f.write(f"Valid emails: {final_df['email_valid'].sum()}/{len(final_df)}\n")
    f.write(f"Valid phones: {final_df['phone_valid'].sum()}/{len(final_df)}\n")

print(f"📊 Business summary saved to: {summary_file}")

print("\n🎓 CONGRATULATIONS!")
print("You've completed a realistic ETL process including:")
print("✅ Data extraction and inspection")
print("✅ Data transformation and cleaning")
print("✅ Data validation and quality scoring")
print("✅ Data loading with metadata")
print("✅ Business reporting and documentation")
print("\nThese are the core skills of a data engineer!")
```
