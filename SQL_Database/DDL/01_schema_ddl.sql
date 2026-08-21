CREATE DATABASE IF NOT EXISTS upi_transaction;
USE upi_transaction;

use upi_transaction;

CREATE TABLE customer_master (
    customer_id VARCHAR(50) PRIMARY KEY,
    full_name VARCHAR(150),
    mobile_number BIGINT,
    age INT,
    gender VARCHAR(20),
    region VARCHAR(100),
    date_joined DATE,
    is_business_user BOOLEAN,
    risk_score DECIMAL(5,2)
);

CREATE TABLE device_info (
    device_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    device_type VARCHAR(20),
    app_version VARCHAR(20),
    is_rooted BOOLEAN,
    last_active DATETIME(6)
);

CREATE TABLE upi_account_details (
    upi_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    bank_name VARCHAR(100),
    account_type VARCHAR(30),
    date_added DATE,
    status VARCHAR(20),

    CONSTRAINT fk_upi_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_master(customer_id)
);

CREATE TABLE merchant_info (
    merchant_id VARCHAR(50) PRIMARY KEY,
    merchant_name VARCHAR(150),
    merchant_type VARCHAR(100),
    region VARCHAR(100),
    onboard_date DATE,
    risk_score DECIMAL(5,2)
);



CREATE TABLE upi_transaction_history (
    transaction_id VARCHAR(50) PRIMARY KEY,
    upi_id VARCHAR(100),
    customer_id VARCHAR(50),
    timestamp DATETIME,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(50),
    merchant_id VARCHAR(50),
    counterparty_upi VARCHAR(100),
    status VARCHAR(50),
    device_id VARCHAR(50),
    device_type VARCHAR(50),
    channel VARCHAR(50),
    fraud_flag BOOLEAN,
    reversal_flag BOOLEAN,
    failure_reason VARCHAR(255),
    FOREIGN KEY (upi_id) REFERENCES upi_account_details(upi_id),
	FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id),
	FOREIGN KEY (merchant_id) REFERENCES merchant_info(merchant_id),
	FOREIGN KEY (device_id) REFERENCES device_info(device_id)
);

CREATE TABLE customer_feedback_surveys (
    feedback_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    date_submitted DATE,
    feedback_text TEXT,
    satisfaction_score INT,
    issue_type VARCHAR(50),
    resolved BOOLEAN,

    CONSTRAINT fk_feedback_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_master(customer_id)
);

CREATE TABLE fraud_alert_history (
    alert_id VARCHAR(20) PRIMARY KEY,
    transaction_id VARCHAR(30) NOT NULL,
    alert_type VARCHAR(50),
    alert_date DATETIME(6),
    resolved BOOLEAN,
    resolution_date DATETIME(6) NULL,
    remarks TEXT,

    CONSTRAINT fk_alert_transaction
	FOREIGN KEY (transaction_id) REFERENCES upi_transaction_history(transaction_id)
);

CREATE INDEX idx_txn_timestamp ON upi_transaction_history(timestamp);
CREATE INDEX idx_txn_customer ON upi_transaction_history(customer_id);
CREATE INDEX idx_txn_fraud ON upi_transaction_history(fraud_flag);
CREATE INDEX idx_alert_date ON fraud_alert_history(alert_date);



