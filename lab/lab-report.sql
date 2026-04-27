-- 1. Database and Table Creation (DDL)
-- Create Database
CREATE DATABASE bank_management_db;
USE bank_management_db;

-- Table 1: Customers (Parent Table)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(50),
    city VARCHAR(50)
);

-- Table 2: Accounts (Child Table with Foreign Key)
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20), -- e.g., Savings, Current
    balance DECIMAL(15, 2) DEFAULT 0.00,
    opening_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table 3: Transactions
CREATE TABLE Transactions (
    tran_id INT PRIMARY KEY,
    account_id INT,
    tran_type VARCHAR(20), -- e.g., Deposit, Withdrawal
    amount DECIMAL(15, 2),
    tran_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);



CREATE DATABASE bank_management_db;
USE bank_management_db;

-- 1. Create Table (Setting up the Bank Customers)
CREATE TABLE BankAccountHolder (
    account_holder_id INT PRIMARY KEY,
    full_name VARCHAR(60),
    age INT,
    account_type VARCHAR(30) -- e.g., Savings, Current, Fixed Deposit
);

-- 2. Add Column (Adding contact information)
ALTER TABLE BankAccountHolder ADD contact_number VARCHAR(20);

-- 3. Modify Column (Increasing character limit for long names)
ALTER TABLE BankAccountHolder MODIFY full_name VARCHAR(100);

-- 4. Drop Column (Removing the account type classification)
ALTER TABLE BankAccountHolder DROP account_type;

-- 5. Truncate Table (Clearing all customer data but keeping the structure)
TRUNCATE TABLE BankAccountHolder;

-- 6. Drop Table (Deleting the entire customer database)
DROP TABLE BankAccountHolder;



-- Create Table
CREATE TABLE BankAccounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    account_type VARCHAR(50), -- e.g., Savings, Current
    balance DECIMAL(15,2)
);

-- Insert Data
INSERT INTO BankAccounts VALUES
(101, 'MD. Ripon Rahman', 'Savings', 5000.50),
(102, 'Ahsan Ahmed', 'Current', 1200.00);

-- Select (View all accounts)
SELECT * FROM BankAccounts;

-- Update (Simulating a deposit or interest add)
UPDATE BankAccounts SET balance = balance + 500 WHERE account_id = 101;

-- Delete (Closing an account)
DELETE FROM BankAccounts WHERE account_id = 102;



-- 1. Create Database
CREATE DATABASE bank_system_db;

-- Use Database
USE bank_system_db;

-- 2. Create Table (Storing Loan Information)
CREATE TABLE loan_details (
    loan_id INT, 
    customer_name VARCHAR(50), 
    loan_type VARCHAR(50), -- e.g., Home Loan, Car Loan
    loan_amount DECIMAL(10,2)
);

-- 3. Add Column (Adding the interest rate field)
ALTER TABLE loan_details ADD interest_rate DECIMAL(4,2);


CREATE TABLE bank_accounts (
    account_id INT PRIMARY KEY,
    holder_name VARCHAR(50),
    branch_code VARCHAR(10),
    balance DECIMAL(15,2)
);



-- 1. Modify Column (Increasing character limit for the account holder's name)
ALTER TABLE bank_accounts MODIFY holder_name VARCHAR(100);

-- 2. Rename Table (Changing the table name to reflect detailed records)
RENAME TABLE bank_accounts TO account_holder_details;

-- 3. Drop Column (Removing the branch_code column from the details table)
ALTER TABLE account_holder_details DROP branch_code;

-- 1. Truncate Table 
-- (This empties the data but keeps the table structure)
-- Use the table name from your previous RENAME step
TRUNCATE TABLE account_holder_details;

-- 2. Drop Table 
-- (This deletes the table completely)
DROP TABLE account_holder_details;

-- 3. Drop Database 
-- (This deletes the entire Bank System)
DROP DATABASE bank_system_db;


drop database bank_management_db;



-- 1. Create Database
CREATE DATABASE bank_management_db;
USE bank_management_db;

-- 2. Create Customer Table
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(30),
    phone_no VARCHAR(15)
);

-- 3. Create Account Table with Constraint
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_type VARCHAR(50) NOT NULL, -- e.g., Savings, Current
    balance DECIMAL(15,2)
);

-- 4. Insert Data
INSERT INTO customers VALUES
(101, 'Wahidur Rahman', 'Dhaka', '01711111111'),
(102, 'Saief Ahmed', 'Chittagong', '01822222222'),
(103, 'Hakim Khan', 'Sylhet', '01933333333');

INSERT INTO accounts VALUES
(5001, 'Savings', 25000.00),
(5002, 'Current', 12000.50);



CREATE TABLE BankAccounts (
    acc_id INT PRIMARY KEY,
    acc_name VARCHAR(60),
    account_type VARCHAR(50), -- e.g., Savings, Current, Salary
    balance DECIMAL(10,2),
    opening_date DATE
);


