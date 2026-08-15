# UPI Transaction Analysis — Business Understanding

## Objectives
Analyze transaction, customer, merchant, device, feedback and fraud-alert data to improve operational performance, fraud controls, customer trust and management reporting.

## Hypotheses
- H1: Rooted devices have higher fraud incidence than non-rooted devices.
- H2: Fraud incidence differs by channel.
- H3: Transaction status is associated with device type.
- H4: Fraud incidence differs by merchant type.
- H5: Customer risk score is associated with fraud occurrence.

## KPI Framework
Transaction Volume = COUNT(transaction_id)
GMV = SUM(amount)
Failure Rate = Failed / Total
Fraud Rate = Fraud / Total
Reversal Rate = Reversed / Total
Alert Resolution Rate = Resolved Alerts / Alerts
Customer Retention = Consecutive-month active customers retained / prior-month active customers
Average Satisfaction = AVG(satisfaction_score)

## Baseline
Transactions: 100,000
GMV: INR 4,241,774.26
Success: 92.14%
Failure: 5.87%
Fraud: 2.00%
Reversal: 1.45%
