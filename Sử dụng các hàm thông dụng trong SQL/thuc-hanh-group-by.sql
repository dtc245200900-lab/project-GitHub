-- Sử dụng cơ sở dữ liệu
USE QuanLySinhVien;

-- =========================================
-- BÀI 1: Hiển thị số lượng sinh viên ở từng nơi
-- =========================================
SELECT 
    Address,
    COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;


-- =========================================
-- BÀI 2: Tính điểm trung bình các môn học
-- của mỗi học viên
-- =========================================
SELECT 
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;


-- =========================================
-- BÀI 3: Hiển thị học viên có điểm trung bình > 15
-- =========================================
SELECT 
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) > 15;


-- =========================================
-- BÀI 4: Hiển thị học viên có điểm trung bình lớn nhất
-- =========================================
SELECT 
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(Mark)
    FROM Mark
    GROUP BY StudentId
);