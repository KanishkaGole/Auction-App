-- Use the AuctionDB database
USE AuctionDB;

-- Step 1: Update Data (DML)
UPDATE Products SET Starting_Price = 175.00 WHERE Product_ID = 'P001';
SELECT * FROM Products WHERE Product_ID = 'P001';

-- Step 2: Delete Data (DML)
DELETE FROM Bids WHERE Bid_ID = 'B000001';
SELECT * FROM Bids;

-- Step 3: Filtering Table Data
SELECT * FROM Users WHERE Address LIKE '%NY%';
SELECT * FROM Products WHERE Starting_Price > 100;

-- Step 4: Sorting Data in Table
SELECT * FROM Products ORDER BY Starting_Price DESC;

-- Step 5: Distinct Command
SELECT DISTINCT Category FROM Products;

-- Step 6: Adding and Dropping NOT NULL Constraint
ALTER TABLE Users MODIFY Phone VARCHAR(15) NOT NULL;
DESCRIBE Users;
ALTER TABLE Users MODIFY Phone VARCHAR(15) NULL;
DESCRIBE Users;

-- Step 7: CHECK Constraint
ALTER TABLE Products ADD CHECK (Starting_Price >= 50);
SHOW CREATE TABLE Products;

-- Step 8: Default Constraint
ALTER TABLE Users MODIFY Payment_Method VARCHAR(255) DEFAULT 'Credit Card';
SHOW CREATE TABLE Users;

-- Step 9: Logical Operators
SELECT * FROM Users WHERE Address = 'NY' AND Phone IS NOT NULL;
SELECT * FROM Users WHERE Address = 'NY' OR Address = 'LA';

-- Step 10: Arithmetic Operators
SELECT Product_Name, Starting_Price, Starting_Price * 1.2 AS Final_Price FROM Products;

-- Step 11: Range Searching (Between Operator)
SELECT * FROM Products WHERE Starting_Price BETWEEN 100 AND 500;

-- Step 12: IN Operator
SELECT * FROM Users WHERE Username IN ('JohnDoe', 'JaneSmith');

-- Step 13: Set Operations
SELECT Username FROM Users UNION SELECT Username FROM Users WHERE Address = 'NY';
SELECT Username FROM Users INTERSECT SELECT Username FROM Users WHERE Address = 'NY';
SELECT Username FROM Users MINUS SELECT Username FROM Users WHERE Address = 'NY';

-- Step 14: GROUP BY Clause
SELECT Address, COUNT(*) AS User_Count FROM Users GROUP BY Address;

-- Step 15: Joins
SELECT U.Username, P.Product_Name, P.Starting_Price 
FROM Users U INNER JOIN Products P ON U.User_ID = P.Seller_ID;

-- Step 16: Subqueries
SELECT Username FROM Users WHERE User_ID IN (SELECT Seller_ID FROM Products WHERE Starting_Price > 200);

-- Step 17: Views
CREATE VIEW AuctionedProducts AS 
SELECT P.Product_ID, P.Product_Name, A.Status FROM Products P
JOIN Auctions A ON P.Product_ID = A.Product_ID;
SELECT * FROM AuctionedProducts;

-- Step 18: Transactions
START TRANSACTION;
UPDATE Products SET Starting_Price = 300 WHERE Product_ID = 'P002';
SELECT * FROM Products WHERE Product_ID = 'P002';
ROLLBACK;
SELECT * FROM Products WHERE Product_ID = 'P002';

-- Step 19: Truncate, Drop, Rename
TRUNCATE TABLE Bids;
SELECT * FROM Bids;
DROP TABLE Auctions;
SHOW TABLES;
RENAME TABLE Users TO Customers;
SHOW TABLES;
