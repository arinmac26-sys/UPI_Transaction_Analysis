### checking referential integrity (customer_id belongs to below table)

SELECT 
    'upi_account_details' AS child_table,
    COUNT(DISTINCT a.customer_id) AS invalid_customer_ids
FROM upi_account_details a
LEFT JOIN customer_master c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

SELECT 
    'device_info' AS child_table,
    COUNT(DISTINCT d.customer_id) AS invalid_customer_ids
FROM device_info d
LEFT JOIN customer_master c
    ON d.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

SELECT 
    'upi_transaction_history' AS child_table,
    COUNT(DISTINCT t.customer_id) AS invalid_customer_ids
FROM upi_transaction_history t
LEFT JOIN customer_master c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

SELECT 
    'customer_feedback_surveys' AS child_table,
    COUNT(DISTINCT f.customer_id) AS invalid_customer_ids
FROM customer_feedback_surveys f
LEFT JOIN customer_master c
    ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

#### Also check for NULL customer IDs

SELECT 'upi_account_details' AS table_name,
       COUNT(*) AS null_customer_ids
FROM upi_account_details
WHERE customer_id IS NULL

UNION ALL

SELECT 'device_info',
       COUNT(*)
FROM device_info
WHERE customer_id IS NULL

UNION ALL

SELECT 'upi_transaction_history',
       COUNT(*)
FROM upi_transaction_history
WHERE customer_id IS NULL

UNION ALL

SELECT 'customer_feedback_surveys',
       COUNT(*)
FROM customer_feedback_surveys
WHERE customer_id IS NULL;

### Check actual unmatched records

SELECT 
    a.customer_id
FROM upi_account_details a
LEFT JOIN customer_master c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

## Merchant

SELECT 'Merchant' , merchant_id, COUNT(*) AS cnt
FROM merchant_info
GROUP BY merchant_id
HAVING COUNT(*) > 1
;

## UPI account
SELECT 'UPI account',upi_id, COUNT(*) AS cnt
FROM upi_account_details
GROUP BY upi_id
HAVING COUNT(*) > 1
;

### Device
SELECT 'Device',device_id, COUNT(*) AS cnt
FROM device_info
GROUP BY device_id
HAVING COUNT(*) > 1
;

### Transaction
SELECT 'Transaction',transaction_id, COUNT(*) AS cnt
FROM upi_transaction_history
GROUP BY transaction_id
HAVING COUNT(*) > 1
;




