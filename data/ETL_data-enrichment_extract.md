# Customer Data Enrichment - The Extract Component

**Scenario**: This morning you cleaned customer data (Transform). Now we'll enhance it with external data sources (Extract) before loading it to our database (Load).

**Business Need**: Your customer support team needs enriched customer profiles including:
- Validated postcodes with area information
- Company data for business customers  
- Risk scoring based on location

**Learning Objectives**:
- Extract data from multiple APIs
- Combine internal and external data sources
- Handle API failures gracefully
- Prepare data for database loading

## Step 1: Load Your Cleaned Customer Data

Start with the customer data you cleaned this morning.


```python
import pandas as pd
import requests
import time
import json
from datetime import datetime
import numpy as np

# Load the cleaned customer data from this morning
# (In real scenario, this would come from your morning output)
customers_clean = {
    'customer_id': [1001, 1002, 1003, 1004, 1005, 1006],
    'first_name': ['John', 'Jane', 'Mike', 'Sarah', 'Bob', 'Alice'],
    'last_name': ['Smith', 'Doe', 'Johnson', 'Wilson', 'Brown', 'Cooper'],
    'email': ['john@email.com', 'jane@email.com', 'mike@techcorp.com', 
              'sarah@retailplus.com', 'bob@email.com', 'alice@freelance.com'],
    'phone': ['01234567890', '01987654321', '01555123456', 
              '01777888999', '01111222333', '01444555666'],
    'postcode': ['SW1A 1AA', 'M1 1AA', 'B1 1AA', 'LS1 1AA', 'NE1 1AA', 'CF10 1AA'],
    'company': ['', '', 'TechCorp Ltd', 'Retail Plus', '', 'Freelance Design'],
    'status': ['active', 'active', 'active', 'suspended', 'active', 'active']
}

df_customers = pd.DataFrame(customers_clean)
print("=== CLEANED CUSTOMER DATA ===")
print(df_customers)
print(f"\nTotal customers to enrich: {len(df_customers)}")
```

## Step 2: Postcode Enrichment - Geographic Data

Use the UK Postcodes API to get detailed location information for risk assessment and regional analysis.


```python
def enrich_postcode(postcode):
    """
    Extract geographic data from UK Postcodes API
    Returns: dict with area information or None if failed
    """
    try:
        # Clean postcode for API (remove spaces)
        clean_postcode = postcode.replace(' ', '')
        
        # Call the free UK Postcodes API
        url = f"https://api.postcodes.io/postcodes/{clean_postcode}"
        response = requests.get(url, timeout=5)
        
        if response.status_code == 200:
            data = response.json()
            result = data['result']
            
            return {
                'region': result.get('region', 'Unknown'),
                'country': result.get('country', 'Unknown'),
                'district': result.get('admin_district', 'Unknown'),
                'longitude': result.get('longitude', 0),
                'latitude': result.get('latitude', 0)
            }
        else:
            print(f"⚠️  Postcode API failed for {postcode}: {response.status_code}")
            return None
            
    except requests.exceptions.Timeout:
        print(f"⚠️  Timeout for postcode {postcode}")
        return None
    except Exception as e:
        print(f"⚠️  Error processing {postcode}: {str(e)}")
        return None

# Test the function with one postcode
test_result = enrich_postcode('SW1A 1AA')
print("=== POSTCODE API TEST ===")
print(f"Test result: {test_result}")
```

### Apply Postcode Enrichment to All Customers

Now let's extract geographic data for all customers. Notice how we handle API failures gracefully.


```python
# Initialize new columns for geographic data
df_customers['region'] = 'Unknown'
df_customers['country'] = 'Unknown' 
df_customers['district'] = 'Unknown'
df_customers['longitude'] = 0.0
df_customers['latitude'] = 0.0
df_customers['geo_enriched'] = False

print("=== ENRICHING POSTCODES ===")
successful_enrichments = 0

for index, row in df_customers.iterrows():
    postcode = row['postcode']
    print(f"Processing {postcode}...")
    
    # Extract geographic data
    geo_data = enrich_postcode(postcode)
    
    if geo_data:
        # Update the dataframe with extracted data
        df_customers.at[index, 'region'] = geo_data['region']
        df_customers.at[index, 'country'] = geo_data['country']
        df_customers.at[index, 'district'] = geo_data['district']
        df_customers.at[index, 'longitude'] = geo_data['longitude']
        df_customers.at[index, 'latitude'] = geo_data['latitude']
        df_customers.at[index, 'geo_enriched'] = True
        successful_enrichments += 1
        print(f"  ✅ Enriched: {geo_data['region']}, {geo_data['district']}")
    else:
        print(f"  ❌ Failed to enrich {postcode}")
    
    # Be nice to the API - small delay between requests
    time.sleep(0.5)

print(f"\n=== ENRICHMENT SUMMARY ===")
print(f"Successfully enriched: {successful_enrichments}/{len(df_customers)} postcodes")
print(f"Success rate: {successful_enrichments/len(df_customers):.1%}")
```

