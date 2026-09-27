USE classicmodels;

-- =========================================
-- BÀI THỰC HÀNH: TRUYỀN THAM SỐ VÀO
-- STORED PROCEDURE
-- =========================================


-- =========================================
-- 1. THAM SỐ IN
-- Tìm khách hàng theo customerNumber
-- =========================================

DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Test
CALL getCusById(175);


-- =========================================
-- 2. THAM SỐ OUT
-- Đếm số khách hàng theo thành phố
-- =========================================

DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Test
CALL GetCustomersCountByCity('Lyon', @total);

SELECT @total;


-- =========================================
-- 3. THAM SỐ INOUT
-- Tăng giá trị của biến counter
-- =========================================

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Test
SET @counter = 1;

CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);

SELECT @counter;