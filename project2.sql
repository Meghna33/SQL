-- # Creating table for worker table.

create table worker(
worker_id int primary key,
first_name text,
last_name text,
salary numeric,
joining_date timestamp,
departement text)

select*
from worker

-- # Inserting values in worker table.

insert into worker(worker_id,first_name,last_name,salary,joining_date,departement)
values
(1,'siddharth','singh',80000,'2019-03-20 09:00:00','HR'),
(2,'Lavesh','ahir',300000,'2019-07-11 09:00:00','Admin'),
(3,'abhishek','midha',500000,'2019-03-20 09:00:00','HR'),
(4,'rahul','mahar',200000,'2019-03-20 09:00:00','Admin'),
(5,'saurabh','madhavi',90000,'2019-07-11 09:00:00','Admin'),
(6,'aman','nain',75000,'2019-07-11 09:00:00','Account'),
(7,'vaibhav','varshney',100000,'2019-02-20 09:00:00','Account'),
(8,'farhaan','masjid',500000,'2019-05-11 09:00:00','Admin');

-- # Creating table for title table.

create table title(
worker_ref_id int primary key,
affected_from timestamp,
worker_title text)

select*
from title

-- # Inserting values in title table.

insert into title (worker_ref_id,affected_from,worker_title)
values(1,'2021-02-20 00:00:00','Manager'),
(2,'2021-06-11 00:00:00','Exective'),
(8,'2021-06-11 00:00:00','Exective'),
(5,'2021-06-11 00:00:00','Manager'),
(4,'2021-06-11 00:00:00','Asst. Manager'),
(7,'2021-06-11 00:00:00','Exective'),
(6,'2021-06-11 00:00:00','Lead'),
(3,'2021-06-11 00:00:00','Lead');

-- # Write a SQL query to fetch “FIRST_NAME” from Worker table.

select first_name
from worker;

-- #Write a SQL query to fetch “FIRST_NAME” from Worker table in upper case. 

select upper (first_name)
from worker;

-- #Write an SQL query to fetch unique values of DEPARTMENT from Worker table.

select distinct departement
from worker;

-- #Write a SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.

select replace(first_name,'a','A')
from worker;

-- #Write a SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

select concat (first_name, ' ', last_name)
from worker;

-- #Write a SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending. 

select*
from worker
order by first_name asc;

-- #Write a SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and Departement descending. 

select*
from worker
order by first_name asc, departement desc;

-- #Write a SQL query to print details for Workers with the first name as “Rahul” and “Lavesh” from Worker table.

select*
from worker
where first_name in ('rahul', 'Lavesh');

-- #Write a SQL query to print details of workers excluding first names, “Rahul” and “Lavesh” from Worker table.

select*
from worker
where first_name not in ('rahul', 'Lavesh');

-- #Write a SQL query to print details of the Workers whose FIRST_NAME starts with ‘S’.

select*
from worker
where first_name like 's%';

-- #Write a SQL query to print details of the Workers whose FIRST_NAME ends with 'n’.

select*
from worker
where first_name like '%n';

-- #Write a SQL query to print details of the Workers whose FIRST_NAME ends with ‘l’ and contains five alphabets.

select*
from worker
where first_name like '-----l';

-- #Write a SQL query to print details of the Workers whose SALARY lies between 100000 and 500000. 

select*
from worker
where salary between 100000 and 500000;

-- #Write a SQL query to print details of the Workers who have joined in Mar’2019. 

select*
from worker
where extract (year from joining_date)= 2019 and extract (month from joining_date)= 3;

-- #Write a SQL query to show the current date and time.

select now();

-- #Write a SQL query to fetch the count of employees working in the department ‘Admin’. 

select count(*)
from worker
where departement='Admin';

-- #Write a SQL query to fetch the no. of workers for each department in the descending order. 

select departement,count(*) as workers
from worker
group by departement
order by workers desc;

-- #Write a SQL query to fetch departments along with the total salaries paid for each of them. 

select departement,sum(salary) as total_sal
from worker
group by departement;

-- #Write a SQL query to show all departments along with the number of people in there. 

select departement,count(departement) as workers
from worker
group by departement
order by workers desc;

-- #Write a SQL query to fetch the departments that have less than five people in it. 

select departement,count(departement) as workers
from worker
group by departement
having count(departement)<5;

-- #Write a SQL query to show one row twice in results from a table with department 'HR'. 

select*
from worker as w
where w.departement='HR'
union all
select*
from worker as w1
where w1.departement='HR';

-- #Write a SQL query to fetch the names of workers who earn the highest salary. 

select first_name, max(salary) as high_sal
from worker
group by first_name
order by high_sal desc;

-- #Write a SQL query to show the second highest salary from a table. 

select first_name, max(salary) as high_sal
from worker
group by first_name
order by high_sal desc
limit 2;

-- #Write a SQL query to show the top n (say 10) records of a table. 

select *
from worker
order by salary desc
limit 10;

-- #Write a SQL query to determine the nth (say n=3) highest salary from a table. 

select first_name, max(salary) as high_sal
from worker
group by first_name
order by high_sal desc
limit 3;

-- #Write a SQL query to determine the 3rd highest salary without using TOP or limit method. 

with tab1 as
(select first_name, salary, row_number() over (order by salary desc) as salaryrank
from worker) 
select*
from tab1
where salaryrank=3;

-- #Write a SQL query to fetch three min salaries from a table.

select first_name, min(salary) as min_sal
from worker
group by first_name
order by min_sal asc
limit 3;

-- #Write a SQL query to fetch the list of employees with the same salary. 

select w.first_name, w.salary, w.worker_id
from worker as w, worker as w1
where w.salary= w1. salary and w.worker_id  != w1.worker_id;

-- #Write a SQL query to print details of the Workers who are also Managers. 

select w.first_name, t.worker_title
from worker as w
join title as t
on w.worker_id= t.worker_ref_id
where t.worker_title='Manager';

-- #Write a SQL query to compute the average salary of Workers for each work title. 

select t.worker_title, avg(w.salary)
from worker as w
join title as t
on w.worker_id= t.worker_ref_id
group by t.worker_title;

-- #Write a SQL query to print the name of employees having the highest salary in each department. 

with tab1 as (select first_name ,departement, salary,row_number() over (partition by departement order by salary desc) as max_sal
from worker)
select*
from tab1 
where max_sal=1;

-- #Write a SQL query to create a view for those Worker Q 40 belonging to the Department 'HR'.

CREATE VIEW HRStaff 
AS SELECT * 
FROM Worker 
WHERE departement = 'HR'; 
-----------------------------
select*
from HRStaff


