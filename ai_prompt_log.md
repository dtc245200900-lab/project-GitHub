# AI PROMPT LOG – QUICKFEED INDEX OPTIMIZATION

## Prompt 1 – Tìm hiểu dung lượng Data và Index

**Prompt:**

Trong MySQL, hãy hướng dẫn cách truy vấn bảng `information_schema.TABLES` để xem kích thước Data và Index của bảng `Posts` theo đơn vị MB. Giải thích ý nghĩa của `DATA_LENGTH` và `INDEX_LENGTH`.

**Kiến thức rút ra:**

`DATA_LENGTH` biểu thị dung lượng dữ liệu của bảng, còn `INDEX_LENGTH` biểu thị dung lượng dành cho các Index. Có thể chia cho `1024 * 1024` để chuyển sang MB.

---

## Prompt 2 – Tìm hiểu Cardinality

**Prompt:**

Cardinality trong MySQL là gì? Tại sao cột chỉ có hai giá trị như BOOLEAN 0/1 thường không phải là ứng viên tốt cho B-Tree Index?

**Kiến thức rút ra:**

Cardinality thể hiện mức độ đa dạng của giá trị trong một cột. Cột chỉ có 0 và 1 có Cardinality rất thấp. Nếu một giá trị xuất hiện trong phần lớn số dòng, việc sử dụng Index có thể không giúp giảm đáng kể số dòng phải đọc. MySQL có thể chọn Full Table Scan.

---

## Prompt 3 – Index trên TEXT

**Prompt:**

Nếu tạo B-Tree Index trên cột TEXT bằng prefix 255 ký tự thì có những chi phí nào về Storage và Write? Nếu cần tìm kiếm từ khóa trong nội dung thì có thể dùng cơ chế nào?

**Kiến thức rút ra:**

Index trên prefix dài của TEXT có thể làm tăng kích thước Index. Index cũng phải được duy trì khi dữ liệu được INSERT hoặc UPDATE. Với nhu cầu tìm kiếm văn bản, FULLTEXT Index là một cơ chế cần nghiên cứu thay vì dùng B-Tree prefix Index cho mọi mục đích.

---

## Prompt 4 – Trade-off giữa Read và Write

**Prompt:**

Tại sao nhiều Index có thể làm SELECT nhanh hơn nhưng INSERT, UPDATE và DELETE chậm hơn?

**Kiến thức rút ra:**

Index giúp MySQL tìm dữ liệu hiệu quả hơn trong những truy vấn phù hợp. Tuy nhiên khi dữ liệu thay đổi, các Index liên quan cũng phải được cập nhật. Vì vậy Index tạo ra sự đánh đổi giữa tốc độ đọc, tốc độ ghi và dung lượng lưu trữ.

---

## Prompt 5 – InnoDB và lưu trữ

**Prompt:**

Trong InnoDB, khi INSERT một bản ghi vào bảng có nhiều secondary Index thì hệ quản trị phải thực hiện những công việc gì ở mức khái niệm?

**Kiến thức rút ra:**

Ngoài việc ghi bản ghi vào cấu trúc dữ liệu của bảng, InnoDB phải duy trì các secondary Index liên quan. Quá trình này có thể yêu cầu tìm vị trí thích hợp trong cấu trúc Index, thay đổi các page và trong một số trường hợp có thể phát sinh page split hoặc I/O bổ sung.

---

## Quyết định cuối cùng

- Giữ `idx_user_id`.
- Xóa `idx_content`.
- Xóa `idx_post_type`.
- Xóa `idx_is_visible`.
- Giữ `idx_created_at`.

AI được sử dụng để giải thích khái niệm và hỗ trợ phân tích. Các lệnh DROP INDEX được lựa chọn dựa trên yêu cầu của bài thực hành và phân tích Cardinality/Storage.
