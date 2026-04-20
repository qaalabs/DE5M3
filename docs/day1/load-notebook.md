# Database Loading - The Load Component

### Scenario
You've Extracted data from APIs and Transformed it with business logic. Now it's time to Load it into your data warehouse.

### Business Context
Your customer service team needs this enriched data in their CRM system for better customer support.

---

## Step 0: Import Python packages


```python
import pyodbc
import pandas as pd
from datetime import datetime
import logging
from sqlalchemy import create_engine
import urllib
```

## Step 1: Database Setup and Connection

Connect to SQL Server and create the customer data warehouse database.


```python
# Database connection configuration
SERVER = 'localhost'  # Your SQL Server instance
DATABASE = 'customer_warehouse'  # We'll create this database

# Connection string for initial setup (master database)
master_connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE=master;Trusted_Connection=yes;'

print("=== DATABASE SETUP ===")
try:
    # Connect to master database to create our warehouse (with autocommit for CREATE DATABASE)
    master_conn = pyodbc.connect(master_connection_string, autocommit=True)
    master_cursor = master_conn.cursor()
    
    # Create database if it doesn't exist
    try:
        master_cursor.execute(f"CREATE DATABASE {DATABASE}")
        print(f"✅ Created database: {DATABASE}")
    except pyodbc.Error as e:
        if "already exists" in str(e):
            print(f"ℹ️  Database {DATABASE} already exists")
        else:
            print(f"⚠️  Database creation issue: {e}")
    
    master_conn.close()
    print("Database setup complete")
    
except Exception as e:
    print(f"❌ Database setup failed: {e}")
    print("Please check your SQL Server connection")
```

## Step 2: Create Data Warehouse Tables

Create tables optimized for analytical queries and reporting.


```python
# Connect to our customer warehouse database
warehouse_connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes;'

def create_warehouse_tables():
    """Create optimized data warehouse tables"""
    
    # Table creation scripts
    create_tables_sql = """
    -- Drop existing tables if they exist
    IF OBJECT_ID('dbo.customer_enriched', 'U') IS NOT NULL DROP TABLE dbo.customer_enriched;
    IF OBJECT_ID('dbo.enrichment_audit', 'U') IS NOT NULL DROP TABLE dbo.enrichment_audit;
    
    -- Main customer data table
    CREATE TABLE customer_enriched (
        customer_id INT PRIMARY KEY,
        first_name NVARCHAR(50) NOT NULL,
        last_name NVARCHAR(50) NOT NULL,
        email NVARCHAR(100) NOT NULL,
        phone NVARCHAR(20),
        postcode NVARCHAR(10),
        
        -- Geographic enrichment
        region NVARCHAR(50),
        country NVARCHAR(50),
        district NVARCHAR(50),
        longitude DECIMAL(10,7),
        latitude DECIMAL(10,7),
        geo_enriched BIT DEFAULT 0,
        
        -- Business enrichment
        company NVARCHAR(100),
        company_size NVARCHAR(50),
        industry NVARCHAR(50),
        annual_revenue NVARCHAR(50),
        is_business BIT DEFAULT 0,
        
        -- Risk assessment
        calculated_risk NVARCHAR(20),
        risk_score_numeric INT,
        risk_factors NVARCHAR(500),
        
        -- Account status
        status NVARCHAR(20),
        
        -- ETL metadata
        processed_date DATETIME2 DEFAULT GETDATE(),
        data_source NVARCHAR(50),
        enrichment_status NVARCHAR(50),
        
        -- Audit fields
        created_date DATETIME2 DEFAULT GETDATE(),
        modified_date DATETIME2 DEFAULT GETDATE()
    );
    
    -- Audit table for tracking all loading operations
    CREATE TABLE enrichment_audit (
        audit_id INT IDENTITY(1,1) PRIMARY KEY,
        batch_id UNIQUEIDENTIFIER DEFAULT NEWID(),
        operation_type NVARCHAR(20), -- INSERT, UPDATE, DELETE
        records_processed INT,
        records_successful INT,
        records_failed INT,
        processing_start DATETIME2,
        processing_end DATETIME2,
        duration_seconds AS DATEDIFF(SECOND, processing_start, processing_end),
        error_message NVARCHAR(1000),
        pipeline_version NVARCHAR(20)
    );
    
    -- Create indexes for better query performance
    CREATE INDEX IX_customer_enriched_region ON customer_enriched(region);
    CREATE INDEX IX_customer_enriched_risk ON customer_enriched(calculated_risk);
    CREATE INDEX IX_customer_enriched_business ON customer_enriched(is_business);
    CREATE INDEX IX_customer_enriched_status ON customer_enriched(status);
    """
    
    try:
        conn = pyodbc.connect(warehouse_connection_string)
        cursor = conn.cursor()
        
        # Execute table creation
        cursor.execute(create_tables_sql)
        conn.commit()
        
        print("✅ Data warehouse tables created successfully")
        print("   - customer_enriched (main data table)")
        print("   - enrichment_audit (processing audit trail)")
        print("   - Performance indexes created")
        
        conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Table creation failed: {e}")
        return False

# Create the tables
print("=== CREATING DATA WAREHOUSE TABLES ===")
table_creation_success = create_warehouse_tables()
```