## Step 3: Company Data Enrichment

For business customers, let's enrich with company information. In a real scenario, you might use Companies House API or similar.


```python
def enrich_company_data(company_name, email_domain):
    """
    Simulate company data enrichment
    In reality, you'd call Companies House API, Clearbit, or similar
    """
    # Simulate company database lookup
    company_db = {
        'techcorp.com': {
            'company_size': 'Medium (50-250 employees)',
            'industry': 'Technology',
            'risk_score': 'Low',
            'annual_revenue': '£2M-£10M'
        },
        'retailplus.com': {
            'company_size': 'Large (250+ employees)', 
            'industry': 'Retail',
            'risk_score': 'Medium',
            'annual_revenue': '£10M+'
        },
        'freelance.com': {
            'company_size': 'Micro (1-10 employees)',
            'industry': 'Creative Services', 
            'risk_score': 'Medium',
            'annual_revenue': '£0-£100K'
        }
    }
    
    # Extract domain from email
    if '@' in email_domain:
        domain = email_domain.split('@')[1]
    else:
        domain = email_domain
    
    # Look up company data
    if domain in company_db:
        return company_db[domain]
    else:
        # Default for unknown companies
        return {
            'company_size': 'Unknown',
            'industry': 'Unknown',
            'risk_score': 'Unknown', 
            'annual_revenue': 'Unknown'
        }

# Add company enrichment columns
df_customers['company_size'] = 'Individual'
df_customers['industry'] = 'Personal'
df_customers['risk_score'] = 'Low'
df_customers['annual_revenue'] = 'N/A'
df_customers['is_business'] = False

print("=== ENRICHING COMPANY DATA ===")

for index, row in df_customers.iterrows():
    # Check if customer has company information
    if row['company'] and row['company'] != '':
        print(f"Processing business customer: {row['company']}")
        
        # Extract company data
        company_data = enrich_company_data(row['company'], row['email'])
        
        # Update dataframe
        df_customers.at[index, 'company_size'] = company_data['company_size']
        df_customers.at[index, 'industry'] = company_data['industry']
        df_customers.at[index, 'risk_score'] = company_data['risk_score']
        df_customers.at[index, 'annual_revenue'] = company_data['annual_revenue']
        df_customers.at[index, 'is_business'] = True
        
        print(f"  ✅ Industry: {company_data['industry']}, Size: {company_data['company_size']}")
    else:
        print(f"Individual customer: {row['first_name']} {row['last_name']}")

business_customers = df_customers['is_business'].sum()
print(f"\n=== COMPANY ENRICHMENT SUMMARY ===")
print(f"Business customers identified: {business_customers}")
print(f"Individual customers: {len(df_customers) - business_customers}")
```

## Step 4: Calculate Risk Scores

Combine geographic and company data to create comprehensive customer risk profiles.


```python
def calculate_customer_risk(row):
    """
    Business logic: Calculate customer risk based on multiple factors
    This is the Transform logic that combines extracted data
    """
    risk_factors = []
    risk_score = 0
    
    # Geographic risk (example business rules)
    high_risk_regions = ['London', 'West Midlands']
    if row['region'] in high_risk_regions:
        risk_score += 2
        risk_factors.append('High-risk region')
    
    # Company risk
    if row['is_business']:
        if row['company_size'] == 'Micro (1-10 employees)':
            risk_score += 1
            risk_factors.append('Small business')
        elif row['annual_revenue'] == '£10M+':
            risk_score -= 1  # Large companies are lower risk
            risk_factors.append('Large company (low risk)')
    
    # Account status risk
    if row['status'] == 'suspended':
        risk_score += 3
        risk_factors.append('Account suspended')
    
    # Data quality risk
    if not row['geo_enriched']:
        risk_score += 1
        risk_factors.append('Incomplete geographic data')
    
    # Convert score to category
    if risk_score <= 0:
        risk_category = 'Low'
    elif risk_score <= 2:
        risk_category = 'Medium'
    else:
        risk_category = 'High'
    
    return risk_category, risk_score, '; '.join(risk_factors) if risk_factors else 'Standard profile'

# Apply risk calculation
print("=== CALCULATING CUSTOMER RISK SCORES ===")

risk_data = df_customers.apply(calculate_customer_risk, axis=1, result_type='expand')
df_customers['calculated_risk'] = risk_data[0]
df_customers['risk_score_numeric'] = risk_data[1] 
df_customers['risk_factors'] = risk_data[2]

# Risk distribution analysis
print("\n=== RISK ANALYSIS SUMMARY ===")
risk_distribution = df_customers['calculated_risk'].value_counts()
for risk_level, count in risk_distribution.items():
    percentage = (count / len(df_customers)) * 100
    print(f"{risk_level} Risk: {count} customers ({percentage:.1f}%)")

print("\n=== HIGH RISK CUSTOMERS ===")
high_risk = df_customers[df_customers['calculated_risk'] == 'High']
if not high_risk.empty:
    for _, customer in high_risk.iterrows():
        print(f"⚠️  {customer['first_name']} {customer['last_name']}: {customer['risk_factors']}")
else:
    print("No high-risk customers identified")
```

