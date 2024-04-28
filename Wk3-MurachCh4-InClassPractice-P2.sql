--Week 3, Part 2 
--Murach Ch4, In Class Practice

--Covered topics: Self Join, OUTER JOIN

--Continued from Lec 5.


--4
--Print the names of employees in department 30 and the names of their managers. 
SELECT e1.ename, e2.ename
FROM emp e1 JOIN emp e2
    ON e1.mgr = e2.empno
WHERE e1.deptno = 30;


--5
--Print all general ledger accounts' numbers, descriptions, the invoice ids of invoices 
--where the accounts were used.
--The query result also includes accounts that were not used in any purchase. 
SELECT gl.account_number, gl.account_description, il.invoice_id
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items il
    ON gl.account_number = il.account_number;


--6.
--Print the account numbers and descriptions of general ledger accounts 
--   that were not used in any purchase
SELECT gl.account_number, gl.account_description
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items il
    ON gl.account_number = il.account_number
WHERE invoice_id IS NULL;
