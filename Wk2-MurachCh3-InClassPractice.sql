--Wk2
--In Class Practice for Murach-Ch3

--Covered topics:
----WHERE, ORDER BY clauses
----Basic comparison, logical operators
----ROWNUM, ||, column alias
----LIKE, wildcard characters
----Dual table, scalar function

--Run the statements using user AP unless otherwise indicated.

--1.
--print names, dept numbers of employees supervised by manager with id 7839
--  in the increasing order of employee names
Select Ename, DeptNo
From EMP
Where mgr = 7839
ORDER BY Ename ASC;


--2.
--For the above query, limit the query result to be at most 2 rows
Select Ename, DeptNo
From EMP
Where mgr = 7839 and rownum <= 2
ORDER BY Ename ASC;


--3.
--print all employees' work information and 
--display the heading of the query result to be Work Info
--Sample Output:
---- Work Info
---- KING works in Dept 10
---- BLAKE works in Dept 30
Select ename || ' works in Dept ' || Deptno AS "Work Info" 
From emp;



--4.
--use the tables in user EX
--print the first names, last names of customers whose first name start with Jo
Select customer_first_name, customer_last_name
From customers_ex
Where customer_first_name LIKE 'Jo%';


--5.
--car loan: 
-- Simplified and do not consider compound interest
-- loan amount: $20000,  loan interest rate: 6%, 
-- Print the car loan principal amount, total interest amount, 
--      the total amount you would pay after the principal is paid off,
--      and the current date in the default date format.
-- Display the headings of query result like this:
-- Principal    Interest Amount      Total Payment    Today
--   20000        1200                 21200          29-JAN-19

--First Way of Solving Problem:
CREATE Table Car_Loan (
    Principal int,
    "Interest Amount" int,
    "Total Payment" int,
    Today Date);
Insert Into Car_Loan
Values (20000,1200,21200,sysdate);
Select *
From Car_Loan;

--Second Way of Solving Problem:
Select 20000 AS Principal, 1200 AS "Interest Amount", 21200 AS "Total Payment", sysdate AS Today
From dual;


--6. 
-- Print the date and time when the query is executed.
-- Print the date and time in the format below ( time in 24 hour notation)
-- Display the heading for the query result as System Date
---Sample Output
-----System Date
-----28-jan-2020 13:46:05
Select TO_CHAR(Sysdate, 'DD-MON-YYYY HH24:MI:SS') as "System Date"
from dual;