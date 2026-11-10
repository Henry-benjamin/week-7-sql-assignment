-- ==========================================
-- Week 7 Assignment: Database Design and Normalization
-- Student: Henry Benjamin
-- ==========================================


-- ==========================================
-- Question 1: Achieving First Normal Form (1NF)
-- ==========================================
-- To satisfy 1NF, we must eliminate repeating groups/multi-valued attributes 
-- by ensuring that each column contains atomic (indivisible) values and 
-- each row represents a single unique fact (one product per order).

-- Step 1: Create the normalized table structure
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert the normalized records (splitting multi-valued cells into individual rows)
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');



-- ==========================================
-- Question 2: Achieving Second Normal Form (2NF)
-- ==========================================
-- To satisfy 2NF, the table must be in 1NF and all non-key attributes must be 
-- fully functional dependent on the primary key. We remove the partial dependency 
-- where CustomerName depends only on OrderID (part of the composite key) by splitting 
-- the data into an Orders table and an OrderItems table.

-- Step 1: Create the Orders table (removes partial dependency: CustomerName depends only on OrderID)
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create the OrderItems table (depends on the full composite key: OrderID, Product)
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Step 3: Insert parent records into the Orders table
INSERT INTO Orders_2NF (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert child records into the OrderItems table
INSERT INTO OrderItems_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);