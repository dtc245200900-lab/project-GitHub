USE classicmodels;

-- Kiểm tra dữ liệu
SELECT * FROM customers;

-- EXPLAIN trước khi tạo INDEX
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Tạo INDEX cho customerName
ALTER TABLE customers
ADD INDEX idx_customerName(customerName);

-- Kiểm tra INDEX
SHOW INDEX FROM customers;

-- EXPLAIN sau khi tạo INDEX
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Tạo INDEX nhiều cột
ALTER TABLE customers
ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- EXPLAIN với INDEX nhiều cột
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';

-- Xóa INDEX
ALTER TABLE customers
DROP INDEX idx_full_name;

-- Xóa INDEX customerName nếu cần
-- ALTER TABLE customers DROP INDEX idx_customerName;