## Step 3: Load Sample Enriched Data

For this proof-ofconcept, create sample enriched data

**#TODO** Extract this data from the API


```python
# Sample enriched customer data (from our API enrichment lab)
enriched_customers = {
    'customer_id': [1001, 1002, 1003, 1004, 1005, 1006],
    'first_name': ['John', 'Jane', 'Mike', 'Sarah', 'Bob', 'Alice'],
    'last_name': ['Smith', 'Doe', 'Johnson', 'Wilson', 'Brown', 'Cooper'],
    'email': ['john@email.com', 'jane@email.com', 'mike@techcorp.com', 
              'sarah@retailplus.com', 'bob@email.com', 'alice@freelance.com'],
    'phone': ['01234567890', '01987654321', '01555123456', 
              '01777888999', '01111222333', '01444555666'],
    'postcode': ['SW1A 1AA', 'M1 1AF', 'B1 1BB', 'LS1 2AJ', 'NE1 3NG', 'CF10 2HH'],
    
    # Geographic enrichment
    'region': ['London', 'North West', 'West Midlands', 'Yorkshire and The Humber', 'North East', 'Wales'],
    'country': ['England', 'England', 'England', 'England', 'England', 'Wales'],
    'district': ['Westminster', 'Manchester', 'Birmingham', 'Leeds', 'Newcastle', 'Cardiff'],
    'longitude': [-0.1419, -2.2426, -1.8904, -1.5491, -1.6131, -3.1791],
    'latitude': [51.5014, 53.4794, 52.4796, 53.7997, 54.9738, 51.4816],
    'geo_enriched': [1, 1, 1, 1, 1, 1],  # Changed from True to 1 for SQL BIT compatibility
    
    # Business enrichment
    'company': ['', '', 'TechCorp Ltd', 'Retail Plus', '', 'Freelance Design'],
    'company_size': ['Individual', 'Individual', 'Medium (50-250 employees)', 'Large (250+ employees)', 'Individual', 'Micro (1-10 employees)'],
    'industry': ['Personal', 'Personal', 'Technology', 'Retail', 'Personal', 'Creative Services'],
    'annual_revenue': ['N/A', 'N/A', '£2M-£10M', '£10M+', 'N/A', '£0-£100K'],
    'is_business': [0, 0, 1, 1, 0, 1],  # Changed from False/True to 0/1 for SQL BIT compatibility
    
    # Risk assessment
    'calculated_risk': ['Low', 'Low', 'Medium', 'High', 'Low', 'Medium'],
    'risk_score_numeric': [0, 0, 2, 5, 0, 1],
    'risk_factors': ['Standard profile', 'Standard profile', 'High-risk region', 
                    'Account suspended; High-risk region', 'Standard profile', 'Small business'],
    
    # Account status
    'status': ['active', 'active', 'active', 'suspended', 'active', 'active'],
    
    # ETL metadata
    'processed_date': [datetime.now().strftime('%Y-%m-%d %H:%M:%S')] * 6,
    'data_source': ['ETL_Pipeline_v1'] * 6,
    'enrichment_status': ['Fully Enriched', 'Fully Enriched', 'Fully Enriched', 
                         'Fully Enriched', 'Fully Enriched', 'Fully Enriched']
}

df_enriched = pd.DataFrame(enriched_customers)

print("=== ENRICHED CUSTOMER DATA TO LOAD ===")
print(f"Records to load: {len(df_enriched)}")
print("\nSample records:")
display_cols = ['customer_id', 'first_name', 'last_name', 'region', 'industry', 'calculated_risk']
print(df_enriched[display_cols])
```

