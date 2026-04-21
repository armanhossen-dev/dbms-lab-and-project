-- Tables in MySQL:
-- # University Course Management System
-- PDF including screenshots of executed queries and their 
-- results (clearly captured from your own computer).


-- Student
-- (StudentID INT, Name VARCHAR(100), Department VARCHAR(100), EnrollmentYear INT)

create table Student(
    StudentID INT primary key,
    Name VARCHAR(100),
    Department VARCHAR(100),
    EnrollmentYear INT );

-- Course
-- (CourseID INT, CourseName VARCHAR(100), Department VARCHAR(100), Credits INT)

create table Course(
    CourseID INT primary key,
    CourseName VARCHAR(100),
    Department VARCHAR(100),
    Credits INT);

-- Enrollment
-- (StudentID INT, CourseID INT, Semester VARCHAR(10), Grade FLOAT)

create table Enrollment(
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(10),
    Grade FLOAT,
    Foreign Key (StudentID) References Student (StudentID),
    Foreign Key (CourseID) References Course (CourseID));

-- Instructor
-- (InstructorID INT, Name VARCHAR(100), Department VARCHAR(100))
create table Instructor(
    InstructorID INT primary Key,
    Name VARCHAR(100),
    Department VARCHAR(100));

-- Teaches
-- (InstructorID INT, CourseID INT, Semester VARCHAR(10))
create table Teaches(
    InstructorID INT,
    CourseID INT, 
    Semester VARCHAR(10),
    Foreign key (InstructorID) References Instructor(InstructorID),
    Foreign key (CourseID) References Course(CourseID));


insert into Student values
(1, 'Arman Hossen', 'CSE', 2024),
(2, 'Rajib Rahman', 'BBA', 2025),
(3, 'Sadman Sakib', 'CSE', 2025),
(4, 'Ahsan Rakib', 'BBA', 2026),
(5, 'Sohir Naim', 'SWE', 2022);


insert into Course values
(101, 'Algorithms', 'CSE', 3),
(102, 'Marketing Basics', 'BBA', 3),
(103, 'Data Structures', 'CSE', 3),
(104, 'Marketing Advance', 'BBA', 3),
(105, 'System Efficiency', 'SWE', 3);


insert into Instructor values
(1, 'Mizanur Rahman', 'CSE'),
(2, 'Azizur Khan', 'CSE'),
(3, 'Robiul Kabir', 'SWE'),
(4, 'Kabira Zahan', 'BBA'),
(5, 'Rahim Hossen', 'BBA');


insert into Enrollment values
(1, 101, 'Spring2024', 3.8),
(2, 102, 'Spring2025', 3.5),
(3, 103, 'Spring2025', 2.7),
(4, 104, 'Spring2026', 3.9),
(5, 105, 'Spring2022', 3.8);

insert into Teaches values
(1, 101, 'Spring2020'),
(2, 102, 'Spring2022'),
(3, 103, 'Spring2024'),
(4, 104, 'Spring2024'),
(5, 105, 'Spring2023');


-- 📘 Tasks
-- 1. SQL JOINs 
-- Write a query to list all students along with 
-- the courses they are enrolled in and the names 
-- of the instructors teaching those courses during 
-- the Spring2024 semester.

select s.Name as StudentName, c.CourseName, i.Name as InstructorName
from Student s 
join Enrollment e on s.StudentID = e.StudentID
join Course c on e.CourseID = c.CourseID
join Teaches t on c.CourseID = t.CourseID
join Instructor i on t.InstructorID = i.InstructorID
where t.Semester = 'spring2024';


-- 2. Aggregation with Condition
-- Write a query to calculate the average grade for each course, 
-- considering only students who enrolled after 2020.

select c.CourseName, AVG(e.Grade) AS AverageGrade
from Enrollment e
join Student s on e.StudentID = s.StudentID
join Course c on e.CourseID = c.CourseID
where s.EnrollmentYear > 2020
group by c.CourseName;


-- 3. User-Defined Function 
-- Create a MySQL function called calculateGPA(student_id INT) 
-- that returns the average GPA of the student with the given 
-- ID, using the Enrollment table.

DELIMITER $$

CREATE FUNCTION calculateGPA(student_id INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE gpa FLOAT;

    SELECT AVG(Grade)
    INTO gpa
    FROM Enrollment
    WHERE StudentID = student_id;

    RETURN gpa;
END$$
DELIMITER ;


-- 4. Conditional Output 
-- Using the function created in Task 3, write a query that displays each student’s name along with their performance category:
-- 'Excellent' for GPA > 3.5
-- 'Good' for GPA between 3.0 and 3.5
-- 'Average' for GPA between 2.0 and 3.0
-- 'Poor' for GPA < 2.0
-- Use the CASE WHEN statement to define the categories.


select Name, calculateGPA(StudentID) as GPA,
    case 
        when calculateGPA(StudentID) > 3.5 then 'Excellent'
        when calculateGPA(StudentID) between 3.0 and 3.5 then 'Good'
        when calculateGPA(StudentID) between 2.0 and 3.0 then 'Average'
        else 'Poor'
    end as performance
from student;


-- 5. Stored Procedure with Loop 
-- Create a stored procedure that accepts a department name as input. The procedure should loop through 
-- all students in that department and display their name and GPA (using the function from Task 3). 
-- Use DECLARE, CURSOR, and LOOP constructs in your procedure.


delimiter $$
create procedure StudentGPAByDepartment(in dept_name varchar(100))
begin 
    declare done int  default FALSE;
    declare s_id int;
    declare s_name varchar(100);
    declare cur CURSOR for
        select StudentID, Name from Student 
        where Department = dept_name;
    declare continue handler for not found set done = TRUE;
    open cur;
    read_loop: LOOP
        FETCH cur into s_id, s_name;
        if done then
            leave read_loop;
        end if;    

    select s_name as StudentName, calculateGPA(s_id) as GPA;

    End loop;
    close cur;
end$$
delimiter ;

CALL StudentGPAByDepartment('CSE');


-- Bonus Task (Optional )
-- Write a query to identify students who have never enrolled in any course.

select Name From Student
where StudentID NOT IN(
    select distinct StudentID from Enrollment);

-- Presentation:
-- https://elearn.daffodilvarsity.edu.bd/mod/assign/view.php?id=2129448