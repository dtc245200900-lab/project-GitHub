# BÁO CÁO TỐI ƯU INDEX – QUICKFEED

## 1. Mục tiêu

Hệ thống QuickFeed ban đầu tạo Index trên nhiều cột của bảng `Posts`, dẫn đến tăng dung lượng lưu trữ và làm tăng chi phí khi ghi dữ liệu. Mục tiêu của bài thực hành là xác định các Index không có giá trị cao, loại bỏ chúng và so sánh dung lượng trước và sau tối ưu.

## 2. Phân tích

Bảng `Posts` ban đầu có 5 secondary Index gồm `idx_user_id`, `idx_content`, `idx_post_type`, `idx_is_visible` và `idx_created_at`.

`idx_user_id` được giữ lại vì thường được sử dụng để tìm các bài viết của một người dùng. `idx_created_at` cũng được giữ lại vì phù hợp với các truy vấn lấy bài viết theo thời gian.

Ba Index được loại bỏ là `idx_content`, `idx_post_type` và `idx_is_visible`. `idx_content` sử dụng prefix 255 ký tự trên cột TEXT nên có thể tiêu tốn đáng kể dung lượng. Nếu cần tìm kiếm từ khóa trong nội dung, có thể nghiên cứu sử dụng FULLTEXT Index. `idx_post_type` chỉ có khoảng ba giá trị và `idx_is_visible` chỉ có hai giá trị 0/1 nên có Cardinality thấp. Khi điều kiện truy vấn trả về phần lớn bảng, MySQL có thể lựa chọn Full Table Scan thay vì sử dụng B-Tree Index.

## 3. Ảnh hưởng đến Read và Write

Index có thể giúp tăng tốc truy xuất dữ liệu nhưng mỗi Index cũng phải được duy trì khi INSERT, UPDATE hoặc DELETE. Khi thêm một bài viết, InnoDB phải ghi dữ liệu và cập nhật các secondary Index liên quan. Vì vậy việc có quá nhiều Index làm tăng I/O, CPU và chi phí ghi, đồng thời làm tăng dung lượng Data/Index trên đĩa.

Sau khi loại bỏ ba Index dư thừa, hệ thống giảm được chi phí bảo trì Index trong các thao tác ghi. Hai Index có giá trị sử dụng cao vẫn được giữ lại để hỗ trợ các truy vấn chính.

## 4. Kết quả đo

Thực hiện truy vấn:

```sql
SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';
```

Ghi nhận số liệu thực tế:

| Chỉ số | Trước tối ưu | Sau tối ưu |
|---|---:|---:|
| Data (MB) | ........ | ........ |
| Index (MB) | ........ | ........ |
| Tổng (MB) | ........ | ........ |

Mức giảm Index:

`Index giảm = Index_MB trước tối ưu - Index_MB sau tối ưu`

## 5. Kết luận

Việc tạo Index cần dựa trên nhu cầu truy vấn và đặc điểm dữ liệu thay vì tạo Index trên mọi cột. Các cột có Cardinality thấp như `is_visible` và `post_type` thường không mang lại nhiều lợi ích cho B-Tree Index, trong khi vẫn phát sinh chi phí lưu trữ và bảo trì. Sau khi loại bỏ ba Index không cần thiết, QuickFeed giảm được overhead của hệ thống ghi và giải phóng một phần dung lượng dành cho Index.