## Step 4: Implement Robust Database Loading

Create a production-ready loading process with error handling, audit logging, and performance metrics.


```python
import uuid
from typing import Tuple, Dict

class DatabaseLoader:
    """Production database loading with comprehensive error handling"""
    
    def __init__(self, connection_string: str):
        self.connection_string = connection_string
        self.batch_id = str(uuid.uuid4())
        
    def load_enriched_customers(self, df_customers: pd.DataFrame) -> Dict:
        """
        Load enriched customer data with comprehensive error handling
        Returns: Loading statistics and results
        """
        start_time = datetime.now()
        results = {
            'batch_id': self.batch_id,
            'total_records': len(df_customers),
            'successful_inserts': 0,
            'successful_updates': 0,
            'failed_records': 0,
            'errors': [],
            'processing_time': 0
        }
        
        try:
            conn = pyodbc.connect(self.connection_string)
            cursor = conn.cursor()
            
            print(f"🔄 Starting batch load: {self.batch_id}")
            print(f"📊 Processing {len(df_customers)} customer records")
            
            # Process each customer with upsert logic
            for index, customer in df_customers.iterrows():
                try:
                    # Check if customer already exists
                    check_sql = "SELECT COUNT(*) FROM customer_enriched WHERE customer_id = ?"
                    cursor.execute(check_sql, customer['customer_id'])
                    exists = cursor.fetchone()[0] > 0
                    
                    if exists:
                        # UPDATE existing record
                        update_sql = """
                        UPDATE customer_enriched SET
                            first_name = ?, last_name = ?, email = ?, phone = ?, postcode = ?,
                            region = ?, country = ?, district = ?, longitude = ?, latitude = ?, geo_enriched = ?,
                            company = ?, company_size = ?, industry = ?, annual_revenue = ?, is_business = ?,
                            calculated_risk = ?, risk_score_numeric = ?, risk_factors = ?,
                            status = ?, processed_date = ?, data_source = ?, enrichment_status = ?,
                            modified_date = GETDATE()
                        WHERE customer_id = ?
                        """
                        
                        cursor.execute(update_sql, (
                            customer['first_name'], customer['last_name'], customer['email'],
                            customer['phone'], customer['postcode'],
                            customer['region'], customer['country'], customer['district'],
                            customer['longitude'], customer['latitude'], customer['geo_enriched'],
                            customer['company'], customer['company_size'], customer['industry'],
                            customer['annual_revenue'], customer['is_business'],
                            customer['calculated_risk'], customer['risk_score_numeric'], customer['risk_factors'],
                            customer['status'], customer['processed_date'], customer['data_source'],
                            customer['enrichment_status'], customer['customer_id']
                        ))
                        
                        results['successful_updates'] += 1
                        print(f"  ✏️  Updated customer {customer['customer_id']}")
                        
                    else:
                        # INSERT new record
                        insert_sql = """
                        INSERT INTO customer_enriched (
                            customer_id, first_name, last_name, email, phone, postcode,
                            region, country, district, longitude, latitude, geo_enriched,
                            company, company_size, industry, annual_revenue, is_business,
                            calculated_risk, risk_score_numeric, risk_factors,
                            status, processed_date, data_source, enrichment_status
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                        """
                        
                        cursor.execute(insert_sql, (
                            customer['customer_id'], customer['first_name'], customer['last_name'],
                            customer['email'], customer['phone'], customer['postcode'],
                            customer['region'], customer['country'], customer['district'],
                            customer['longitude'], customer['latitude'], customer['geo_enriched'],
                            customer['company'], customer['company_size'], customer['industry'],
                            customer['annual_revenue'], customer['is_business'],
                            customer['calculated_risk'], customer['risk_score_numeric'], customer['risk_factors'],
                            customer['status'], customer['processed_date'], customer['data_source'],
                            customer['enrichment_status']
                        ))
                        
                        results['successful_inserts'] += 1
                        print(f"  ➕ Inserted customer {customer['customer_id']}")
                
                except Exception as record_error:
                    error_msg = f"Customer {customer['customer_id']}: {str(record_error)}"
                    results['errors'].append(error_msg)
                    results['failed_records'] += 1
                    print(f"  ❌ Failed: {error_msg}")
                    
            # Commit all changes
            conn.commit()
            
            # Record processing time
            end_time = datetime.now()
            results['processing_time'] = (end_time - start_time).total_seconds()
            
            # Log audit information
            self._log_audit_record(cursor, start_time, end_time, results)
            conn.commit()
            
            conn.close()
            
            print(f"\n✅ Batch load completed successfully")
            
        except Exception as e:
            results['errors'].append(f"Critical loading error: {str(e)}")
            print(f"❌ Critical loading error: {e}")
            
        return results
    
    def _log_audit_record(self, cursor, start_time, end_time, results):
        """Log detailed audit information"""
        audit_sql = """
        INSERT INTO enrichment_audit (
            batch_id, operation_type, records_processed, records_successful, 
            records_failed, processing_start, processing_end, error_message, pipeline_version
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        
        error_summary = '; '.join(results['errors'][:5]) if results['errors'] else None
        successful_records = results['successful_inserts'] + results['successful_updates']
        
        cursor.execute(audit_sql, (
            self.batch_id,
            'UPSERT',
            results['total_records'],
            successful_records,
            results['failed_records'],
            start_time,
            end_time,
            error_summary,
            'ETL_Pipeline_v1.0'
        ))

# Execute the loading process
print("=== LOADING ENRICHED DATA TO DATABASE ===")

if table_creation_success:
    loader = DatabaseLoader(warehouse_connection_string)
    loading_results = loader.load_enriched_customers(df_enriched)
    
    print("\n=== LOADING RESULTS ===")
    print(f"Batch ID: {loading_results['batch_id']}")
    print(f"Total records: {loading_results['total_records']}")
    print(f"Successful inserts: {loading_results['successful_inserts']}")
    print(f"Successful updates: {loading_results['successful_updates']}")
    print(f"Failed records: {loading_results['failed_records']}")
    print(f"Processing time: {loading_results['processing_time']:.2f} seconds")
    
    if loading_results['errors']:
        print("\nErrors encountered:")
        for error in loading_results['errors']:
            print(f"  ⚠️  {error}")
else:
    print("❌ Skipping data loading due to table creation failure")
```

