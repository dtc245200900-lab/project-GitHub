-- =========================================
-- BÀI THỰC HÀNH: TRIGGER TRONG MYSQL
-- =========================================

-- Xóa database cũ nếu đã tồn tại
DROP DATABASE IF EXISTS company;

-- Tạo database
CREATE DATABASE company;

-- Sử dụng database
USE company;


-- =========================================
-- 1. TẠO BẢNG EMPLOYEES
-- =========================================

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);


-- =========================================
-- 2. TẠO TRIGGER
-- Tự động xác định phòng ban dựa vào salary
-- =========================================

DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';

    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';

    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;


-- =========================================
-- 3. THÊM DỮ LIỆU
-- =========================================

INSERT INTO employees (name, department, salary)
VALUES
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);


-- =========================================
-- 4. KIỂM TRA KẾT QUẢ
-- =========================================

SELECT * FROM employees;