USE classicmodels;

-- =========================================
-- 1. Procedure lấy tất cả khách hàng
-- =========================================

DROP PROCEDURE IF EXISTS findAllCustomers;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END //

DELIMITER ;

CALL findAllCustomers();


-- =========================================
-- 2. Procedure tìm khách hàng theo ID
-- =========================================

DROP PROCEDURE IF EXISTS findCustomerById;

DELIMITER //

CREATE PROCEDURE findCustomerById(IN p_customerNumber INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = p_customerNumber;
END //

DELIMITER ;

CALL findCustomerById(175);


-- =========================================
-- 3. Procedure tìm khách hàng theo quốc gia
-- =========================================

DROP PROCEDURE IF EXISTS findCustomersByCountry;

DELIMITER //

CREATE PROCEDURE findCustomersByCountry(IN p_country VARCHAR(50))
BEGIN
    SELECT
        customerNumber,
        customerName,
        contactLastName,
        contactFirstName,
        phone,
        city,
        country
    FROM customers
    WHERE country = p_country;
END //

DELIMITER ;

CALL findCustomersByCountry('USA');