## Step 5: Data Validation and Quality Checks

Verify that the data was loaded correctly and perform quality checks.


```python
def validate_loaded_data():
    """Comprehensive validation of loaded data"""
    
    # Set up SQLAlchemy engine for pandas compatibility
    params = urllib.parse.quote_plus(warehouse_connection_string)
    engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
    
    try:
        print("=== DATA VALIDATION CHECKS ===")
        
        # 1. Record count validation
        count_query = "SELECT COUNT(*) FROM customer_enriched"
        total_records = pd.read_sql(count_query, engine).iloc[0, 0]
        print(f"✅ Total records in database: {total_records}")
        
        # 2. Data completeness checks
        completeness_query = """
        SELECT 
            COUNT(*) as total_records,
            SUM(CASE WHEN first_name IS NOT NULL AND first_name != '' THEN 1 ELSE 0 END) as complete_names,
            SUM(CASE WHEN email IS NOT NULL AND email != '' THEN 1 ELSE 0 END) as complete_emails,
            SUM(CASE WHEN geo_enriched = 1 THEN 1 ELSE 0 END) as geo_enriched_count,
            SUM(CASE WHEN is_business = 1 THEN 1 ELSE 0 END) as business_customers
        FROM customer_enriched
        """
        
        completeness_df = pd.read_sql(completeness_query, engine)
        comp = completeness_df.iloc[0]
        
        print(f"✅ Name completeness: {comp['complete_names']}/{comp['total_records']} ({comp['complete_names']/comp['total_records']:.1%})")
        print(f"✅ Email completeness: {comp['complete_emails']}/{comp['total_records']} ({comp['complete_emails']/comp['total_records']:.1%})")
        print(f"✅ Geographic enrichment: {comp['geo_enriched_count']}/{comp['total_records']} ({comp['geo_enriched_count']/comp['total_records']:.1%})")
        print(f"✅ Business customers: {comp['business_customers']}/{comp['total_records']} ({comp['business_customers']/comp['total_records']:.1%})")
        
        # 3. Risk distribution analysis
        risk_query = """
        SELECT 
            calculated_risk,
            COUNT(*) as customer_count,
            CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,1)) as percentage
        FROM customer_enriched 
        GROUP BY calculated_risk
        ORDER BY customer_count DESC
        """
        
        risk_df = pd.read_sql(risk_query, engine)
        print(f"\n✅ Risk Distribution:")
        for _, row in risk_df.iterrows():
            print(f"   {row['calculated_risk']} Risk: {row['customer_count']} customers ({row['percentage']}%)")
        
        # 4. Geographic distribution
        geo_query = """
        SELECT TOP 5
            region,
            COUNT(*) as customer_count
        FROM customer_enriched 
        WHERE region IS NOT NULL AND region != 'Unknown'
        GROUP BY region
        ORDER BY customer_count DESC
        """
        
        geo_df = pd.read_sql(geo_query, engine)
        print(f"\n✅ Top Regions by Customer Count:")
        for _, row in geo_df.iterrows():
            print(f"   {row['region']}: {row['customer_count']} customers")
        
        # 5. Audit trail verification
        audit_query = """
        SELECT 
            batch_id,
            operation_type,
            records_processed,
            records_successful,
            records_failed,
            duration_seconds,
            processing_start
        FROM enrichment_audit 
        ORDER BY processing_start DESC
        """
        
        audit_df = pd.read_sql(audit_query, engine)
        print(f"\n✅ Recent Processing Batches:")
        for _, row in audit_df.iterrows():
            success_rate = (row['records_successful'] / row['records_processed'] * 100) if row['records_processed'] > 0 else 0
            print(f"   Batch: {str(row['batch_id'])[:8]}... | {row['records_processed']} records | {success_rate:.1f}% success | {row['duration_seconds']}s")
        
        return True
        
    except Exception as e:
        print(f"❌ Validation failed: {e}")
        return False

# Run validation
validation_success = validate_loaded_data()
```

