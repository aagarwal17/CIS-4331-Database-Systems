--Summary Query - Complex Examples

--JOIN and Summary Query

SELECT *
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id;

SELECT vendor_name, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500
--ORDER BY AVG(invoice_total) DESC;
ORDER BY invoice_qty DESC;

-- WHERE clause and HAVING clause in summary query
--Compound condition in HAVING

--condition in HAVING
SELECT 
   invoice_date,
   COUNT(*) AS invoice_qty,
   SUM(invoice_total) AS invoice_sum
FROM invoices
GROUP BY invoice_date
HAVING invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
   AND COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

--special case: condition in HAVING can also be in WHERE because condition uses GROUP BY column
SELECT 
   invoice_date,  
   COUNT(*) AS invoice_qty,  
   SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY invoice_date
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

--condition can ONLY be in WHERE, NOT HAVING
SELECT 
   vendor_id,
   COUNT(*) AS invoice_qty,
   SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY vendor_id
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY SUM(invoice_total)  DESC;

--condition can ONLY be in WHERE, NOT HAVING
SELECT 
   vendor_id,
   COUNT(*) AS invoice_qty,
   SUM(invoice_total) AS invoice_sum
FROM invoices
--WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY vendor_id
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100 AND invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
ORDER BY SUM(invoice_total)  DESC;


--invoice_total column is not allowed in SELECT list because it's not GROUP BY column
SELECT 
   vendor_id, invoice_total,
   COUNT(*) AS invoice_qty,
   SUM(invoice_total) AS invoice_sum
FROM invoices
--WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY vendor_id
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100 --AND invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
ORDER BY SUM(invoice_total)  DESC;