## Step 5: Prepare for Database Loading

Clean and structure the enriched data for loading into SQL Server.


```python
# Create final dataset for database loading
df_final = df_customers.copy()

# Add processing metadata
df_final['processed_date'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
df_final['data_source'] = 'ETL_Pipeline_v1'
df_final['enrichment_status'] = df_final.apply(
    lambda row: 'Fully Enriched' if row['geo_enriched'] and row['is_business'] 
    else 'Partially Enriched' if row['geo_enriched'] or row['is_business']
    else 'Basic Profile', axis=1
)

# Data validation before loading
print("=== DATA VALIDATION FOR DATABASE LOADING ===")

# Check for required fields
required_fields = ['customer_id', 'first_name', 'last_name', 'email']
missing_data = df_final[required_fields].isnull().sum()
print("Missing required data:")
for field, count in missing_data.items():
    print(f"  {field}: {count} missing values")

# Data quality metrics
print("\nData quality metrics:")
print(f"  Total records: {len(df_final)}")
print(f"  Geo-enriched: {df_final['geo_enriched'].sum()} ({df_final['geo_enriched'].mean():.1%})")
print(f"  Business customers: {df_final['is_business'].sum()}")
print(f"  High-risk customers: {(df_final['calculated_risk'] == 'High').sum()}")

# Show final enriched dataset
print("\n=== FINAL ENRICHED CUSTOMER DATA ===")
# Display key columns only for readability
display_columns = ['customer_id', 'first_name', 'last_name', 'region', 'industry', 
                  'calculated_risk', 'enrichment_status']
print(df_final[display_columns])

print(f"\n✅ Ready for database loading: {len(df_final)} enriched customer records")
```

## Step 6: Save Enriched Data

Export the enriched dataset for the Load phase.


```python
# Save enriched data for database loading
timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
output_file = f'enriched_customers_{timestamp}.csv'

df_final.to_csv(output_file, index=False)
print(f"💾 Enriched data saved to: {output_file}")

# Create summary report for stakeholders
summary_report = f"""
CUSTOMER DATA ENRICHMENT REPORT
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
================================

INPUT DATA:
- Source records: {len(df_customers)}
- Clean customer data from morning transformation

ENRICHMENT SOURCES:
- UK Postcodes API (geographic data)
- Company database (business information)
- Risk calculation engine (custom business logic)

OUTPUT DATA:
- Total enriched records: {len(df_final)}
- Geographic enrichment: {df_final['geo_enriched'].sum()}/{len(df_final)} ({df_final['geo_enriched'].mean():.1%})
- Business customers identified: {df_final['is_business'].sum()}
- High-risk customers: {(df_final['calculated_risk'] == 'High').sum()}

BUSINESS VALUE:
- Customer support agents now have geographic context
- Business customers identified for B2B processes  
- Risk scores enable proactive account management
- Complete customer 360-degree view ready for CRM

NEXT STEPS:
- Load enriched data to customer database
- Update CRM system with risk scores
- Configure alerts for high-risk customers
"""

summary_file = f'enrichment_summary_{timestamp}.txt'
with open(summary_file, 'w') as f:
    f.write(summary_report)

print(f"📊 Summary report saved to: {summary_file}")
print("\n" + "="*50)
print("🎉 EXTRACT PHASE COMPLETE!")
print("="*50)
print("You've successfully:")
print("✅ Extracted data from multiple APIs")
print("✅ Combined internal and external data sources")
print("✅ Applied business logic and risk assessment")
print("✅ Prepared data for database loading")
print("\nNext: Load this enriched data into SQL Server (Load phase)")
```

## Reflection Questions

**Technical Learning:**
1. How did you handle API failures? What other strategies could you use?
2. What challenges did you face combining data from different sources?
3. How would you modify this pipeline for 100,000 customers?

**Business Application:**
4. What external data sources would benefit your organisation?
5. How would you explain the value of data enrichment to your manager?
6. What data quality issues might arise in production?

**ETL Concepts:**
7. How does this Extract phase connect to this morning's Transform work?
8. What preparation is needed for the Load phase?
9. How would you monitor this enrichment process in production?

## Next Steps

**Immediate:** Load your enriched data into SQL Server
**Tomorrow:** Rebuild this pipeline using Azure Data Factory
**This Week:** Add error handling, monitoring, and production patterns
**Back at Work:** Identify enrichment opportunities for your organisation's data