## Step 6: Business Intelligence Queries

Demonstrate the value of enriched data with business-relevant queries.


```python
def generate_business_insights():
    """Generate business insights from enriched customer data"""
    
    # Set up SQLAlchemy engine for pandas compatibility
    params = urllib.parse.quote_plus(warehouse_connection_string)
    engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
    
    try:
        print("=== BUSINESS INSIGHTS FROM ENRICHED DATA ===")
        
        # 1. High-value business customers by region
        high_value_query = """
        SELECT 
            region,
            COUNT(*) as business_customers,
            SUM(CASE WHEN calculated_risk = 'Low' THEN 1 ELSE 0 END) as low_risk_businesses
        FROM customer_enriched 
        WHERE is_business = 1
        GROUP BY region
        ORDER BY business_customers DESC
        """
        
        high_value_df = pd.read_sql(high_value_query, engine)
        print("\n📊 Business Customers by Region:")
        for _, row in high_value_df.iterrows():
            low_risk_pct = (row['low_risk_businesses'] / row['business_customers'] * 100) if row['business_customers'] > 0 else 0
            print(f"   {row['region']}: {row['business_customers']} businesses ({row['low_risk_businesses']} low-risk, {low_risk_pct:.0f}%)")
        
        # 2. Risk assessment for customer support prioritization
        support_priority_query = """
        SELECT 
            customer_id,
            first_name + ' ' + last_name as customer_name,
            company,
            region,
            calculated_risk,
            risk_factors,
            status
        FROM customer_enriched 
        WHERE calculated_risk IN ('High', 'Medium')
        ORDER BY 
            CASE calculated_risk WHEN 'High' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END,
            customer_name
        """
        
        priority_df = pd.read_sql(support_priority_query, engine)
        print(f"\n🚨 Customer Support Priority List ({len(priority_df)} customers):")
        for _, row in priority_df.iterrows():
            risk_icon = "🔴" if row['calculated_risk'] == 'High' else "🟡"
            company_info = f" ({row['company']})" if row['company'] else ""
            print(f"   {risk_icon} {row['customer_name']}{company_info} - {row['region']} - {row['risk_factors']}")
        
        # 3. Geographic expansion opportunities
        expansion_query = """
        SELECT 
            region,
            COUNT(*) as total_customers,
            SUM(CASE WHEN is_business = 1 THEN 1 ELSE 0 END) as business_customers,
            SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active_customers,
            AVG(CAST(risk_score_numeric AS FLOAT)) as avg_risk_score
        FROM customer_enriched 
        GROUP BY region
        ORDER BY total_customers DESC
        """
        
        expansion_df = pd.read_sql(expansion_query, engine)
        print(f"\n🎯 Market Analysis by Region:")
        for _, row in expansion_df.iterrows():
            business_pct = (row['business_customers'] / row['total_customers'] * 100) if row['total_customers'] > 0 else 0
            active_pct = (row['active_customers'] / row['total_customers'] * 100) if row['total_customers'] > 0 else 0
            print(f"   {row['region']}: {row['total_customers']} customers | {business_pct:.0f}% business | {active_pct:.0f}% active | Risk: {row['avg_risk_score']:.1f}")
        
        # 4. Data quality scorecard
        quality_query = """
        SELECT 
            enrichment_status,
            COUNT(*) as customer_count,
            AVG(CASE WHEN geo_enriched = 1 THEN 100.0 ELSE 0.0 END) as geo_completion_rate,
            AVG(CASE WHEN is_business = 1 AND company IS NOT NULL AND company != '' THEN 100.0 
                     WHEN is_business = 0 THEN 100.0 ELSE 0.0 END) as business_data_quality
        FROM customer_enriched 
        GROUP BY enrichment_status
        ORDER BY customer_count DESC
        """
        
        quality_df = pd.read_sql(quality_query, engine)
        print(f"\n📈 Data Quality Scorecard:")
        for _, row in quality_df.iterrows():
            print(f"   {row['enrichment_status']}: {row['customer_count']} customers | Geo: {row['geo_completion_rate']:.0f}% | Business: {row['business_data_quality']:.0f}%")
        
        return True
        
    except Exception as e:
        print(f"❌ Business insights generation failed: {e}")
        return False

# Generate insights
if validation_success:
    insights_success = generate_business_insights()
else:
    print("⚠️  Skipping business insights due to validation issues")
```

