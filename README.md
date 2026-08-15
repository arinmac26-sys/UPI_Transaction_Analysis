# UPI Transaction Analysis | End-to-End Data Analytics Capstone

> **Senior Data Analyst Portfolio Project**  
> **Domain:** Digital Payments / UPI  
> **Stack:** Excel · MySQL · Python · Statistics · Power BI

## Executive Overview

This project analyzes a UPI/digital-payments platform across **transaction performance, fraud risk, operational failures, device behavior, merchant activity, customer feedback and fraud-alert management**.

The end-to-end workflow is:

```text
Business Understanding
        ↓
Excel Data Validation
        ↓
MySQL Database Design & Ingestion
        ↓
SQL Data Quality & Analytics
        ↓
Python EDA & Feature Engineering
        ↓
Statistical / Hypothesis Testing
        ↓
Power BI Executive & Fraud Dashboards
        ↓
Strategic Recommendations
```

The supplied capstone asks the analyst to identify transaction/fraud patterns, develop KPIs and dashboards, validate data integrity, and deliver actionable recommendations.

---

## Business Problem

As UPI adoption grows, a payments platform must balance **transaction reliability, fraud prevention, customer experience, merchant performance and operational efficiency**.

### Key Business Questions

1. Which customer, device, merchant, region and channel segments show elevated fraud risk?
2. Where do transaction failures and operational bottlenecks occur?
3. What are the major failure root causes?
4. How effective are fraud alerts and resolution processes?
5. How does transaction performance vary over time?
6. Which merchants/devices/regions require management attention?
7. What actions can reduce fraud and failures without unnecessarily impacting legitimate users?

---

## Project Objectives

### Business Objectives

- Monitor transaction volume and GMV.
- Measure transaction success, failure and pending rates.
- Identify fraud-prone customer/device/merchant segments.
- Analyze transaction reversals.
- Understand failure root causes.
- Monitor fraud-alert volumes and resolution.
- Analyze customer satisfaction and issue resolution.
- Produce executive-ready KPIs and recommendations.

### Analytics Objectives

- Build a validated relational data model.
- Establish referential integrity across all datasets.
- Create reusable SQL analytical queries.
- Perform Python-based EDA and feature engineering.
- Validate hypotheses using statistical tests.
- Develop an interactive Power BI analytical layer.
- Convert analytical findings into business actions.

---

# Dataset Architecture

| Table | Purpose |
|---|---|
| `customer_master` | Customer profile, demographics, region, join date and risk score |
| `device_info` | Device characteristics, app version, rooted status and activity |
| `upi_account_details` | UPI handle, customer, bank, account type and account status |
| `merchant_info` | Merchant master, category, region, onboarding date and risk |
| `upi_transaction_history` | Transaction-level payment, status, channel and fraud data |
| `customer_feedback_surveys` | Customer feedback, satisfaction and issue resolution |
| `fraud_alert_history` | Fraud alerts, resolution status and remarks |

### Core Relationships

```text
customer_master
 ├── device_info
 ├── upi_account_details
 ├── upi_transaction_history
 └── customer_feedback_surveys

upi_account_details ──> upi_transaction_history
device_info ──────────> upi_transaction_history
merchant_info ────────> upi_transaction_history
upi_transaction_history ──> fraud_alert_history
```

---

# Excel Data Validation

Excel was used as the initial data-quality gate.

### Referential Integrity

Validated:

- `upi_account_details.customer_id → customer_master.customer_id`
- `device_info.customer_id → customer_master.customer_id`
- `upi_transaction_history.customer_id → customer_master.customer_id`
- `customer_feedback_surveys.customer_id → customer_master.customer_id`
- `upi_transaction_history.merchant_id → merchant_info.merchant_id`
- `upi_transaction_history.upi_id → upi_account_details.upi_id`
- `upi_transaction_history.device_id → device_info.device_id`
- `fraud_alert_history.transaction_id → upi_transaction_history.transaction_id`

### Example Excel Formula

```excel
=IF(COUNTIF(customer_master!$A:$A,B2)>0,"VALID","INVALID")
```

### Data Quality Controls

- Missing critical fields
- Invalid/blank amounts
- Status consistency
- Fraud-flag consistency
- Risk-score quality
- Device-type consistency
- Date formatting
- Duplicate identifiers
- Referential integrity
- Business-rule anomalies

A **Data Quality Log** documents issues, affected rows and recommended actions rather than silently deleting records.

---

# MySQL Database

## Database

```sql
CREATE DATABASE upi_analytics;
USE upi_analytics;
```

## Tables

```text
customer_master
device_info
upi_account_details
merchant_info
upi_transaction_history
customer_feedback_surveys
fraud_alert_history
```

