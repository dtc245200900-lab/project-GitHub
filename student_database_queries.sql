USE StudentManagement;

-- 1. Hiển thị tất cả sinh viên có tên bắt đầu bằng 'h'
SELECT *
FROM Student
WHERE StudentName LIKE 'h%';


-- 2. Hiển thị các lớp có thời gian bắt đầu vào tháng 12
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;


-- 3. Hiển thị các môn học có Credit từ 3 đến 5
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;


-- 4. Thay đổi ClassID của sinh viên tên 'Hung' thành 2
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';


-- Kiểm tra kết quả UPDATE
SELECT *
FROM Student
WHERE StudentName = 'Hung';


-- 5. Hiển thị StudentName, SubName, Mark
-- Sắp xếp Mark giảm dần, nếu trùng thì StudentName tăng dần
SELECT
    s.StudentName,
    sub.SubName,
    m.Mark
FROM Student s
JOIN Mark m
    ON s.StudentID = m.StudentID
JOIN Subject sub
    ON m.SubID = sub.SubID
ORDER BY
    m.Mark DESC,
    s.StudentName ASC;