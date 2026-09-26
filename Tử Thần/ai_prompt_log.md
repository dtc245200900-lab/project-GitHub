# AI Prompt Log – PayFlow Index & SARGable

## Prompt 1: Non-SARGable

**Câu hỏi:**

Trong MySQL, nếu tạo Index cho cột ngày tháng nhưng trong WHERE sử dụng `YEAR(created_at) = 2026` thì tại sao Index khó được sử dụng hiệu quả?

**Kết quả tìm hiểu:**

Khi áp dụng hàm lên cột trong điều kiện WHERE, hệ quản trị phải tính toán giá trị của hàm trước khi so sánh. Điều này làm giảm khả năng sử dụng trực tiếp cấu trúc B-Tree Index để tìm kiếm theo khoảng giá trị.

---

## Prompt 2: SARGable

**Câu hỏi:**

SARGable trong SQL có nghĩa là gì?

**Kết quả tìm hiểu:**

SARGable là điều kiện truy vấn được viết theo cách cho phép Database sử dụng Index để tìm kiếm hiệu quả. Ví dụ, thay vì dùng `YEAR(created_at) = 2026`, có thể dùng điều kiện khoảng:

`created_at >= '2026-01-01' AND created_at < '2027-01-01'`.

---

## Prompt 3: Composite Index

**Câu hỏi:**

Thứ tự các cột trong Composite Index `(transaction_type, created_at)` có quan trọng không?

**Kết quả tìm hiểu:**

Có. MySQL sử dụng Composite Index theo thứ tự các cột trong Index. Với truy vấn này, `transaction_type` được đặt trước và `created_at` đứng sau để phục vụ đồng thời điều kiện loại giao dịch và khoảng thời gian.

---

## Prompt 4: EXPLAIN

**Câu hỏi:**

Các giá trị `ALL`, `range`, `ref` trong cột type của EXPLAIN có ý nghĩa gì?

**Kết quả tìm hiểu:**

`ALL` thường biểu thị Full Table Scan. `range` cho biết MySQL tìm kiếm một khoảng giá trị trên Index. `ref` thường biểu thị việc sử dụng Index để tìm các dòng có giá trị khớp với một giá trị tham chiếu.

---

## Prompt 5: Index và dữ liệu thay đổi

**Câu hỏi:**

Việc tạo nhiều Index trên bảng có nhiều INSERT, UPDATE, DELETE gây ảnh hưởng gì?

**Kết quả tìm hiểu:**

Index giúp SELECT nhanh hơn nhưng mỗi khi dữ liệu thay đổi, Database cũng phải cập nhật các Index liên quan. Quá nhiều Index có thể làm tăng chi phí ghi dữ liệu, sử dụng thêm bộ nhớ và dung lượng lưu trữ.
