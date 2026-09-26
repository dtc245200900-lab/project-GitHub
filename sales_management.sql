-- ============================================
-- CSDL QUẢN LÝ BÁN HÀNG
-- ============================================

-- 1. THÊM DỮ LIỆU

INSERT INTO Customer (cID, Name, cAge)
VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice)
VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice)
VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(2, 3, 8),
(2, 5, 4),
(3, 2, 3);


-- ============================================
-- 2. HIỂN THỊ TẤT CẢ HÓA ĐƠN
-- ============================================

SELECT
    oID,
    oDate,
    oTotalPrice AS oPrice
FROM `Order`;


-- ============================================
-- 3. KHÁCH HÀNG ĐÃ MUA HÀNG
-- VÀ SẢN PHẨM ĐƯỢC MUA
-- ============================================

SELECT
    c.Name AS CustomerName,
    p.pName AS ProductName
FROM Customer c
JOIN `Order` o
    ON c.cID = o.cID
JOIN OrderDetail od
    ON o.oID = od.oID
JOIN Product p
    ON od.pID = p.pID;


-- ============================================
-- 4. KHÁCH HÀNG CHƯA MUA SẢN PHẨM NÀO
-- ============================================

SELECT
    c.Name AS CustomerName
FROM Customer c
LEFT JOIN `Order` o
    ON c.cID = o.cID
WHERE o.oID IS NULL;


-- ============================================
-- 5. TÍNH GIÁ TIỀN TỪNG HÓA ĐƠN
-- Giá = SUM(odQTY * pPrice)
-- ============================================

SELECT
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS oPrice
FROM `Order` o
JOIN OrderDetail od
    ON o.oID = od.oID
JOIN Product p
    ON od.pID = p.pID
GROUP BY
    o.oID,
    o.oDate
ORDER BY
    o.oID;