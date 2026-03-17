CREATE DATABASE studentdb;
USE studentdb;
-- Create students table
CREATE TABLE students (
    student_id   INT PRIMARY KEY,
    student_name VARCHAR(60),
    email        VARCHAR(80),
    age          INT,
    department   VARCHAR(50)
);
 
INSERT INTO students VALUES
(1, 'Alice Brown',   'alice@mail.com',   22, 'Computer Science'),
(2, 'Bob Martin',    'bob@mail.com',     24, 'Mathematics'),
(3, 'Carol White',   'carol@mail.com',   21, 'Computer Science'),
(4, 'David Lee',     'david@mail.com',   23, 'Physics'),
(5, 'Eva Green',     'eva@mail.com',     22, 'Mathematics');
 
-- Create courses table
CREATE TABLE courses (
    course_id   INT PRIMARY KEY,
    course_name VARCHAR(80),
    credits     INT,
    instructor_id INT
);
 
INSERT INTO courses VALUES
(101, 'Database Systems',    3, 201),
(102, 'Data Structures',     4, 202),
(103, 'Linear Algebra',      3, 203),
(104, 'Quantum Physics',     3, 204),
(105, 'Machine Learning',    4, 201);
 
-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id    INT,
    course_id     INT,
    grade         DECIMAL(4,2),
    enroll_date   DATE
);
 
INSERT INTO enrollments VALUES
(1, 1, 101, 88.50, '2024-01-10'),
(2, 1, 102, 91.00, '2024-01-10'),
(3, 2, 103, 76.00, '2024-01-11'),
(4, 3, 101, 85.00, '2024-01-12'),
(5, 4, 104, 79.50, '2024-01-12'),
(6, 5, 105, 93.00, '2024-01-13'),
(7, 2, 105, 70.00, '2024-01-14'),
(8, 3, 102, 88.00, '2024-01-14');
 
-- Create instructors table
CREATE TABLE instructors (
    instructor_id   INT PRIMARY KEY,
    instructor_name VARCHAR(60),
    department      VARCHAR(50)
);
 
INSERT INTO instructors VALUES
(201, 'Dr. Smith',   'Computer Science'),
(202, 'Dr. Patel',   'Computer Science'),
(203, 'Dr. Chen',    'Mathematics'),
(204, 'Dr. Kumar',   'Physics');
 
-- Create payments table
CREATE TABLE payments (
    payment_id  INT PRIMARY KEY,
    student_id  INT,
    amount      DECIMAL(10,2),
    paid_on     DATE
);
 
INSERT INTO payments VALUES
(1, 1, 1500.00, '2024-01-05'),
(2, 2, 1200.00, '2024-01-06'),
(3, 3, 1500.00, '2024-01-07'),
(4, 4, 900.00,  '2024-01-08'),
(5, 5, 1800.00, '2024-01-09'),
(6, 1, 500.00,  '2024-02-01');


-- Question 1: Find Students Enrolled in More Than One Course.
-- Retrieve the names of students who are currently enrolled in more than one 
-- course along with their enrollment count. Sort the result by enrollment count in descending order.
SELECT s.student_name, count(e.enrollment_id) as enrollment_count FROM
students s JOIN enrollments e
ON s.student_id = e.student_id
group by s.student_id
order by enrollment_count desc;

-- Question 2: Identify Instructors Who Are Not Assigned to Any Course.

-- Find the names and departments of instructors who do not teach any course listed in the courses table.


SELECT instructor_name, department from instructors
WHERE instructor_id NOT IN (select instructor_id from courses);
-- Here all the instructors are assigned to a course, so the result is null 

-- Question 3: Find the Highest-Graded Student per Course.

-- For each course, retrieve the course name and the name of the student who achieved the highest grade.
--  If there is a tie, display all tied students.

select * from courses;

SELECT c.course_name, s.student_name FROM 
courses c JOIN enrollments e 
ON c.course_id = e.course_id
JOIN students s
ON e.student_id = s.student_id
where e.grade in (select max(grade) from enrollments group by course_id); 

-- Question 4: Calculate the Total Payment Made by Each Student.

-- Display each student's name along with the total amount they have paid. 
-- Include students who have made at least one payment. Sort by total amount paid in descending order.

SELECT s.student_name, sum(p.amount) as total_amount FROM
students s JOIN payments p
ON s.student_id = p.student_id 
group by p.student_id
order by total_amount desc;

select * from courses;
select * from enrollments;

select avg(amount) from payments;

-- Question 5: Find Courses Where the Average Grade Is Below 85.
-- List the course names and their average grades for courses where the class average falls below 85. 
-- Round the average grade to two decimal places.

SELECT c.course_name, round(avg(e.grade),2) FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY e.course_id
HAVING avg(e.grade) < 85;

select * from students;
select * from instructors;
select * from enrollments;
select * from courses;


