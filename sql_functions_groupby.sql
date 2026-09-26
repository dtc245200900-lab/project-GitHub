USE QuanLySinhVien;

-- =========================================
-- 1. MÔN HỌC CÓ CREDIT LỚN NHẤT
-- =========================================

SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);


-- =========================================
-- 2. MÔN HỌC CÓ ĐIỂM THI LỚN NHẤT
-- =========================================

SELECT
    s.SubjectID,
    s.SubName,
    s.Credit,
    m.Mark
FROM Subject s
JOIN Mark m
    ON s.SubjectID = m.SubjectID
WHERE m.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);


-- =========================================
-- 3. ĐIỂM TRUNG BÌNH CỦA MỖI SINH VIÊN
-- SẮP XẾP GIẢM DẦN
-- =========================================

SELECT
    s.StudentID,
    s.StudentName,
    AVG(m.Mark) AS AverageMark
FROM Student s
JOIN Mark m
    ON s.StudentID = m.StudentID
GROUP BY
    s.StudentID,
    s.StudentName
ORDER BY
    AverageMark DESC;