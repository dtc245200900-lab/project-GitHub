-- ============================================
-- HỆ THỐNG PAYFLOW
-- TỐI ƯU TRUY VẤN BẰNG EXPLAIN VÀ INDEX
-- ============================================

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- ============================================
-- 1. TẠO BẢNG TRANSACTIONS
-- ============================================

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- ============================================
-- 2. EXPLAIN TRUY VẤN CŨ
-- Non-SARGable do sử dụng YEAR() và MONTH()
-- ============================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;


-- ============================================
-- 3. TẠO COMPOSITE INDEX
-- ============================================

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);


-- ============================================
-- 4. TRUY VẤN ĐÃ TỐI ƯU
-- Sử dụng điều kiện khoảng thời gian SARGable
-- ============================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';


-- ============================================
-- 5. CHẠY TRUY VẤN THỰC TẾ
-- ============================================

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';