## After validation, create the foreign keys

## 1. upi_account_details

ALTER TABLE upi_account_details
ADD CONSTRAINT fk_account_customer
FOREIGN KEY (customer_id)
REFERENCES customer_master(customer_id);

## 2 device_info

ALTER TABLE device_info
ADD CONSTRAINT fk_device_customer
FOREIGN KEY (customer_id)
REFERENCES customer_master(customer_id);

## 3 upi_transaction_history

ALTER TABLE upi_transaction_history
ADD CONSTRAINT fk_transaction_customer
FOREIGN KEY (customer_id)
REFERENCES customer_master(customer_id);

## 4. customer_feedback_surveys

ALTER TABLE customer_feedback_surveys
ADD CONSTRAINT fk_feedback_customer
FOREIGN KEY (customer_id)
REFERENCES customer_master(customer_id);

## 5.Verify that the foreign keys were actually created

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_SCHEMA = 'upi_transaction'
  AND REFERENCED_TABLE_NAME = 'customer_master';
  
  
#### Transaction → Merchant
ALTER TABLE upi_transaction_history
ADD CONSTRAINT fk_transaction_merchant
FOREIGN KEY (merchant_id)
REFERENCES merchant_info(merchant_id);

## Transaction → UPI Account
ALTER TABLE upi_transaction_history
ADD CONSTRAINT fk_transaction_upi
FOREIGN KEY (upi_id)
REFERENCES upi_account_details(upi_id);

## Transaction → Device

ALTER TABLE upi_transaction_history
ADD CONSTRAINT fk_transaction_device
FOREIGN KEY (device_id)
REFERENCES device_info(device_id);

### Fraud Alert → Transaction
ALTER TABLE fraud_alert_history
ADD CONSTRAINT fk_fraud_transaction
FOREIGN KEY (transaction_id)
REFERENCES upi_transaction_history(transaction_id);


## Verify ALL foreign keys in your UPI database
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_SCHEMA = 'upi_transaction'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;