## CSV Ingestion

CSV files can be loaded through MySQL Workbench or:

```sql
LOAD DATA LOCAL INFILE
```

Example:

```sql
LOAD DATA LOCAL INFILE '/path/customer_master.csv'
INTO TABLE customer_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### Ingestion Validation

```sql
SELECT COUNT(*) FROM customer_master;
SELECT COUNT(*) FROM device_info;
SELECT COUNT(*) FROM upi_account_details;
SELECT COUNT(*) FROM merchant_info;
SELECT COUNT(*) FROM upi_transaction_history;
SELECT COUNT(*) FROM customer_feedback_surveys;
SELECT COUNT(*) FROM fraud_alert_history;
```

Random record spot checks and foreign-key validation are performed before analytical use.

---

# SQL Analytics

SQL is used for:

- Joins
- Aggregations
- KPI calculations
- Fraud segmentation
- Failure analysis
- Merchant analysis
- Device analysis
- Regional analysis
- Time-series analysis
- Data-quality monitoring

### Executive KPI Query

```sql
SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount),2) AS total_gmv,
    ROUND(AVG(amount),2) AS avg_transaction_amount,
    ROUND(SUM(status='Failed') / COUNT(*) * 100,2) AS failure_rate_pct,
    ROUND(SUM(fraud_flag=TRUE) / COUNT(*) * 100,2) AS fraud_rate_pct,
    ROUND(SUM(reversal_flag=TRUE) / COUNT(*) * 100,2) AS reversal_rate_pct
FROM upi_transaction_history;
```

### Fraud by Device

```sql
SELECT
    d.device_type,
    d.is_rooted,
    COUNT(t.transaction_id) AS transactions,
    SUM(t.fraud_flag) AS fraud_transactions,
    ROUND(SUM(t.fraud_flag)/COUNT(t.transaction_id)*100,2) AS fraud_rate_pct
FROM upi_transaction_history t
JOIN device_info d
    ON t.device_id = d.device_id
GROUP BY d.device_type, d.is_rooted
ORDER BY fraud_rate_pct DESC;
```

---

# Python Analytics

Python is used for data extraction, cleaning, EDA, feature engineering and statistical analysis.

### Core Libraries

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
```

For SQL connectivity:

```python
import pymysql
from sqlalchemy import create_engine
```

### Workflow

1. Connect to MySQL.
2. Extract analytical datasets.
3. Validate schemas and row counts.
4. Convert dates and numeric fields.
5. Handle missing values using documented business rules.
6. Create derived KPIs/features.
7. Perform descriptive statistics.
8. Identify high-risk segments.
9. Visualize trends and distributions.
10. Run statistical tests.
11. Translate findings into business recommendations.

### Derived Metrics

```text
Merchant Fraud Ratio
= Fraud Transactions / Total Merchant Transactions

Device Fraud Ratio
= Fraud Transactions / Total Device Transactions

Transaction Failure Rate
= Failed Transactions / Total Transactions

Transaction Value per Customer
= Total Customer Transaction Value / Customer Transactions
```

---

# Exploratory Data Analysis

### Transaction Performance

- Transaction volume
- GMV
- Average transaction amount
- Success rate
- Failure rate
- Pending rate
- Reversal rate

### Fraud Analytics

- Fraud volume
- Fraud value
- Fraud rate
- Fraud by device
- Fraud by rooted status
- Fraud by region
- Fraud by channel
- Fraud by merchant type
- Fraud by risk score

### Operations

- Failure reason
- Failure rate by channel
- Failure rate by device
- Failure rate by region
- Merchant-level performance

### Customer Experience

- Satisfaction score
- Issue type
- Feedback volume
- Resolution rate

---

# Statistical Analysis

The project uses statistical testing to validate business hypotheses.

| Test | Business Question |
|---|---|
| Welch t-test | Does transaction behavior differ between selected groups? |
| Chi-square | Is fraud associated with channel/device/status? |
| ANOVA | Does fraud vary across merchant categories/regions? |
| Correlation | Is customer risk score associated with fraud behavior? |

Statistical outputs should be interpreted using p-values, confidence intervals, effect size where appropriate, assumptions and business significance.

### Example Hypothesis

**H₀:** Rooted-device status is not associated with fraud incidence.

**H₁:** Rooted-device status is associated with fraud incidence.

---

# Executive KPI Baseline

Based on the completed project analysis:

| KPI | Result |
|---|---:|
| Transactions | **100,000** |
| Customers | **10,000** |
| Merchants | **500** |
| UPI Accounts | **12,000** |
| Devices | **12,000** |
| GMV | **₹4.24M** |
| Average Transaction | **₹42.42** |
| Success Rate | **92.14%** |
| Failure Rate | **5.87%** |
| Pending Rate | **1.99%** |
| Fraud Rate | **2.00%** |
| Reversal Rate | **1.45%** |
| Fraud Transaction Value | **₹84,713** |
| Feedback Records | **4,000** |
| Fraud Alerts | **2,000** |

> KPI values represent the project analysis baseline and should be reconciled against the final MySQL database before production/dashboard publication.

---

# Key Fraud Finding

One of the strongest analytical signals identified is **device rooted/jailbroken status**.

Observed fraud incidence:

- Rooted devices: approximately **20%**
- Non-rooted devices: approximately **1.4%**
- Difference: approximately **15× higher fraud incidence** for rooted devices

### Business Interpretation

Rather than applying broad restrictions to all customers, the platform can investigate:

- Device-integrity checks
- Step-up authentication
- Transaction risk scoring
- Additional verification for high-risk device states
- Monitoring of repeated suspicious activity

This recommendation should be tested against customer friction, false positives and legitimate-user impact before production rollout.

---

# Transaction Failure Findings

| Failure Reason | Count |
|---|---:|
| Incorrect PIN | 1,511 |
| Network Error | 1,486 |
| Account Blocked | 1,455 |
| Bank Down | 1,419 |

### Business Implications

Two intervention areas emerge:

**Customer-controlled failures**
- PIN guidance
- Account-status messaging
- Clear recovery flows

**Infrastructure / ecosystem failures**
- Bank availability monitoring
- Network observability
- Retry/recovery mechanisms
- Failure-code standardization

---

# Data Quality Findings

The validation process identified source-data issues that should be **documented and investigated**, not silently overwritten.

### Mobile Number Quality

Approximately **969 customer mobile numbers** did not consistently satisfy the expected 10-digit format.

### Merchant Temporal Consistency

Approximately **3,818 merchant-linked transactions** occurred before the recorded merchant onboarding date.

### Senior Analyst Treatment

1. Flag the issue.
2. Quantify affected records.
3. Investigate with the data owner.
4. Preserve it in the Data Quality Log.
5. Correct only through a documented business rule.

---

# Referential Integrity Result

All tested foreign-key relationships returned **0 invalid references** in the completed validation analysis.

Validated:

```text
Device → Customer
UPI Account → Customer
Transaction → Customer
Transaction → UPI Account
Transaction → Merchant
Transaction → Device
Fraud Alert → Transaction
```

---

# Power BI Dashboard Strategy

## Executive Dashboard

### KPI Cards

- Total Transactions
- Total GMV
- Average Transaction Amount
- Success Rate
- Failure Rate
- Fraud Rate
- Reversal Rate
- Fraud Transaction Value

### Visuals

- Monthly transaction trend
- Fraud trend
- Transaction status distribution
- Region comparison
- Device comparison
- Merchant comparison
- Transaction-type distribution

### Filters

- Date
- Region
- Device Type
- Merchant
- Status
- Channel
- Transaction Type

## Operations & Fraud Dashboard

- Fraud trend
- Fraud by rooted status
- High-risk devices
- High-risk merchants
- Failure root causes
- Fraud alerts
- Alert resolution
- Risk-score segments

---

# Strategic Recommendations

## 1. Targeted Device Risk Controls

Prioritize rooted/jailbroken devices for additional risk controls.

**Potential impact:** reduce fraud exposure while avoiding unnecessary friction for lower-risk customers.

## 2. Improve Payment Reliability

Focus on:

- Incorrect PIN
- Network errors
- Account blocked
- Bank downtime

Actions include improved error messaging, retry/recovery flows, bank/network monitoring and operational SLA dashboards.

## 3. Merchant Onboarding Governance

Investigate transactions occurring before recorded merchant onboarding.

Actions:

- Audit onboarding timestamps.
- Reconcile merchant master and transaction systems.
- Establish data-quality alerts.
- Add onboarding-date validation to ingestion.

## 4. Automate Data Quality Monitoring

Monitor:

```text
Row Count
Null Rate
Duplicate Rate
Foreign-Key Failure Rate
Invalid Category Rate
Date Consistency
Outlier Rate
```

## 5. Build Risk-Based Monitoring

Combine:

```text
Customer Risk Score
+
Device Risk
+
Merchant Risk
+
Transaction Value
+
Channel
+
Historical Fraud
```

to prioritize investigations.

---

# Recommended Repository Structure

