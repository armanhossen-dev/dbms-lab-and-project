create database final;
use final;
create table employees(
    emp_id int primary key,
    name varchar(10),
    dept_id int);

desc employees;

create table dept(
    dept_id int primary key,
    dept_name varchar(10));

drop table employees;


create table employees(
    emp_id int primary key,
    name varchar(10),
    dept_id int,
    foreign key (dept_id) references dept(dept_id)
);

-- create the foreign keys table first
-- insert into it first
insert into dept values
(101, 'cse'),
(102, 'swe'),
(103, 'bba'),
(104, 'cis');

insert into employees values
(1, 'Arman1', 101),
(2, 'Arman2', 102),
(3, 'Arman3', 103),
(4, 'Arman4', 104);

-- inner join: it is for the matching row
select employees.Name, dept.dept_name
from employees 
inner join dept on employees.dept_id = dept.dept_id;

-- or

select e.Name, d.dept_id
from employees e 
inner join dept d on e.dept_id = d.dept_id;

-- +--------+-----------+
-- | Name   | dept_name |
-- +--------+-----------+
-- | Arman1 | cse       |
-- | Arman2 | swe       |
-- | Arman3 | bba       |
-- | Arman4 | cis       |
-- +--------+-----------+


-- left join / left outer join

create table customers(
    c_id int primary key,
    name varchar(30));

insert into customers values
(1, 'Arman Hossen'),
(2, 'Jannatul Ferdous'),
(3, 'Santona Akhter');

create table orders(
    c_id int,
    o_id int,
    foreign key (c_id) references customers(c_id));


insert into orders values
(1, 5001),
(1, 5002),
(3, 5003),
(1, 5004),
(2, 5001),
(2, 5002),
(3, 5004);

 -- print the names and  thier orders
 select c.name, o.o_id
 from customers c
 left join orders o on c.c_id = o.c_id;
-- +------------------+------+
-- | name             | o_id |
-- +------------------+------+
-- | Arman Hossen     | 5001 |
-- | Arman Hossen     | 5002 |
-- | Arman Hossen     | 5004 |
-- | Jannatul Ferdous | 5001 |
-- | Jannatul Ferdous | 5002 |
-- | Santona Akhter   | 5003 |
-- | Santona Akhter   | 5004 |
-- +------------------+------+

-- right join / right outer join

desc dept;
-- +-----------+-------------+------+-----+---------+-------+
-- | Field     | Type        | Null | Key | Default | Extra |
-- +-----------+-------------+------+-----+---------+-------+
-- | dept_id   | int(11)     | NO   | PRI | NULL    |       |
-- | dept_name | varchar(10) | YES  |     | NULL    |       |
-- +-----------+-------------+------+-----+---------+-------+

select * from dept;
-- +---------+-----------+
-- | dept_id | dept_name |
-- +---------+-----------+
-- |     101 | cse       |
-- |     102 | swe       |
-- |     103 | bba       |
-- |     104 | cis       |
-- +---------+-----------+

insert into dept values
(105, 'english');


-- right join : employee nise tai emplyee er sobar jonne form er table er mil paise tader kujese, 

select d.dept_name, e.Name
from dept d 
right join employees e on e.dept_id = d.dept_id;
-- +-----------+--------+
-- | dept_name | Name   |
-- +-----------+--------+
-- | cse       | Arman1 |
-- | swe       | Arman2 |
-- | bba       | Arman3 |
-- | cis       | Arman4 |
-- +-----------+--------+

-- right join e jake nibo tar sate match kore sobai ke kujbo na pile null hobe
select e.name, d.dept_name
from employees e 
right join dept d on e.dept_id = d.dept_id;
-- +--------+-----------+
-- | name   | dept_name |
-- +--------+-----------+
-- | Arman1 | cse       |
-- | Arman2 | swe       |
-- | Arman3 | bba       |
-- | Arman4 | cis       |
-- | NULL   | english   |
-- +--------+-----------+

-- full outer join // returns all record while there is a match in either left or right table

desc employees;
-- +---------+-------------+------+-----+---------+-------+
-- | Field   | Type        | Null | Key | Default | Extra |
-- +---------+-------------+------+-----+---------+-------+
-- | emp_id  | int(11)     | NO   | PRI | NULL    |       |
-- | name    | varchar(10) | YES  |     | NULL    |       |
-- | dept_id | int(11)     | YES  | MUL | NULL    |       |
-- +---------+-------------+------+-----+---------+-------+
select * from employees;
-- +--------+--------+---------+
-- | emp_id | name   | dept_id |
-- +--------+--------+---------+
-- |      1 | Arman1 |     101 |
-- |      2 | Arman2 |     102 |
-- |      3 | Arman3 |     103 |
-- |      4 | Arman4 |     104 |
-- +--------+--------+---------+


