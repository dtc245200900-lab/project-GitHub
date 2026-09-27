USE classicmodels;

-- =========================================
-- BÀI THỰC HÀNH: VIEW TRONG MYSQL
-- =========================================


-- =========================================
-- 1. TẠO VIEW
-- Lấy mã khách hàng, tên khách hàng và số điện thoại
-- =========================================

DROP VIEW IF EXISTS customer_views;

CREATE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    phone
FROM customers;


-- Kiểm tra dữ liệu trong VIEW
SELECT * FROM customer_views;


-- =========================================
-- 2. CẬP NHẬT VIEW
-- Chỉ lấy khách hàng ở thành phố Nantes
-- =========================================

CREATE OR REPLACE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';


-- Kiểm tra VIEW sau khi cập nhật
SELECT * FROM customer_views;


-- =========================================
-- 3. XÓA VIEW
-- =========================================

-- DROP VIEW customer_views;