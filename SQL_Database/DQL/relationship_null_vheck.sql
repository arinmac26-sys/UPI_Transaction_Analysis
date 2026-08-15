SELECT 
    'merchant_id' AS relationship,
    'upi_transaction_history → merchant_info' AS relationship_check,
    COUNT(DISTINCT t.merchant_id) AS invalid_ids
FROM upi_transaction_history t
LEFT JOIN merchant_info m
    ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL

UNION ALL

SELECT 
    'upi_id',
    'upi_transaction_history → upi_account_details',
    COUNT(DISTINCT t.upi_id)
FROM upi_transaction_history t
LEFT JOIN upi_account_details a
    ON t.upi_id = a.upi_id
WHERE a.upi_id IS NULL

UNION ALL

SELECT 
    'device_id',
    'upi_transaction_history → device_info',
    COUNT(DISTINCT t.device_id)
FROM upi_transaction_history t
LEFT JOIN device_info d
    ON t.device_id = d.device_id
WHERE d.device_id IS NULL

UNION ALL

SELECT 
    'transaction_id',
    'fraud_alert_history → upi_transaction_history',
    COUNT(DISTINCT f.transaction_id)
FROM fraud_alert_history f
LEFT JOIN upi_transaction_history t
    ON f.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;

### Null value checks

SELECT
    'merchant_id' AS column_name,
    COUNT(*) AS null_count
FROM upi_transaction_history
WHERE merchant_id IS NULL

UNION ALL

SELECT
    'upi_id',
    COUNT(*)
FROM upi_transaction_history
WHERE upi_id IS NULL

UNION ALL

SELECT
    'device_id',
    COUNT(*)
FROM upi_transaction_history
WHERE device_id IS NULL

UNION ALL

SELECT
    'fraud_transaction_id',
    COUNT(*)
FROM fraud_alert_history
WHERE transaction_id IS NULL;

