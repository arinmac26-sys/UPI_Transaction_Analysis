# UPI Transaction Analysis — Senior Data Analytics Capstone

![Python](https://img.shields.io/badge/Python-Pandas-blue)
![SQL](https://img.shields.io/badge/SQL-MySQL-orange)
![Power%20BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)

## Objective
End-to-end analysis of UPI transactions, fraud, devices, merchants, customers, feedback and alerts using Excel, SQL, Python/statistics and Power BI.

## Dataset
Customers 10,000 | Devices 12,000 | Accounts 12,000 | Merchants 500 | Transactions 100,000 | Feedback 4,000 | Alerts 2,000

## KPI Snapshot
- GMV: INR 4,241,774.26
- Average transaction: INR 42.42
- Success: 92.14%
- Failure: 5.87%
- Fraud: 2.00%
- Reversal: 1.45%

## Key Finding
Rooted devices show 20.69% fraud versus 1.39% on non-rooted devices — about 14.9x higher.

## Project Structure
01_Business_Understanding → business framing + executive story
02_Data_Validation_Excel → validation workbook + data quality log
03_SQL_Database → DDL + analytical queries
04_Python_Analytics → reproducible notebook
05_PowerBI → model, DAX and prepared tables
06_Executive_Report → management report
07_Visuals → supporting charts
08_Source_Data → supplied CSVs
09_Documentation → ERD and documentation

## Data Quality
Foreign-key validation: 0 invalid references. Source issues: 969 mobile numbers are not 10 digits and 3,818 merchant-linked transactions precede merchant onboarding dates. Investigate these before production deployment.

## Power BI Dashboard
Build three pages: Executive Overview, Fraud & Operations, Customer Experience. Use date, region, device/root status, channel, merchant type and status as slicers.
