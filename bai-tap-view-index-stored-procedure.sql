CREATE DATABASE demo_product;
USE demo_product;

-- =========================================
-- 1. CREATE TABLE
-- =========================================

CREATE TABLE Products (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription VARCHAR(255),
    productStatus VARCHAR(50)
);

-- =========================================
-- 2. INSERT DATA
-- =========================================

INSERT INTO Products
(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('SP001', 'Laptop Dell', 15000000, 10, 'Laptop Dell Inspiron', 'Còn hàng'),
('SP002', 'Laptop HP', 14000000, 15, 'Laptop HP Pavilion', 'Còn hàng'),
('SP003', 'MacBook Air', 22000000, 8, 'MacBook Air M2', 'Còn hàng'),
('SP004', 'iPhone 15', 20000000, 20, 'Điện thoại iPhone 15', 'Còn hàng'),
('SP005', 'Samsung Galaxy S24', 18000000, 12, 'Điện thoại Samsung Galaxy S24', 'Còn hàng'),
('SP006', 'iPad Air', 16000000, 7, 'Máy tính bảng iPad Air', 'Còn hàng'),
('SP007', 'AirPods Pro', 6000000, 25, 'Tai nghe AirPods Pro', 'Còn hàng'),
('SP008', 'Chuột Logitech', 500000, 50, 'Chuột không dây Logitech', 'Còn hàng'),
('SP009', 'Bàn phím cơ', 1200000, 30, 'Bàn phím cơ gaming', 'Còn hàng'),
('SP010', 'Màn hình Samsung', 5000000, 18, 'Màn hình Samsung 24 inch', 'Còn hàng');

-- =========================================
-- 3. UNIQUE INDEX
-- =========================================

CREATE UNIQUE INDEX idx_product_code
ON Products(productCode);

-- =========================================
-- 4. COMPOSITE INDEX
-- =========================================

CREATE INDEX idx_product_name_price
ON Products(productName, productPrice);

-- =========================================
-- 5. EXPLAIN
-- =========================================

EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
AND productPrice = 15000000;

-- =========================================
-- 6. VIEW
-- =========================================

CREATE VIEW view_products AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;

-- Xem View
SELECT * FROM view_products;

-- =========================================
-- 7. MODIFY VIEW
-- =========================================

CREATE OR REPLACE VIEW view_products AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus,
    productAmount
FROM Products;

-- Kiểm tra View sau khi sửa
SELECT * FROM view_products;

-- =========================================
-- 8. STORED PROCEDURE - GET ALL
-- =========================================

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //

DELIMITER ;

-- Test
CALL GetAllProducts();

-- =========================================
-- 9. STORED PROCEDURE - ADD
-- =========================================

DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    INSERT INTO Products
    (
        productCode,
        productName,
        productPrice,
        productAmount,
        productDescription,
        productStatus
    )
    VALUES
    (
        p_productCode,
        p_productName,
        p_productPrice,
        p_productAmount,
        p_productDescription,
        p_productStatus
    );
END //

DELIMITER ;

-- Test
CALL AddProduct(
    'SP011',
    'Sony Headphone',
    3000000,
    10,
    'Tai nghe Sony',
    'Còn hàng'
);

-- =========================================
-- 10. STORED PROCEDURE - UPDATE
-- =========================================

DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_id;
END //

DELIMITER ;

-- Test
CALL UpdateProduct(
    1,
    'SP001',
    'Laptop Dell Updated',
    15500000,
    20,
    'Laptop Dell phiên bản mới',
    'Còn hàng'
);

-- =========================================
-- 11. STORED PROCEDURE - DELETE
-- =========================================

DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_id INT
)
BEGIN
    DELETE FROM Products
    WHERE Id = p_id;
END //

DELIMITER ;

-- Test
CALL DeleteProduct(11);

-- =========================================
-- 12. CHECK
-- =========================================

SELECT * FROM Products;

SHOW INDEX FROM Products;

SHOW PROCEDURE STATUS
WHERE Db = 'demo_product';

-- =========================================
-- 13. DELETE VIEW
-- =========================================

DROP VIEW view_products;