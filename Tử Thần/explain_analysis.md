# Phân tích EXPLAIN trước và sau tối ưu

Truy vấn ban đầu sử dụng `YEAR(created_at)` và `MONTH(created_at)` trong điều kiện WHERE. Đây là dạng Non-SARGable vì MySQL phải áp dụng hàm lên từng giá trị của cột trước khi kiểm tra điều kiện. Do đó Index trên `created_at` khó được sử dụng hiệu quả và có thể dẫn đến Full Table Scan với `type = ALL`.

Để tối ưu, tôi tạo Composite Index:

`idx_type_date(transaction_type, created_at)`

Sau đó thay điều kiện YEAR() và MONTH() bằng khoảng thời gian:

`created_at >= '2026-06-01' AND created_at < '2026-07-01'`

Điều kiện này có dạng SARGable, cho phép MySQL tìm kiếm trực tiếp trên Index. Khi chạy EXPLAIN, kế hoạch mới có thể sử dụng `idx_type_date`, với `type` thường là `range` hoặc một kế hoạch truy cập phù hợp khác tùy dữ liệu và phiên bản MySQL.

Cột `rows` sau tối ưu được kỳ vọng giảm đáng kể so với truy vấn quét toàn bảng. Giá trị thực tế phụ thuộc vào số lượng dữ liệu và độ phân bố của các giao dịch.