-- 1. Single Row Insert (Full Data)
INSERT INTO BankAccounts VALUES (101, 'Rahim', 'Savings', 30000.00, '2023-02-10');

-- 2. Insert with Column List (Partial Data)
INSERT INTO BankAccounts (acc_id, acc_name, account_type) 
VALUES (102, 'Karim', 'Current');



-- Multiple Row Insert
INSERT INTO BankAccounts (acc_id, acc_name, account_type, balance, opening_date)
VALUES
(105, 'Arif', 'Savings', 30000.00, '2023-01-15'),
(106, 'Mitu', 'Current', 45000.00, '2022-11-20'),
(103, 'Sohan', 'Fixed Deposit', 40000.00, '2023-03-10'),
(104, 'Nusrat', 'Current', 50000.00, '2021-07-05');

-- Select All (View all bank records)
SELECT * FROM BankAccounts;

-- Select Specific Columns (View only names and their account types)
SELECT acc_name, account_type FROM BankAccounts;

-- WHERE Clause (Find high-value accounts with more than 40,000)
SELECT * FROM BankAccounts WHERE balance > 40000;

-- ORDER BY (Sort accounts from highest balance to lowest)
SELECT * FROM BankAccounts ORDER BY balance DESC;

-- DISTINCT (Find all unique types of accounts offered by the bank)
SELECT DISTINCT account_type FROM BankAccounts;

-- LIMIT (View the first 2 accounts in the list)
SELECT * FROM BankAccounts LIMIT 2;


-- Update Specific Row (Update balance for a specific account ID)
UPDATE BankAccounts SET balance = 48000 WHERE acc_id = 102;

-- Update Multiple Columns (Change name and balance for a specific customer)
UPDATE BankAccounts
SET acc_name = 'Rahim Uddin', balance = 42000
WHERE acc_id = 103;

-- Conditional Update (Add 2000 as a bonus/interest to all accounts with low balance)
UPDATE BankAccounts
SET balance = balance + 2000
WHERE balance < 40000;


-- 1. Delete Specific Row (Closing a specific bank account)
DELETE FROM BankAccounts WHERE acc_id = 103;
-- 2. Delete with Condition (Removing accounts with a balance below 35,000)
DELETE FROM BankAccounts WHERE balance < 35000;
-- 3. Delete All Records (Clearing all data from the BankAccounts table)
DELETE FROM BankAccounts;


--Step 6: Constraint Example
-- Parent Table: BankCustomers
CREATE TABLE BankCustomers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(60),
    city VARCHAR(50)
);
-- Child Table: BankAccounts
CREATE TABLE BankAccounts (
    account_no INT PRIMARY KEY,
    account_type VARCHAR(50),
    customer_id INT,
    -- Establishing the link between Account and Customer
    FOREIGN KEY (customer_id) REFERENCES BankCustomers(customer_id)
);
-- 1. Valid Insert: Adding a customer and then opening their account
INSERT INTO BankCustomers VALUES (1, 'Wahidur Rahman', 'Dhaka');
INSERT INTO BankAccounts VALUES (1001, 'Savings', 1);

-- 2. Invalid Insert: Attempting to open an account for a non-existent customer (ID 99)
INSERT INTO BankAccounts VALUES (1002, 'Current', 99);


---Step 7: Aggregate Functions
-- Count total number of bank customers
SELECT COUNT(*) FROM BankCustomers;

-- Calculate the average balance across all accounts
SELECT AVG(balance) FROM BankAccounts;

-- Find the highest balance in the bank
SELECT MAX(balance) FROM BankAccounts;

-- Find the lowest balance in the bank
SELECT MIN(balance) FROM BankAccounts;


-- Step 8: GROUP BY and HAVING 
-- 1. Group accounts by type and count them
SELECT account_type, COUNT(acc_id)
FROM BankAccounts
GROUP BY account_type;

-- 2. Group by type but only show types that have more than 1 account
SELECT account_type, COUNT(acc_id)
FROM BankAccounts
GROUP BY account_type 
HAVING COUNT(acc_id) > 1;


--Step 9: JOIN Operations
-- INNER JOIN: Shows customers and their accounts
SELECT c.customer_name, a.acc_id, a.balance
FROM BankCustomers c
INNER JOIN BankAccounts a ON c.customer_id = a.customer_id;

-- LEFT JOIN: Shows all customers (even those without accounts)
SELECT c.customer_name, a.acc_id
FROM BankCustomers c
LEFT JOIN BankAccounts a ON c.customer_id = a.customer_id;



-- Step 10: FULL OUTER JOIN (Using UNION)
-- Combining LEFT and RIGHT joins to see everything from both tables

SELECT c.customer_name, a.acc_id
FROM BankCustomers c
LEFT JOIN BankAccounts a ON c.customer_id = a.customer_id

UNION

SELECT c.customer_name, a.acc_id
FROM BankCustomers c
RIGHT JOIN BankAccounts a ON c.customer_id = a.customer_id;


