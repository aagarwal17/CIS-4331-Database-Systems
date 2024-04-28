--Murach Ch6 In class practice

--Q1 
--convert query below to a query containing a subquery.
SELECT DISTINCT vendor_name
FROM vendors v  JOIN invoices i ON (v.vendor_id = i.vendor_id)
ORDER BY vendor_name;

-- My Solution:
SELECT DISTINCT vendor_name
FROM vendors v
WHERE vendor_id IN
    (SELECT vendor_id
     FROM invoices i)
ORDER BY vendor_name;



--Q2
--print invoice numbers, invoice amounts of invoices with a payemnt amount more than
--   the average payment amount of all paid invoices.
--  paid invoice: customer made a payment.
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > 
    (SELECT AVG(payment_total)
     FROM invoices
     WHERE payment_total > 0);


--3.
--For each invoice that has more than one item, print its vendor name, invoice id, 
--  invoice number, and the item amount of each item in this invoice. 
--Do this using a subquery.

-- My final attempt:
--SELECT v.vendor_name, i.invoice_id, i.invoice_number, il.line_item_amt
--FROM vendors v JOIN invoices i
--    ON v.vendor_id = i.vendor_id
--    JOIN invoice_line_items il
--    ON i.invoice_id = il.invoice_id
--WHERE  < (SELECT COUNT(*)
--        FROM invoices i JOIN vendors v
--        ON i.vendor_id = v.vendor_id
--        JOIN invoice_line_items il
--        ON i.invoice_id = il.invoice_id
--        GROUP BY v.vendor_name);

SELECT vendor_name, i.invoice_id, invoice_number, line_item_amt
FROM vendors v JOIN  invoices i ON (v.vendor_id = i.vendor_id)
        JOIN invoice_line_items il ON (i.invoice_id = il.invoice_id)
WHERE   i.invoice_id IN
        (SELECT invoice_id
        FROM  invoice_line_items
        GROUP BY invoice_id
        HAVING COUNT(*) > 1);

-- Solution 2:
SELECT vendor_name, i.invoice_id, invoice_number, line_item_amt
FROM vendors v JOIN invoices i ON (v.vendor_id = i.vendor_id)
       JOIN invoice_line_items il ON (i.invoice_id = il.invoice_id)
WHERE  i.invoice_id   IN 
  (
    SELECT DISTINCT invoice_id
    FROM invoice_line_items
    WHERE  invoice_sequence > 1  
  );

--4.
--Print the name, city, and state of each vendor that's located in a unique city and state.
-- i.e. exclude vendors that have a city and state in common with another vendor.
--Do this using a subquery.
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE (vendor_city, vendor_state) IN 
 (
    SELECT vendor_city, vendor_state
    FROM  vendors
    GROUP BY vendor_city, vendor_state
    HAVING COUNT(*) = 1
 );
 
--Solution 2 using inline view
SELECT vendor_name, v1.vendor_city, v1.vendor_state
FROM vendors v1 JOIN 
   (
        SELECT vendor_city, vendor_state
        FROM  vendors
        GROUP BY vendor_city, vendor_state
        HAVING COUNT(*) = 1
    ) v2 
    ON (v1.vendor_city = v2.vendor_city AND v1.vendor_state = v2.vendor_state);

--Solution 3 using a different subquery
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE (vendor_city, vendor_state) NOT IN 
 (
    SELECT vendor_city, vendor_state
    FROM  vendors
    GROUP BY vendor_city, vendor_state
    HAVING COUNT(*) > 1
 );


--5.
--For the top 5 largest outstanding invoices with most balance due amounts, 
--  print their invoice ids, invoice numbers, vendor ids and balance dues.
--Do this using an inline view.
-- outstanding invoices: invoices whose balance dues are positive
--Solution and main query
--Version 1:
SELECT *
FROM  
  ( 
      SELECT invoice_id, invoice_number, vendor_id, 
            invoice_total - payment_total - credit_total balance_due
      FROM invoices
      WHERE invoice_total - payment_total - credit_total > 0
      ORDER BY balance_due DESC
  )
WHERE ROWNUM <= 5;

--Solution Version 2: use explicit inline view name
SELECT inv_sorted_by_balance_due.invoice_id,
    inv_sorted_by_balance_due.invoice_number,
    inv_sorted_by_balance_due.vendor_id,
    inv_sorted_by_balance_due.balance_due
FROM (
        SELECT invoice_id, invoice_number, vendor_id, 
               invoice_total - payment_total - credit_total balance_due
        FROM invoices
        WHERE invoice_total - payment_total - credit_total > 0
        ORDER BY balance_due DESC
     )   inv_sorted_by_balance_due  
WHERE ROWNUM <= 5;



--6.
--Redo Q5 using subquery factoring.
WITH invoice_summary AS
  ( 
      SELECT invoice_id, invoice_number, vendor_id, 
            invoice_total - payment_total - credit_total balance_due
      FROM invoices
      WHERE invoice_total - payment_total - credit_total > 0
      ORDER BY balance_due DESC
  )
SELECT *
FROM invoice_summary 
WHERE ROWNUM <= 5;
--Hint: subquery factoring structure:
--WITH name_for_subquery_resultset AS
--(subquery)
--SELECT ....
--FROM  ... name_for_subquery_resultset
--WHERE....;

