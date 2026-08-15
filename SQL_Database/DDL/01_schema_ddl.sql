CREATE DATABASE IF NOT EXISTS upi_transaction;
USE upi_transaction;

use upi_transaction;

CREATE TABLE customer_master (
 customer_id VARCHAR(30) PRIMARY KEY, 
 full_name VARCHAR(150) NOT NULL, 
 mobile_number VARCHAR(20) NOT NULL,
 age INT NOT NULL CHECK (age BETWEEN 18 AND 120), 
 gender VARCHAR(20) NOT NULL, 
 region VARCHAR(30) NOT NULL,
 date_joined DATE NOT NULL, 
 is_business_user BOOLEAN NOT NULL, 
 risk_score DECIMAL(5,4) NOT NULL CHECK (risk_score BETWEEN 0 AND 1)
);

CREATE TABLE device_info (
 device_id VARCHAR(30) PRIMARY KEY, 
 customer_id VARCHAR(30) NOT NULL, 
 device_type VARCHAR(30) NOT NULL,
 app_version VARCHAR(30), 
 is_rooted BOOLEAN NOT NULL, 
 last_active DATETIME NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

CREATE TABLE upi_account_details (
 upi_id VARCHAR(150) PRIMARY KEY, 
 customer_id VARCHAR(30) NOT NULL, 
 bank_name VARCHAR(50) NOT NULL,
 account_type VARCHAR(40) NOT NULL, 
 date_added DATE NOT NULL, 
 status VARCHAR(30) NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

CREATE TABLE merchant_info (
 merchant_id VARCHAR(30) PRIMARY KEY, 
 merchant_name VARCHAR(200) NOT NULL, 
 merchant_type VARCHAR(50) NOT NULL,
 region VARCHAR(30) NOT NULL, 
 onboard_date DATE NOT NULL, 
 risk_score DECIMAL(5,4) NOT NULL CHECK (risk_score BETWEEN 0 AND 1)
);

CREATE TABLE upi_transaction_history (
 transaction_id VARCHAR(30) PRIMARY KEY, 
 upi_id VARCHAR(150) NOT NULL, 
 customer_id VARCHAR(30) NOT NULL,
 timestamp DATETIME NOT NULL, 
 amount DECIMAL(14,2) NOT NULL CHECK (amount > 0), 
 transaction_type VARCHAR(40) NOT NULL,
 merchant_id VARCHAR(30), 
 counterparty_upi VARCHAR(150), 
 status VARCHAR(20) NOT NULL, 
 device_id VARCHAR(30) NOT NULL,
 device_type VARCHAR(30) NOT NULL, 
 channel VARCHAR(30) NOT NULL, 
 fraud_flag BOOLEAN NOT NULL,
 reversal_flag BOOLEAN NOT NULL, 
 failure_reason VARCHAR(50),
 FOREIGN KEY (upi_id) REFERENCES upi_account_details(upi_id),
 FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id),
 FOREIGN KEY (merchant_id) REFERENCES merchant_info(merchant_id),
 FOREIGN KEY (device_id) REFERENCES device_info(device_id)
);

CREATE TABLE customer_feedback_surveys (
 feedback_id VARCHAR(30) PRIMARY KEY, 
 customer_id VARCHAR(30) NOT NULL, 
 date_submitted DATE NOT NULL,
 feedback_text TEXT, 
 satisfaction_score INT NOT NULL CHECK (satisfaction_score BETWEEN 1 AND 5),
 issue_type VARCHAR(40) NOT NULL, 
 resolved BOOLEAN NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

CREATE TABLE fraud_alert_history (
 alert_id VARCHAR(30) PRIMARY KEY, 
 transaction_id VARCHAR(30) NOT NULL, 
 alert_type VARCHAR(50) NOT NULL,
 alert_date DATETIME NOT NULL,
 resolved BOOLEAN NOT NULL, 
 resolution_date DATETIME, remarks TEXT,
 FOREIGN KEY (transaction_id) REFERENCES upi_transaction_history(transaction_id)
);

CREATE INDEX idx_txn_timestamp ON upi_transaction_history(timestamp);
CREATE INDEX idx_txn_customer ON upi_transaction_history(customer_id);
CREATE INDEX idx_txn_fraud ON upi_transaction_history(fraud_flag);
CREATE INDEX idx_alert_date ON fraud_alert_history(alert_date);
