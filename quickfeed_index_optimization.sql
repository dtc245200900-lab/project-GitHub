-- QUICKFEED - INDEX OPTIMIZATION
-- Database: quickfeed_db
-- Muc tieu: Loai bo cac Index co Cardinality thap / Storage overhead cao

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- =========================================================
-- 1. KIEM TRA DUNG LUONG TRUOC KHI TOI UU
-- =========================================================

SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- =========================================================
-- 2. KIEM TRA CAC INDEX HIEN TAI
-- =========================================================

SHOW INDEX FROM Posts;

-- =========================================================
-- 3. XOA 3 INDEX KHONG HIEU QUA
-- =========================================================
-- idx_content: TEXT(255), ton storage; khong phu hop cho tim
-- kiem van ban thong thuong.
-- idx_post_type: chi co khoang 3 gia tri -> Cardinality thap.
-- idx_is_visible: chi co 0/1 -> Cardinality rat thap.

ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- =========================================================
-- 4. KIEM TRA LAI INDEX
-- =========================================================

SHOW INDEX FROM Posts;

-- =========================================================
-- 5. KIEM TRA DUNG LUONG SAU KHI TOI UU
-- =========================================================

SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- =========================================================
-- 6. CAC INDEX DUOC GIU LAI
-- =========================================================
-- idx_user_id   : ho tro tim bai viet theo user.
-- idx_created_at: ho tro truy van/sap xep newsfeed theo thoi gian.

-- Luu y:
-- Neu can tim kiem tu khoa trong content, co the nghien cuu
-- FULLTEXT INDEX thay cho B-Tree prefix index.
