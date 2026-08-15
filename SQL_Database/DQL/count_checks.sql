###. Verify row counts
SELECT COUNT(*) AS customer_count
FROM customer_master;

SELECT COUNT(*) AS device_count
FROM device_info;

SELECT COUNT(*) AS account_count
FROM upi_account_details;

SELECT COUNT(*) AS merchant_count
FROM merchant_info;

SELECT COUNT(*) AS transaction_count
FROM upi_transaction_history;

SELECT COUNT(*) AS feedback_count
FROM customer_feedback_surveys;

SELECT COUNT(*) AS fraud_alert_count
FROM fraud_alert_history;