## Step 7: Test Upsert Functionality

Demonstrate how the pipeline handles updates to existing customers.


```python
# Test upsert functionality with updated customer data
def test_upsert_functionality():
    """Test how the pipeline handles existing customer updates"""
    
    print("=== TESTING UPSERT FUNCTIONALITY ===")
    
    # Create updated customer data (some existing, some new)
    updated_customers = {
        'customer_id': [1001, 1002, 1007, 1008],  # 1001,1002 exist, 1007,1008 are new
        'first_name': ['John', 'Jane', 'David', 'Emma'],
        'last_name': ['Smith', 'Doe', 'Taylor', 'Watson'],
        'email': ['john.smith@newemail.com', 'jane@email.com', 'david@company.com', 'emma@startup.com'],
        'phone': ['01234567890', '01987654321', '01666777888', '01999888777'],
        'postcode': ['SW1A 1AA', 'M1 1AH', 'E1 0AD', 'EC1A 1BB'],
        
        # Geographic enrichment
        'region': ['London', 'North West', 'London', 'London'],
        'country': ['England', 'England', 'England', 'England'],
        'district': ['Westminster', 'Manchester', 'Tower Hamlets', 'City of London'],
        'longitude': [-0.1419, -2.2426, -0.0713, -0.0982],
        'latitude': [51.5014, 53.4794, 51.5206, 51.5155],
        'geo_enriched': [1, 1, 1, 1],  # Changed from True to 1
        
        # Business enrichment
        'company': ['', '', 'Tech Solutions Ltd', 'Innovation Startup'],
        'company_size': ['Individual', 'Individual', 'Small (10-50 employees)', 'Micro (1-10 employees)'],
        'industry': ['Personal', 'Personal', 'Technology', 'Technology'],
        'annual_revenue': ['N/A', 'N/A', '£100K-£2M', '£0-£100K'],
        'is_business': [0, 0, 1, 1],  # Changed from False/True to 0/1
        
        # Risk assessment
        'calculated_risk': ['Low', 'Low', 'Medium', 'High'],
        'risk_score_numeric': [0, 0, 2, 3],
        'risk_factors': ['Standard profile', 'Standard profile', 'High-risk region', 
                        'New business; High-risk region'],
        
        # Account status
        'status': ['active', 'active', 'active', 'active'],
        
        # ETL metadata
        'processed_date': [datetime.now().strftime('%Y-%m-%d %H:%M:%S')] * 4,
        'data_source': ['ETL_Pipeline_v1_Update'] * 4,
        'enrichment_status': ['Fully Enriched'] * 4
    }
    
    df_updates = pd.DataFrame(updated_customers)
    
    print("Test data includes:")
    print("- Customer 1001: Updated email address (existing customer)")
    print("- Customer 1002: No changes (existing customer)")
    print("- Customer 1007: New business customer")
    print("- Customer 1008: New high-risk customer")
    
    # Load the updated data
    loader = DatabaseLoader(warehouse_connection_string)
    update_results = loader.load_enriched_customers(df_updates)
    
    print("\n=== UPSERT RESULTS ===")
    print(f"Total records processed: {update_results['total_records']}")
    print(f"New customers inserted: {update_results['successful_inserts']}")
    print(f"Existing customers updated: {update_results['successful_updates']}")
    print(f"Processing time: {update_results['processing_time']:.2f} seconds")
    
    # Verify the results using SQLAlchemy engine
    params = urllib.parse.quote_plus(warehouse_connection_string)
    engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
    
    verification_query = """
    SELECT 
        customer_id,
        first_name + ' ' + last_name as customer_name,
        email,
        data_source,
        created_date,
        modified_date
    FROM customer_enriched 
    WHERE customer_id IN (1001, 1002, 1007, 1008)
    ORDER BY customer_id
    """
    
    verification_df = pd.read_sql(verification_query, engine)
    print("\n=== VERIFICATION OF UPSERT RESULTS ===")
    for _, row in verification_df.iterrows():
        created = row['created_date'].strftime('%H:%M:%S')
        modified = row['modified_date'].strftime('%H:%M:%S')
        source = row['data_source']
        
        if created == modified and 'Update' not in source:
            status = "🆕 NEW"
        elif 'Update' in source:
            status = "✏️  UPDATED"
        else:
            status = "🔄 EXISTING"
            
        print(f"   {status} {row['customer_name']} ({row['customer_id']}) - {row['email']}")
    
    return update_results

# Run the upsert test
if validation_success:
    upsert_results = test_upsert_functionality()
else:
    print("⚠️  Skipping upsert test due to validation issues")
```

