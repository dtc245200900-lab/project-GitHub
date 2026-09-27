# Thực hành chỉ mục trong MySQL

## 1. Mục tiêu

- Thực hành tạo Index trong MySQL.
- Sử dụng EXPLAIN để kiểm tra cách MySQL thực hiện truy vấn.
- So sánh truy vấn trước và sau khi tạo Index.
- Thực hành tạo Index trên một cột và nhiều cột.

## 2. Cơ sở dữ liệu

Sử dụng cơ sở dữ liệu `classicmodels`.

Bảng thực hành:

- customers

## 3. Kiểm tra trước khi tạo Index

Truy vấn:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';