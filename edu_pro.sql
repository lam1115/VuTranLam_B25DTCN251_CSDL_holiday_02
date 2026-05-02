CREATE DATABASE edu_pro;
USE edu_pro;

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    credits INT NOT NULL,
    tuition_fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female'))
);

CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    score DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO teachers (full_name, salary) VALUES
('Nguyen Van A - IT', 1000),
('Tran Thi B - Marketing', 1200),
('Le Van C - IT', 1100);

INSERT INTO courses (course_name, teacher_id, credits, tuition_fee) VALUES
('SQL Basics', 1, 3, 500),
('Advanced SQL', 1, 4, 700),
('Digital Marketing', 2, 3, 600),
('Data Structures', 3, 4, 800),
('Web Development', 3, 3, 750),
('UI/UX Design', NULL, 2, 400);

INSERT INTO students (full_name, date_of_birth, gender) VALUES
('Student 1', '2000-01-01', 'Male'),
('Student 2', '2000-02-01', 'Female'),
('Student 3', '2000-03-01', 'Male'),
('Student 4', '2000-04-01', 'Female'),
('Student 5', '2000-05-01', 'Male'),
('Student 6', '2000-06-01', 'Female'),
('Student 7', '2000-07-01', 'Male'),
('Student 8', '2000-08-01', 'Female'),
('Student 9', '2000-09-01', 'Male'),
('Student 10', '2000-10-01', 'Female');

INSERT INTO enrollments (student_id, course_id, date, score) VALUES
(1,1,'2025-01-01',8.5),
(2,1,'2025-01-02',7.0),
(3,2,'2025-01-03',9.0),
(4,2,'2025-01-04',NULL),
(5,3,'2025-01-05',6.5),
(6,3,'2025-01-06',7.5),
(7,4,'2025-01-07',8.0),
(8,4,'2025-01-08',NULL),
(9,5,'2025-01-09',9.5),
(10,5,'2025-01-10',8.5),
(1,3,'2025-01-11',7.0),
(2,4,'2025-01-12',8.0),
(3,5,'2025-01-13',6.0),
(4,1,'2025-01-14',7.5),
(5,2,'2025-01-15',8.5);

UPDATE teachers
SET salary = salary * 1.10
WHERE full_name LIKE '%IT%';

SELECT c.course_name, t.full_name AS teacher_name
FROM courses c
LEFT JOIN teachers t ON c.teacher_id = t.id;

SELECT *
FROM students
WHERE YEAR(date_of_birth) = 2005;

SELECT s.full_name, s.id AS student_id, e.score
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Web Development'
ORDER BY e.score DESC;

SELECT s.full_name AS student_name,c.course_name,t.full_name AS teacher_name
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
LEFT JOIN teachers t ON c.teacher_id = t.id;

SELECT t.full_name AS teacher_name, COUNT(c.id) AS total_courses
FROM teachers t
LEFT JOIN courses c ON t.id = c.teacher_id
GROUP BY t.id, t.full_name;

SELECT c.course_name, COUNT(e.id) * c.tuition_fee AS total_revenue
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.course_name, c.tuition_fee;

SELECT s.full_name, COUNT(e.course_id) AS total_courses
FROM enrollments e
JOIN students s ON e.student_id = s.id
GROUP BY s.id, s.full_name, YEAR(e.date), MONTH(e.date)
HAVING COUNT(e.course_id) >= 3;

SELECT c.course_name, AVG(e.score) AS avg_score
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.course_name
HAVING AVG(e.score) < 5.0;