## Step 8: ETL Pipeline Summary

Status report of the full ETL pipeline!


```python
# Function to strip emojis from a string
import re
def remove_emojis(text):
    return re.sub(r'[^\x00-\x7F]+', '', text)

# Generate final pipeline summary
def generate_pipeline_summary():
    """Create comprehensive summary of ETL pipeline execution"""
    
    summary_report = f"""
==========================================================
🎉 ETL PIPELINE EXECUTION COMPLETE!
==========================================================

PIPELINE OVERVIEW:
• Extract: ✅ Customer data from CSV + API enrichment
• Transform: ✅ Data cleaning + business logic + risk scoring  
• Load: ✅ Enriched data loaded to SQL Server data warehouse

TODAY'S ACHIEVEMENTS:
✅ Built complete ETL pipeline from scratch
✅ Integrated multiple data sources (CSV + APIs)
✅ Applied business logic and data validation
✅ Implemented production-ready database loading
✅ Created audit trails and monitoring
✅ Generated business insights from enriched data

TECHNICAL COMPONENTS MASTERED:
• Python ETL development (pandas, requests)
• API integration and error handling
• SQL Server database operations
• Data quality assessment and reporting
• Business intelligence and analytics

BUSINESS VALUE CREATED:
• Customer support team has enriched profiles
• Risk assessment enables proactive management
• Geographic insights support expansion planning
• Data quality metrics ensure reliability

PRODUCTION READINESS:
• ✅ Error handling and graceful failure recovery
• ✅ Audit logging for compliance and monitoring
• ✅ Data validation and quality checks
• ✅ Performance metrics and timing
• ✅ Scalable upsert logic for ongoing updates

TOMORROW'S PREVIEW:
🔄 Rebuild this exact pipeline using Azure Data Factory
🎯 Learn visual ETL design and enterprise deployment
📊 Discover how ETL concepts apply across different tools

NEXT STEPS FOR YOUR ORGANISATION:
1. Identify data sources that need enrichment
2. Map business rules and validation requirements
3. Design monitoring and alerting strategies
4. Plan for data governance and quality standards

🏆 CONGRATULATIONS!
You've successfully completed a professional-grade ETL pipeline!
==========================================================
"""
    
    print(summary_report)
    
    # Save summary to file
    text_for_file = remove_emojis(summary_report)
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    summary_file = f'etl_pipeline_summary_{timestamp}.txt'
    
    with open(summary_file, 'w') as f:
        f.write(text_for_file)
    
    print(f"📄 Pipeline summary saved to: {summary_file}")

# Generate the final summary
generate_pipeline_summary()
```

---
## Reflection and Discussion

**Production Considerations:**
- What monitoring would you implement for this pipeline?
- How would you handle the pipeline failing at 3am?
- What data governance policies are needed?
- How would you secure sensitive customer data?

**Tomorrow's Bridge:**
- How might visual tools like Azure Data Factory change this process?
- What are the pros/cons of coded vs visual ETL approaches?



```python

```
