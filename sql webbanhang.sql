CREATE DATABASE OnlineStore;
GO
USE [ĐĂNG NHẠP];
GO
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Role NVARCHAR(50) DEFAULT 'Customer',
    CreatedAt DATETIME DEFAULT GETDATE()
);
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Price DECIMAL(18, 2) NOT NULL,
    Stock INT DEFAULT 0,
    Description NVARCHAR(255),
    ImageURL NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2) NOT NULL,
    ShippingAddress NVARCHAR(255),
    OrderStatus NVARCHAR(50) DEFAULT 'Pending'
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18, 2) NOT NULL
);
-- Thêm danh mục
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Apparel and accessories'),
('Books', 'Printed and digital books');

-- Thêm sản phẩm
INSERT INTO Products (ProductName, CategoryID, Price, Stock, Description, ImageURL) VALUES
('Smartphone XYZ', 1, 599.99, 50, 'Latest smartphone with advanced features', '/images/xyz.jpg'),
('Jeans ABC', 2, 49.99, 100, 'Comfortable and stylish jeans', '/images/abc-jeans.jpg'),
('Novel DEF', 3, 19.99, 200, 'A thrilling mystery novel', '/images/def-novel.jpg');

-- Thêm người dùng
INSERT INTO Users (UserName, Email, PasswordHash, PhoneNumber, Role) VALUES
('john_doe', 'john@example.com', 'hashedpassword123', '123-456-7890', 'Customer'),
('admin_user', 'admin@example.com', 'hashedpasswordadmin', '987-654-3210', 'Admin');

-- Thêm đơn hàng và chi tiết đơn hàng
INSERT INTO Orders (UserID, TotalAmount, ShippingAddress, OrderStatus) VALUES
(1, 669.97, '123 Main St, Cityville', 'Pending');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 599.99), -- Smartphone XYZ
(1, 2, 2, 49.99);  -- Jeans ABC
CREATE INDEX IDX_Products_CategoryID ON Products (CategoryID);
CREATE INDEX IDX_Orders_UserID ON Orders (UserID);
CREATE INDEX IDX_OrderDetails_OrderID ON OrderDetails (OrderID);