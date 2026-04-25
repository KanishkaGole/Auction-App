-- Create Database
CREATE DATABASE AuctionDB;
USE AuctionDB;

-- Admin Table
CREATE TABLE Admin (
    Admin_ID CHAR(9) PRIMARY KEY,
    A_Name VARCHAR(100) NOT NULL,
    A_Email VARCHAR(255) UNIQUE NOT NULL,
    A_Password VARCHAR(255) NOT NULL
);

-- Users Table
CREATE TABLE Users (
    User_ID CHAR(4) PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    Registration_Date DATE NOT NULL,
    Payment_ID CHAR(8),
    Payment_Method VARCHAR(255)
);

-- Products Table
CREATE TABLE Products (
    Product_ID CHAR(5) PRIMARY KEY,
    Seller_ID CHAR(4),
    Product_Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Starting_Price DECIMAL(10,2) NOT NULL,
    Category ENUM('antique', 'premium') NOT NULL,
    Image_file VARCHAR(255),
    Product_Registeration_Date DATE NOT NULL,
    FOREIGN KEY (Seller_ID) REFERENCES Users(User_ID)
);

-- Auctions Table
CREATE TABLE Auctions (
    Auction_ID CHAR(6) PRIMARY KEY,
    Product_ID CHAR(5),
    Winner_Bidder_ID CHAR(4),
    Winner_Bid_ID CHAR(7),
    Winning_Bid_Amount DECIMAL(10,2),
    Status ENUM('Sold', 'Not Sold') DEFAULT 'Not Sold',
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Winner_Bidder_ID) REFERENCES Users(User_ID)
);

-- Bids Table
CREATE TABLE Bids (
    Auction_ID CHAR(6),
    Product_ID CHAR(5),
    Bidder_ID CHAR(4),
    Bid_ID CHAR(7) PRIMARY KEY,
    Bid_Amount DECIMAL(10,2) NOT NULL,
    Bid_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Auction_ID) REFERENCES Auctions(Auction_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Bidder_ID) REFERENCES Users(User_ID)
);

-- Payments Table
CREATE TABLE Payments (
    Payment_ID CHAR(8) PRIMARY KEY,
    Auction_ID CHAR(6),
    Product_ID CHAR(5),
    Winner_Bidder_ID CHAR(4),
    Winner_Bid_ID CHAR(7),
    Winning_Bid_Amount DECIMAL(10,2),
    Payment_Method VARCHAR(255),
    Payment_Status ENUM('Done', 'Not Done') DEFAULT 'Not Done',
    FOREIGN KEY (Auction_ID) REFERENCES Auctions(Auction_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Winner_Bidder_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Winner_Bid_ID) REFERENCES Bids(Bid_ID)
);

-- Transaction History Table
CREATE TABLE Transaction_History (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Payment_Method VARCHAR(255),
    Auction_ID CHAR(6),
    Buyer_ID CHAR(4),
    Seller_ID CHAR(4),
    Product_ID CHAR(5),
    Final_Price DECIMAL(10,2),
    Transaction_Date DATE,
    FOREIGN KEY (Auction_ID) REFERENCES Auctions(Auction_ID),
    FOREIGN KEY (Buyer_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Insert into Admin Table
INSERT INTO Admin VALUES 
('ADMIN0001', 'Admin1', 'admin1@example.com', 'password1'),
('ADMIN0002', 'Admin2', 'admin2@example.com', 'password2'),
('ADMIN0003', 'Admin3', 'admin3@example.com', 'password3'),
('ADMIN0004', 'Admin4', 'admin4@example.com', 'password4'),
('ADMIN0005', 'Admin5', 'admin5@example.com', 'password5');

-- Insert into Users Table
INSERT INTO Users VALUES 
('U001', 'JohnDoe', 'johndoe@example.com', 'pass123', '1234567890', 'NY', '2025-03-10', NULL, NULL),
('U002', 'JaneSmith', 'janesmith@example.com', 'pass456', '0987654321', 'LA', '2025-03-10', NULL, NULL),
('U003', 'AliceBrown', 'alicebrown@example.com', 'pass789', '1122334455', 'SF', '2025-03-10', NULL, NULL),
('U004', 'BobWhite', 'bobwhite@example.com', 'pass101', '5566778899', 'TX', '2025-03-10', NULL, NULL),
('U005', 'CharlieGreen', 'charliegreen@example.com', 'pass202', '6677889900', 'MI', '2025-03-10', NULL, NULL);

-- Insert into Products Table
INSERT INTO Products VALUES 
('P001', 'U001', 'Vintage Clock', 'Antique clock from 1800s', 150.00, 'antique', 'clock.jpg', '2025-03-10'),
('P002', 'U002', 'Luxury Watch', 'Swiss watch', 500.00, 'premium', 'watch.jpg', '2025-03-10'),
('P003', 'U003', 'Gold Ring', 'Handcrafted gold ring', 250.00, 'premium', 'ring.jpg', '2025-03-10'),
('P004', 'U004', 'Antique Vase', 'Rare ceramic vase', 300.00, 'antique', 'vase.jpg', '2025-03-10'),
('P005', 'U005', 'Old Painting', '17th century painting', 700.00, 'antique', 'painting.jpg', '2025-03-10');

-- Insert into Auctions Table
INSERT INTO Auctions VALUES 
('A00001', 'P001', 'U003', 'B000002', 250.00, 'Sold'),
('A00002', 'P002', 'U005', 'B000004', 600.00, 'Sold'),
('A00003', 'P003', NULL, NULL, NULL, 'Not Sold'),
('A00004', 'P004', NULL, NULL, NULL, 'Not Sold'),
('A00005', 'P005', NULL, NULL, NULL, 'Not Sold');

-- Insert into Bids Table
INSERT INTO Bids VALUES 
('A00001', 'P001', 'U002', 'B000001', 200.00, '2025-03-10 10:15:30'),
('A00001', 'P001', 'U003', 'B000002', 250.00, '2025-03-10 11:00:45'),
('A00002', 'P002', 'U004', 'B000003', 550.00, '2025-03-11 09:30:20'),
('A00002', 'P002', 'U005', 'B000004', 600.00, '2025-03-11 10:45:15'),
('A00003', 'P003', 'U001', 'B000005', 280.00, '2025-03-12 14:20:00');

-- Insert into Transaction History Table
INSERT INTO Transaction_History (Payment_Method, Auction_ID, Buyer_ID, Seller_ID, Product_ID, Final_Price, Transaction_Date) VALUES 
('Credit Card', 'A00001', 'U003', 'U001', 'P001', 250.00 * 1.2, '2025-03-10'),
('PayPal', 'A00002', 'U005', 'U002', 'P002', 600.00 * 1.2, '2025-03-11'),
('Bank Transfer', 'A00003', 'U001', 'U003', 'P003', NULL, '2025-03-12'),
('Credit Card', 'A00004', 'U004', 'U004', 'P004', NULL, '2025-03-13'),
('PayPal', 'A00005', 'U005', 'U005', 'P005', NULL, '2025-03-14');
