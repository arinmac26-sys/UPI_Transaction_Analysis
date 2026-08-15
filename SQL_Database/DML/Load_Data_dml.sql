SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

#
USE upi_transaction;

# Import customer_master.csv

LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/customer_master.csv'
INTO TABLE customer_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    customer_id,
    full_name,
    mobile_number,
    age,
    gender,
    region,
    date_joined,
    is_business_user,
    risk_score
);

## Import device_info.csv
LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/device_info.csv'
INTO TABLE device_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    device_id,
    customer_id,
    device_type,
    app_version,
    is_rooted,
    last_active
);

## Import upi_account_details.csv

LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/upi_account_details.csv'
INTO TABLE upi_account_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    upi_id,
    customer_id,
    bank_name,
    account_type,
    date_added,
    status
);

## Import merchant_info.csv
LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/merchant_info.csv'
INTO TABLE merchant_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    merchant_id,
    merchant_name,
    merchant_type,
    region,
    onboard_date,
    risk_score
);

## Import upi_transaction_history.csv

LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/upi_transaction_history.csv'
INTO TABLE upi_transaction_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    transaction_id,
    upi_id,
    customer_id,
    timestamp,
    amount,
    transaction_type,
    merchant_id,
    counterparty_upi,
    status,
    device_id,
    device_type,
    channel,
    fraud_flag,
    reversal_flag,
    failure_reason
);

### Import customer_feedback_surveys.csv

LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/customer_feedback_surveys.csv'
INTO TABLE customer_feedback_surveys
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    feedback_id,
    customer_id,
    date_submitted,
    feedback_text,
    satisfaction_score,
    issue_type,
    resolved
);

## Import fraud_alert_history.csv

LOAD DATA LOCAL INFILE '/Users/arindamdasbiswas/Desktop/UPI_Project/fraud_alert_history.csv'
INTO TABLE fraud_alert_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    alert_id,
    transaction_id,
    alert_type,
    alert_date,
    resolved,
    resolution_date,
    remarks
);

