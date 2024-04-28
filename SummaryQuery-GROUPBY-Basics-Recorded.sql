--GROUP BY in summary query: Basics

--group a set of rows based on some criteria
-- summary per group

--GROUP BY one column

SELECT vendor_id, invoice_id
FROM invoices;

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
GROUP BY vendor_id;

--GROPU BY multiple columns
SELECT vendor_id, vendor_state, vendor_city
FROM vendors;

SELECT vendor_state, vendor_city, COUNT(*)
FROM vendors
GROUP BY vendor_state, vendor_city;


-- WHERE, GROUP BY
SELECT vendor_id, invoice_id, invoice_total
FROM invoices;

SELECT vendor_id, COUNT(*) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id;
