-- Step 1: Create Database
CREATE DATABASE GoldenBasket;
USE GoldenBasket;

-- Step 2: Create Tables

CREATE TABLE Customers (
    Customer_ID CHAR(6) PRIMARY KEY,
    Name VARCHAR(20),
    Phone_Number VARCHAR(15),
    Gender CHAR(1),
    CHECK (Customer_ID LIKE 'CU____'),
    CHECK (Gender IN ('M','F'))
);

CREATE TABLE Products (
    Product_ID CHAR(6) PRIMARY KEY,
    Product_Name VARCHAR(20),
    Price FLOAT,
    Quantity_available INT,
    CHECK (Product_ID LIKE 'PR____')
);

CREATE TABLE Purchases (
    Purchase_ID INT PRIMARY KEY,
    Customer_ID CHAR(6),
    Product_ID CHAR(6),
    Enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Step 3: Insert Data

INSERT INTO Customers VALUES
('CU0001', 'Rahim', '01711111111', 'M'),
('CU0002', 'Karim', '01822222222', 'M'),
('CU0003', 'Ayesha', '01933333333', 'F');

INSERT INTO Products VALUES
('PR0001', 'Laptop', 70000, 10),
('PR0002', 'Mouse', 500, 50),
('PR0003', 'Keyboard', 1500, 30);

INSERT INTO Purchases (Purchase_ID, Customer_ID, Product_ID) VALUES
(1, 'CU0001', 'PR0001'),
(2, 'CU0002', 'PR0002'),
(3, 'CU0003', 'PR0003');

-- Step 4: Update phone number
UPDATE Customers
SET Phone_Number = '01699999999'
WHERE Customer_ID = 'CU0001';

-- Step 5: Trigger to reduce Quantity_available after purchase

DELIMITER $$

CREATE TRIGGER update_quantity
AFTER INSERT ON Purchases
FOR EACH ROW
BEGIN
    UPDATE Products
    SET Quantity_available = Quantity_available - 1
    WHERE Product_ID = NEW.Product_ID;
END $$

DELIMITER ;
