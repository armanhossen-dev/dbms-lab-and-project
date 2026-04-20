-- CREATE DATABASE + TABLES

CREATE DATABASE labfinal;
use labfinal;

-- CREATE, PRIMARY KEY, FOREIGN KEY, UNIQUE

create table students(
    sid int primary key,
    name varchar(50),
    dept varchar(50),
    email varchar(50) unique
);

create table courses(
    cid int primary key,
    cname varchar(50),
    credit int
);

create table enrollment(
    enroll_id int primary key,
    sid int,
    cid int, 
    grade varchar(2),
    foreign key (sid) references students(sid),
    foreign key (cid) references courses(cid)
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,      -- integer, auto increment
    username VARCHAR(50) NOT NULL,               -- text (required)
    email VARCHAR(100) UNIQUE,                   -- unique value
    password VARCHAR(255) NOT NULL,              -- text (required)
    
    age INT CHECK (age >= 0),                    -- integer with condition
    salary DECIMAL(10,2),                        -- decimal numbers
    
    is_active BOOLEAN DEFAULT TRUE,              -- true/false
    gender ENUM('Male', 'Female', 'Other'),      -- fixed choices
    
    birth_date DATE,                             -- date
    login_time TIME,                             -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- auto timestamp
    
    profile_text TEXT,                           -- long text    
    profile_image BLOB,                          -- binary data (image/file)    
    country VARCHAR(50) DEFAULT 'Bangladesh'     -- default value
);

/*
Numbers: INT, DECIMAL
Text: VARCHAR, TEXT
Boolean: BOOLEAN
Date/Time: DATE, TIME, TIMESTAMP
Special inputs: ENUM, BLOB
Constraints:
    PRIMARY KEY
    NOT NULL
    UNIQUE
    CHECK
    DEFAULT

Tips
    Use VARCHAR for short text, TEXT for long content.
    Use ENUM only if values are fixed.
    Avoid BLOB unless really needed (can slow things).
    Always add constraints to keep data clean.
*/


-- INSERT DATA

INSERT INTO Users 
(username, email, password, age, salary, is_active, gender, birth_date, login_time, profile_text)
VALUES 
('arman123', 'arman@email.com', 'pass123', 22, 15000.50, TRUE, 'Male', '2002-05-10', '14:30:00', 'Hello world!');


INSERT INTO students VALUES
(1, 'Arman', 'CSE', 'ooh@gmail.com'),
(2, 'Hossen', 'SWE', 'faaa@gmail.com');

INSERT INTO courses VALUES
(101, 'Database', 3),
(202, 'Algorithm', 3);

INSERT INTO enrollment VALUES
(1, 1, 101, 'A'),
(2, 2, 202, 'B');


-- BASIC QUERIES

-- select al
select * from students;

-- where and order by
select * from students
where dept = 'CSE'
order by name;

-- join
select s.name, c.cname,  e.grade
from students s 
join enrollment e on s.sid = e.sid 
join courses c on e.cid = c.cid;


-- group by + aggregate
select cid, count(sid) as total_students 
from enrollment 
group by cid;


select * from students;
+-----+--------+------+----------------+
| sid | name   | dept | email          |
+-----+--------+------+----------------+
|   1 | Arman  | CSE  | ooh@gmail.com  |
|   2 | Hossen | SWE  | faaa@gmail.com |
+-----+--------+------+----------------+

-- update and delete
update students
set dept = 'EEE'
where sid = 2;


select * from students;
+-----+--------+------+----------------+
| sid | name   | dept | email          |
+-----+--------+------+----------------+
|   1 | Arman  | CSE  | ooh@gmail.com  |
|   2 | Hossen | EEE  | faaa@gmail.com |
+-----+--------+------+----------------+


select * from enrollment;
+-----------+------+------+-------+
| enroll_id | sid  | cid  | grade |
+-----------+------+------+-------+
|         1 |    1 |  101 | A     |
|         2 |    2 |  202 | B     |
+-----------+------+------+-------+

delete from enrollment
where enroll_id = 2;

select * from enrollment;
+-----------+------+------+-------+
| enroll_id | sid  | cid  | grade |
+-----------+------+------+-------+
|         1 |    1 |  101 | A     |
+-----------+------+------+-------+

-- constraint example
-- constraints are pre-defined rules applied to table columns to ensure the
-- accuracy, reliability and integrity of the data
-- if an operation(insert, upadate, delete) violets a constraint the action is aborted.

/*
Common SQL Constraints  

PRIMARY KEY:    Uniquely identifies each row, acting as a NOT NULL and UNIQUE combo.
FOREIGN KEY:    Ensures referential integrity by linking data in one table to a PRIMARY KEY in another.
NOT NULL:       Forces a column to contain a value, making it mandatory.
UNIQUE:         Ensures all values in a column are distinct, allowing NULL values unlike PRIMARY KEY.
CHECK:          Validates that values satisfy a specific condition.
DEFAULT:        Sets a default value for a column when none is provided.
INDEX:          Used to speed up data retrieval. 


Constraint 	Function
NOT NULL	Ensures no NULL values in a column.
UNIQUE	Guarantees all values are distinct.
PRIMARY KEY	Uniquely identifies a record.
FOREIGN KEY	Ensures referential integrity between tables.
CHECK	Validates data against a specific condition.
DEFAULT	Provides a default value for new records.
*/


ALTER TABLE Students
ADD CONSTRAINT chk_email CHECK (email LIKE '%@gmail.com');


-- view
create view studentCourseView as
select s.name, c.cname, e.grade 
from students s 
join enrollment e on s.sid = e.sid 
join courses c on e.cid = c.cid;

--lets see
select * from studentCourseView;
+-------+----------+-------+
| name  | cname    | grade |
+-------+----------+-------+
| Arman | Database | A     |
+-------+----------+-------+

-- stored procedure
DELIMITER $$

CREATE PROCEDURE getstcs(IN p_sid INT)
BEGIN 
    SELECT c.cname, e.grade
    FROM enrollment e 
    JOIN courses c ON e.cid = c.cid 
    WHERE e.sid = p_sid;
END $$

DELIMITER ;

CALL GetStudentCourses(1);

--- trigger
CREATE TABLE LogTable (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

DELIMITER //

CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO LogTable(message)
    VALUES (CONCAT('New student added: ', NEW.name));
END //

DELIMITER ;

-- transaction
START TRANSACTION;

UPDATE Students SET dept = 'BBA' WHERE student_id = 1;
SAVEPOINT sp1;
UPDATE Students SET dept = 'LAW' WHERE student_id = 2;
ROLLBACK TO sp1;
COMMIT;