-- Step 11: Subqueries
-- 1. Subquery in WHERE: Find accounts with balance higher than the bank average
SELECT * FROM BankAccounts
WHERE balance > (SELECT AVG(balance) FROM BankAccounts);

-- 2. Subquery using IN: Find customers who have at least one account
SELECT * FROM BankCustomers
WHERE customer_id IN (SELECT customer_id FROM BankAccounts);

-- 3. Correlated Subquery: Find accounts with a balance higher than the average for THAT specific account type
SELECT * FROM BankAccounts a
WHERE balance > (
    SELECT AVG(balance) 
    FROM BankAccounts 
    WHERE account_type = a.account_type
);






-- Creating a Procedure to get a customer's name based on Account ID
DELIMITER //
CREATE PROCEDURE GetCustomerNameByAcc (
    IN input_acc_id INT, 
    OUT output_name VARCHAR(60)
)
BEGIN
    SELECT acc_name INTO output_name 
    FROM BankAccounts 
    WHERE acc_id = input_acc_id;
END //
DELIMITER ;

-- Call the procedure for Account ID 101
CALL GetCustomerNameByAcc(101, @customer_name);

-- View the result
SELECT @customer_name AS 'Account Holder';

--Implementation of Database Transactions and Savepoints

-- Parent Table: Branches (Equivalent to Doctors)
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(100),
    vault_balance DECIMAL(15,2)
) ENGINE=InnoDB;

-- Parent Table: Customers (Equivalent to Patients)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    account_type VARCHAR(20)
) ENGINE=InnoDB;


-- Step 1: Create Tables
CREATE TABLE Transactions (
    trans_id INT PRIMARY KEY,
    acc_id INT,
    trans_type VARCHAR(20), -- Deposit/Withdrawal
    amount DECIMAL(10,2),
    trans_date DATE
) ENGINE=InnoDB;

CREATE TABLE ServiceCharges (
    charge_id INT PRIMARY KEY,
    trans_id INT,
    fee_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (trans_id) REFERENCES Transactions(trans_id)
) ENGINE=InnoDB;

-- Step 3: Transaction with Savepoint
START TRANSACTION;

-- Register a new transaction
INSERT INTO Transactions VALUES (501, 101, 'Withdrawal', 5000.00, '2026-04-25');

-- Create Savepoint
SAVEPOINT after_trans;

-- Attempt to apply service charge
INSERT INTO ServiceCharges VALUES (901, 501, 50.00, 'Pending');

-- Simulate Error (Duplicate ID 901)
INSERT INTO ServiceCharges VALUES (901, 501, 50.00, 'Pending');

-- Rollback only the failed service charge
ROLLBACK TO after_trans;

-- Finalize the main transaction
UPDATE Transactions SET trans_type = 'Withdrawal_Completed' WHERE trans_id = 501;

COMMIT;





--Exercise 2: Bank Analytics Dashboard (Views)
-- (a) Customer Total Balance View
CREATE VIEW view_customer_wealth AS
SELECT c.customer_name, c.city, 
COUNT(a.acc_id) AS total_accounts, SUM(a.balance) AS total_balance
FROM BankCustomers c
JOIN BankAccounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id;

-- (b) Account Type Revenue (from service charges)
CREATE VIEW view_account_type_stats AS
SELECT account_type, AVG(balance) AS average_holding
FROM BankAccounts
GROUP BY account_type;

-- (c) Low Balance Alerts
CREATE VIEW view_low_balance_alerts AS
SELECT acc_id, acc_name, balance
FROM BankAccounts
WHERE balance < 500.00;

-- (d) Monthly Bank Growth
CREATE VIEW view_monthly_deposits AS
SELECT YEAR(opening_date) AS year, MONTH(opening_date) AS month, 
COUNT(acc_id) AS new_accounts
FROM BankAccounts
GROUP BY YEAR(opening_date), MONTH(opening_date);


-- Exercise 3: Loan Processing System (Views + Transaction)
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(50),
    loan_amount DECIMAL(15,2)
) ENGINE=InnoDB;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    loan_id INT,
    payment_status VARCHAR(20),
    amount DECIMAL(15,2),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
) ENGINE=InnoDB;
START TRANSACTION;

-- Record Loan Disbursement
INSERT INTO Loans VALUES (701, 1, 'Home Loan', 500000);
INSERT INTO Loans VALUES (702, 1, 'Car Loan', 200000);

-- Create the bookmark
SAVEPOINT after_loans;

-- Record first installment (This will work)
INSERT INTO Payments VALUES (801, 701, 'Paid', 5000);

-- Record second installment (This will FAIL due to duplicate ID 801)
-- Note: MariaDB will show an error here, which is what we want to simulate!
INSERT INTO Payments VALUES (801, 702, 'Unpaid', 2000);

-- Rollback ONLY the failed payments, keeping the Loans safe
ROLLBACK TO after_loans;

-- Finalize
COMMIT;

SHOW TABLES;