--HAVING in summary query: Basics & PitFall

--HAVING: filter to eliminate some groups of rows
--  filter applied AFTER grouping
--  typically used together with GROUP BY

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id
HAVING COUNT(*) > 2;


--HAVING can be placed before WHERE, GROUP BY, but it's not recommended.
SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
HAVING COUNT(*) > 2
GROUP BY vendor_id;

--can not use column alias in HAVING
SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id
HAVING invoice_quantity > 2
ORDER BY invoice_quantity;

--does not make sense without GROUP BY
SELECT COUNT(*) invoice_quantity
FROM invoices
HAVING COUNT(*) > 2;

SELECT COUNT(*) invoice_quantity
FROM invoices;

--HAVING with compound conditions 
SELECT vendor_id, COUNT(*) invoice_quantity, AVG(invoice_total), ROUND(AVG(invoice_total), 2)
FROM invoices
GROUP BY vendor_id
HAVING COUNT(*) > 2 AND AVG(invoice_total) > 1000
ORDER BY invoice_quantity;

--HAVING, GROUP BY multiple columns

SELECT vendor_state, vendor_city, COUNT(*)
FROM vendors
GROUP BY vendor_state, vendor_city
HAVING COUNT(*) > 2;


-- WHERE --> GROUP BY --> HAVING
-- WHERE filter: applied to individual rows  BEFORE grouping
-- HAVING filter: applied to groups of rows  AFTER grouping

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id;

SELECT vendor_id, invoice_id, invoice_total
FROM invoices;

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id;

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id
HAVING  COUNT(*) > 2;

--NO aggregate functions in WHERE
SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
WHERE invoice_total > 500 AND COUNT(*) > 2
GROUP BY vendor_id;

--NO column OUTSIDE SELECT list in HAVING
SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id
HAVING invoice_total > 500 AND COUNT(*) > 2;

--only (columns in SELECT list) in HAVING
SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id
HAVING vendor_id > 30 AND COUNT(*) > 2;