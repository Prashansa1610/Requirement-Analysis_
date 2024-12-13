
Show Databases;
Create Database Dk_Hardware;
Use Dk_hardware;
-- Create Product Table
-- 1. Users Table (Independent)

CREATE TABLE Users (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Address VARCHAR(255),
    Phone VARCHAR(15)
);

-- 2. Employees Table (Independent)
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100),
    Role VARCHAR(50) -- Example: 'Admin', 'Warehouse Staff', etc.
);

-- 3. Products Table (Independent )
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock_Quantity INT
);

-- 4. Suppliers Table (Independent)
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY AUTO_INCREMENT,
    Supplier_Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Address VARCHAR(255)
);

-- 5. Orders Table (References Users and Employees)
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT, -- Foreign Key: Links to Users (Customer)
    Employee_ID INT, -- Foreign Key: Links to Employees (Order Processor)
    Order_Date DATE,
    Total_Price DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- 6. OrderDetails Table (References Orders and Products)
CREATE TABLE OrderDetails (
    Order_Item_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT, -- Foreign Key: Links to Orders
    Product_ID INT, -- Foreign Key: Links to Products
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- 7. Payment Table (References Orders)
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT, -- Foreign Key: Links to Orders
    Amount DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- 8. Shipping Table (References Orders and Employees)
CREATE TABLE Shipping (
    Shipping_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT, -- Foreign Key: Links to Orders
    Employee_ID INT, -- Foreign Key: Links to Employees (Shipping Handler)
    ShippingCost DECIMAL(10, 2),
    ShippingDate DATE,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- 9. Purchases Table (References Suppliers, Products, and Employees)
CREATE TABLE Purchases (
    Purchase_ID INT PRIMARY KEY AUTO_INCREMENT,
    Supplier_ID INT, -- Foreign Key: Links to Suppliers
    Product_ID INT, -- Foreign Key: Links to Products
    Employee_ID INT, -- Foreign Key: Links to Employees (Purchase Handler)
    Quantity INT,
    Purchase_Price DECIMAL(10, 2),
    Purchase_Date DATE,
    FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- 10. Inventory Table (References Products and Employees)
CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_ID INT, -- Foreign Key: Links to Products
    Employee_ID INT, -- Foreign Key: Links to Employees (Inventory Manager)
    Quantity INT,
    Location VARCHAR(100),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

INSERT INTO Users (Name, Email, Address, Phone) VALUES
('John Doe', 'john.doe@example.com', '123 Elm Street, Springfield', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '456 Oak Avenue, Springfield', '234-567-8901'),
('Michael Johnson', 'michael.johnson@example.com', '789 Pine Lane, Springfield', '345-678-9012'),
('Emily Davis', 'emily.davis@example.com', '321 Maple Blvd, Springfield', '456-789-0123');

INSERT INTO Employees (First_Name, Last_Name, Email, Role) VALUES
('Alice', 'Williams', 'alice.williams@dkhardware.com', 'Admin'),
('Bob', 'Brown', 'bob.brown@dkhardware.com', 'Warehouse Staff'),
('Charlie', 'Johnson', 'charlie.johnson@dkhardware.com', 'Customer Support'),
('Dana', 'Miller', 'dana.miller@dkhardware.com', 'Shipping Coordinator');

INSERT INTO Products (Product_Name, Category, Price, Stock_Quantity) VALUES
('Hammer', 'Tools', 15.99, 50),
('Screwdriver', 'Tools', 8.49, 100),
('Drill', 'Power Tools', 199.99, 20),
('Wrench Set', 'Tools', 25.99, 30),
('LED Flashlight', 'Electronics', 12.99, 75),
('Cordless Vacuum', 'Home Appliances', 99.99, 10),
('Plumbing Pipe', 'Plumbing', 5.49, 200),
('Saw Blade', 'Tools', 19.99, 40);

INSERT INTO Suppliers (Supplier_Name, Contact_Info, Address) VALUES
('Ace Hardware', 'contact@acehardware.com', '456 Warehouse Road, Springfield'),
('Home Depot', 'support@homedepot.com', '789 Industrial Boulevard, Springfield'),
('Lowe\'s', 'service@lowes.com', '123 Construction Avenue, Springfield');

INSERT INTO Orders (Customer_ID, Employee_ID, Order_Date, Total_Price, Status) VALUES
(1, 1, '2024-12-01', 50.97, 'Shipped'),
(2, 2, '2024-12-02', 33.98, 'Pending'),
(3, 3, '2024-12-03', 199.99, 'Delivered'),
(4, 4, '2024-12-04', 120.99, 'Shipped');

INSERT INTO OrderDetails (Order_ID, Product_ID, Quantity, Price) VALUES
(1, 1, 2, 15.99),
(1, 2, 1, 8.49),
(2, 3, 1, 199.99),
(2, 4, 2, 25.99),
(3, 5, 1, 12.99),
(3, 6, 1, 99.99),
(4, 7, 3, 5.49),
(4, 8, 2, 19.99);

INSERT INTO Payment (Order_ID, Amount, Status) VALUES
(1, 50.97, 'Paid'),
(2, 33.98, 'Pending'),
(3, 199.99, 'Paid'),
(4, 120.99, 'Paid');

INSERT INTO Shipping (Order_ID, Employee_ID, ShippingCost, ShippingDate) VALUES
(1, 4, 5.00, '2024-12-02'),
(2, 4, 7.50, '2024-12-03'),
(3, 4, 10.00, '2024-12-04'),
(4, 4, 15.00, '2024-12-05');

INSERT INTO Purchases (Supplier_ID, Product_ID, Employee_ID, Quantity, Purchase_Price, Purchase_Date) VALUES
(1, 1, 2, 100, 10.00, '2024-11-01'),
(1, 2, 2, 200, 5.00, '2024-11-02'),
(2, 3, 3, 50, 180.00, '2024-11-03'),
(2, 4, 3, 100, 22.00, '2024-11-04'),
(3, 5, 1, 200, 10.00, '2024-11-05'),
(3, 6, 1, 100, 80.00, '2024-11-06');

INSERT INTO Inventory (Product_ID, Employee_ID, Quantity, Location) VALUES
(1, 2, 50, 'Warehouse A'),
(2, 2, 100, 'Warehouse B'),
(3, 3, 20, 'Warehouse C'),
(4, 3, 30, 'Warehouse A'),
(5, 1, 75, 'Warehouse B'),
(6, 1, 10, 'Warehouse C'),
(7, 2, 200, 'Warehouse A'),
(8, 3, 40, 'Warehouse B');

SELECT * FROM Users;

SELECT Product_Name, Category, Price, Stock_Quantity
FROM Products;

SELECT Orders.Order_ID, Orders.Order_Date, Orders.Total_Price, Orders.Status
FROM Orders
JOIN Users ON Orders.Customer_ID = Users.User_ID
WHERE Users.Name = 'John Doe';

UPDATE Products
SET Stock_Quantity = Stock_Quantity + 20
WHERE Product_Name = 'Hammer';

select * from Products;


-- total revenue generated by cust3w
SELECT 
    Users.Name AS Customer_Name,
    SUM(Orders.Total_Price) AS Total_Revenue
FROM Orders
JOIN Users ON Orders.Customer_ID = Users.User_ID
GROUP BY Users.User_ID;


-- Products that have been ordered most
SELECT 
    Products.Product_Name, 
    SUM(OrderDetails.Quantity) AS Total_Quantity_Sold
FROM OrderDetails
JOIN Products ON OrderDetails.Product_ID = Products.Product_ID
GROUP BY Products.Product_ID
ORDER BY Total_Quantity_Sold DESC;

-- products each supplier has provided with qty
SELECT 
    Suppliers.Supplier_Name, 
    COUNT(DISTINCT Purchases.Product_ID) AS Total_Products, 
    SUM(Purchases.Quantity) AS Total_Quantity_Provided
FROM Purchases
JOIN Suppliers ON Purchases.Supplier_ID = Suppliers.Supplier_ID
GROUP BY Suppliers.Supplier_ID;


-- order processed by each employee
SELECT 
    Employees.First_Name || ' ' || Employees.Last_Name AS Employee_Name,
    COUNT(Orders.Order_ID) AS Orders_Processed
FROM Orders
JOIN Employees ON Orders.Employee_ID = Employees.Employee_ID
GROUP BY Employees.Employee_ID;

-- products with stock level below 30
SELECT Product_Name, Stock_Quantity
FROM Products
WHERE Stock_Quantity < 30;

-- orders with pending shipment along with cust name and employee details
SELECT 
    Orders.Order_ID, 
    Users.Name AS Customer_Name, 
    Employees.First_Name AS Handled_By, 
    Shipping.ShippingCost, 
    Shipping.ShippingDate
FROM Orders
JOIN Users ON Orders.Customer_ID = Users.User_ID
JOIN Shipping ON Orders.Order_ID = Shipping.Order_ID
JOIN Employees ON Shipping.Employee_ID = Employees.Employee_ID
WHERE Orders.Status = 'Pending';


-- Total revenue for each product catregory
SELECT 
    Products.Category, 
    SUM(OrderDetails.Quantity * OrderDetails.Price) AS Total_Revenue
FROM OrderDetails
JOIN Products ON OrderDetails.Product_ID = Products.Product_ID
GROUP BY Products.Category;


-- Full order report with customer details ,product name , qty , employee handling order
SELECT 
    Orders.Order_ID, 
    Users.Name AS Customer_Name, 
    Products.Product_Name, 
    OrderDetails.Quantity, 
    OrderDetails.Price, 
    Employees.First_Name AS Employee_Name, 
    Orders.Order_Date
FROM Orders
JOIN Users ON Orders.Customer_ID = Users.User_ID
JOIN OrderDetails ON Orders.Order_ID = OrderDetails.Order_ID
JOIN Products ON OrderDetails.Product_ID = Products.Product_ID
JOIN Employees ON Orders.Employee_ID = Employees.Employee_ID;





