```text
UPI-Transaction-Analysis/
│
├── README.md
├── 01_Business_Understanding/
├── 02_Data_Validation_Excel/
├── 03_SQL_Database/
├── 04_Python_Analytics/
├── 05_Statistics/
├── 06_PowerBI/
├── 07_Executive_Report/
├── 08_Presentation/
├── 09_Data/
└── 10_Documentation/
```

Suggested contents:

```text
03_SQL_Database/
├── 01_schema_ddl.sql
├── 02_data_quality_checks.sql
└── 03_analytics_queries.sql

04_Python_Analytics/
└── UPI_Transaction_Analysis.ipynb

06_PowerBI/
├── UPI_Transaction_Dashboard.pbix
├── DAX_Measures.md
└── Dashboard_Screenshots/

08_Presentation/
└── UPI_Data_Validation_Findings_Summary.pptx
```

---

# Technology Stack

| Technology | Usage |
|---|---|
| **Excel** | Data validation, FK checks, Data Quality Log |
| **MySQL** | Relational database, joins, aggregations |
| **Python** | Data cleaning, EDA, feature engineering |
| **Pandas / NumPy** | Data manipulation |
| **Matplotlib / Seaborn** | Visualization |
| **SciPy / Statsmodels** | Statistical testing |
| **Power BI** | Executive and operational dashboards |
| **DAX** | KPI and analytical measures |
| **Git / GitHub** | Version control and portfolio presentation |

---

# Project Deliverables

| Deliverable | Status |
|---|---|
| Business Understanding | ✅ |
| KPI Framework | ✅ |
| Excel Validation | ✅ |
| Data Quality Log | ✅ |
| SQL Schema / DDL | ✅ |
| CSV → MySQL Ingestion | ✅ |
| FK Validation | ✅ |
| SQL Analytics | ✅ |
| Python EDA | ✅ |
| Statistical Analysis | ✅ |
| Power BI Model / DAX | ✅ |
| Executive Findings | ✅ |
| Validation PowerPoint | ✅ |
| README Documentation | ✅ |

---

# Interview Talking Points

### Business

> "I designed an end-to-end UPI analytics solution covering transaction performance, fraud risk, operational failures and customer experience."

### Data Quality

> "Before analytics, I implemented referential-integrity and data-quality validation across seven relational datasets and documented source-system exceptions rather than silently modifying them."

### SQL

> "I designed a relational MySQL model with primary and foreign keys and built analytical queries for transaction, fraud, merchant and device performance."

### Python

> "I used Pandas and statistical methods to perform EDA, feature engineering, anomaly analysis and hypothesis testing."

### Power BI

> "I translated the analytical layer into executive and operational dashboards with KPI cards, trend analysis, segmentation and drill-down views."

### Business Impact

> "The strongest risk signal was rooted-device status, which showed materially higher fraud incidence. I therefore recommended targeted device-integrity controls instead of broad customer restrictions."

---

# Future Enhancements

- Automated ETL pipeline
- Incremental data loading
- Data-quality monitoring dashboard
- Customer-level risk scoring
- Merchant risk scoring
- Fraud classification model
- Real-time fraud monitoring
- Alert prioritization
- Customer churn / retention modeling
- Model monitoring and drift detection
- Cloud data warehouse deployment
- CI/CD for analytics pipelines

---

# Project Alignment

This repository follows the supplied capstone requirements:

- Business understanding and KPI framework
- Excel data validation and Data Quality Log
- SQL database design and ingestion
- Python SQL connectivity and EDA
- Statistical hypothesis testing
- Power BI / Tableau dashboard development
- Strategic insights and recommendations

The capstone explicitly requires customer, merchant, UPI and device relationship validation, SQL DDL, CSV ingestion, Python analysis, statistical tests, executive dashboards and quantified recommendations.

---

# Final Business Takeaway

This project demonstrates a complete **Senior Data Analyst workflow**:

```text
Raw Data
   ↓
Data Quality
   ↓
Relational Modeling
   ↓
SQL Analytics
   ↓
Python EDA
   ↓
Statistical Validation
   ↓
Business Intelligence
   ↓
Risk & Operations Insights
   ↓
Actionable Recommendations
```

> **Reliable analytics starts with validated data and ends with measurable business action.**

---

## Author

**Arindam Das Biswas**  
**Data Analytics | SQL | Python | Power BI | Data Engineering**

### Core Skills Demonstrated

`SQL` · `MySQL` · `Python` · `Pandas` · `NumPy` · `Statistics` · `Excel` · `Power BI` · `DAX` · `Data Quality` · `EDA` · `Fraud Analytics` · `Business Intelligence`

---

## Disclaimer

This is a portfolio/capstone analytics project based on the supplied datasets and project specification. KPI values and analytical conclusions should be reconciled against the final production database/model before being used for operational decision-making.