insert into employees values
(5, 'Arman 5', 105);


-- mariaDB dosen't support full outer join baby , so make it happen using 
-- left join, union, right jion
select e.name, d.dept_name
from employees e 
left join dept d on e.dept_id = d.dept_id

union

select e.name, d.dept_name
from employees e 
right join dept d on e.dept_id = d.dept_id;

-- +---------+-----------+
-- | name    | dept_name |
-- +---------+-----------+
-- | Arman1  | cse       |
-- | Arman2  | swe       |
-- | Arman3  | bba       |
-- | Arman4  | cis       |
-- | Arman 5 | english   |
-- +---------+-----------+



insert into dept values 
(106, 'marketing');

select e.name, d.dept_name
from employees e 
left join dept d on e.dept_id = d.dept_id

union

select e.name, d.dept_name
from employees e 
right join dept d on e.dept_id = d.dept_id;
-- +---------+-----------+
-- | name    | dept_name |
-- +---------+-----------+
-- | Arman1  | cse       |
-- | Arman2  | swe       |
-- | Arman3  | bba       |
-- | Arman4  | cis       |
-- | Arman 5 | english   |
-- | NULL    | marketing |
-- +---------+-----------+


-- cross join / returns the cartesian product of both tables;

create table supliers(
    suplierId int primary key,
    name varchar(30));

insert into supliers values
(101, 'Dipjol kanna'),
(420, 'Manna Vai');

create table products(
    productId int primary key,
    name varchar(40));

insert into products values 
(1, 'laptop'),
(2, 'iphone'),
(3, 'mac mini'),
(4, 's26 ultra'),
(5, 'mouse');

-- now giving each suppliers each product or showing that
select p.name , s.name
from products p 
cross join supliers s;

-- +-----------+--------------+
-- | name      | name         |
-- +-----------+--------------+
-- | laptop    | Dipjol kanna |
-- | laptop    | Manna Vai    |
-- | iphone    | Dipjol kanna |
-- | iphone    | Manna Vai    |
-- | mac mini  | Dipjol kanna |
-- | mac mini  | Manna Vai    |
-- | s26 ultra | Dipjol kanna |
-- | s26 ultra | Manna Vai    |
-- | mouse     | Dipjol kanna |
-- | mouse     | Manna Vai    |
-- +-----------+--------------+

-- self join / a join where table joined with itself

-- creating or adding a new column in a table.  ALTER TABLE employees ADD middle_name VARCHAR(10) AFTER name;
alter table employees 
add managerId int; -- here managerID is a new column , 

-- rename a table. ALTER TABLE old_table_name RENAME TO new_table_name;
rename table employees to emp;

desc emp;
select * from emp;
-- +--------+---------+---------+-----------+
-- | emp_id | name    | dept_id | managerId |
-- +--------+---------+---------+-----------+
-- |      1 | Arman1  |     101 |      NULL |
-- |      2 | Arman2  |     102 |      NULL |
-- |      3 | Arman3  |     103 |      NULL |
-- |      4 | Arman4  |     104 |      NULL |
-- |      5 | Arman 5 |     105 |      NULL |
-- +--------+---------+---------+-----------+

-- lets update the emp managerID
update emp set managerID = 3 where emp_id = 4;
update emp set managerID = 3 where emp_id = 5;
update emp set managerID = 2 where emp_id in (1,3);


select * from emp;


-- empty a table
truncate table emp;

INSERT INTO emp values
(1, 'Arman', 101, NULL), -- The Top Boss
(2, 'Alice', 101, 1),    -- Alice reports to Arman
(3, 'Bob', 102, 1),      -- Bob reports to Arman
(4, 'David', 102, 2),    -- David reports to Alice
(5, 'Emma', 102, 3);     -- Emma reports to Bob


-- find emp with sam manger using self join
select a.name as Emp_Name, b.name as Manager_Name
from emp a 
inner join emp b on a.managerID = b.emp_id;
-- emp je manger er under e ase -> a.mangerid = b.emp_id, manger er je employee
-- +----------+--------------+
-- | Emp_Name | Manager_Name |
-- +----------+--------------+
-- | Alice    | Arman        |
-- | Bob      | Arman        |
-- | David    | Alice        |
-- | Emma     | Bob          |
-- +----------+--------------+
