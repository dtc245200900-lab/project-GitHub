# Báo cáo đánh giá và tối ưu Index - SmartFactory

## 1. Vấn đề

Hệ thống SmartFactory sử dụng bảng `SensorLogs` để lưu dữ liệu từ các cảm biến IoT. Ban đầu, hệ thống sử dụng một Covering Index gồm các cột `sensor_id`, `recorded_at`, `temperature`, `humidity` và `status`.

Covering Index giúp truy vấn Dashboard nhanh vì các dữ liệu cần lấy đã có sẵn trong Index. Tuy nhiên, Index này có kích thước lớn và phải được cập nhật mỗi khi có bản ghi mới. Với hệ thống IoT có lượng dữ liệu INSERT rất lớn, việc duy trì Index lớn làm tăng chi phí I/O, CPU và bộ nhớ, đồng thời làm tăng dung lượng lưu trữ.

## 2. Giải pháp

Tôi thay thế Fat Index:

`(sensor_id, recorded_at, temperature, humidity, status)`

bằng Lean Index:

`(sensor_id, recorded_at)`

Hai cột này được sử dụng để lọc dữ liệu trong câu truy vấn Dashboard. Các cột `temperature`, `humidity` và `status` không được đưa vào Index vì chúng chỉ là dữ liệu cần lấy ra sau khi xác định được các bản ghi phù hợp.

## 3. Đánh đổi

Sau khi sử dụng Lean Index, truy vấn SELECT có thể chậm hơn một phần do MySQL phải sử dụng Index để tìm các bản ghi phù hợp rồi truy cập bảng gốc để lấy `temperature`, `humidity` và `status`.

Tuy nhiên, Lean Index có kích thước nhỏ hơn và giảm lượng dữ liệu cần duy trì khi INSERT. Điều này đặc biệt có ý nghĩa đối với hệ thống SmartFactory vì dữ liệu cảm biến được ghi liên tục với tần suất rất cao.

## 4. Kết luận

Giải pháp Lean Index giúp cân bằng giữa tốc độ đọc, tốc độ ghi và chi phí lưu trữ. Thay vì tối ưu SELECT bằng cách đưa toàn bộ dữ liệu vào Index, hệ thống chỉ giữ các cột cần thiết cho việc tìm kiếm.

Qua đó, hệ thống vẫn sử dụng Index để tăng hiệu quả truy vấn nhưng giảm được chi phí duy trì Index trong quá trình ghi dữ liệu. Đây là lựa chọn phù hợp hơn với đặc điểm của hệ thống IoT có lưu lượng INSERT lớn.
