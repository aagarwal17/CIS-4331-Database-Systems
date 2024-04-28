--Ch7 Practice, Questions and Answers

--Q1
--For vendors with default terms id 2, 
-- change the terms ids of their invoices to 2.

--change invoices table

--subquery
---print ids of vendors with default terms id 2, 
SELECT  vendor_ID
FROM  vendors
WHERE default_terms_id = 2;

--main action query and solution
--use the copy of the table instead of original table to avoid data messup
UPDATE invoices_copy
SET terms_id = 2
WHERE  vendor_id IN 
   (
    SELECT vendor_id
    FROM  vendors
    WHERE  default_terms_id = 2
   );


--Q2
--Undo the changes made in Q1
ROLLBACK;


--Q3
--Make the changes in Q1 permanent 
--Just rerun the first query, then run:
COMMIT;


