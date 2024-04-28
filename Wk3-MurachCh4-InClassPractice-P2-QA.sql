--Week 3, Part 2 
--Murach Ch4, In Class Practice
--Questions & Answers

--Covered topics: Self Join, OUTER JOIN

--Continued from Lec 5.

--All tables needed are under user AP in the document:
--   Oracle Users and Their Tables used in the Course.pdf
--If you don't have the tables emp, dept for AP, run the script: 
--    CREATE-LOAD-AP-DEPT-EMP-TABLES-CIS-DB-Server.sql (included again in Week 3 Module)

--4
--Print the names of employees in department 30 and the names of their managers. 

--Soln
--Self Join the primary key column empno with the foreign key column mgr
SELECT e.ename, m.ename
FROM  emp e INNER JOIN emp m 
       ON (e.mgr = m.empno)
WHERE e.deptno = 30;

--related query
--print names of all workers and their managers
SELECT e.ename "Worker",  m.ename "Manager" 
FROM  emp  e left JOIN emp m ON (e.mgr = m.empno);


--5
--Print all general ledger accounts' numbers, descriptions, the invoice ids of invoices 
--where the accounts were used.
--The query result also includes accounts that were not used in any purchase. 

--Solution
--run as ap user
SELECT gl.account_number, gl.account_description, invoice_id
FROM  general_ledger_accounts gl LEFT JOIN invoice_line_items il
         ON (gl.account_number = il.account_number);



--6.
--Print the account numbers and descriptions of general ledger accounts 
--   that were not used in any purchase

--answer
--run as ap user
SELECT gl.account_number, account_description
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items il 
      ON (gl.account_number = il.account_number)
WHERE invoice_id IS NULL;