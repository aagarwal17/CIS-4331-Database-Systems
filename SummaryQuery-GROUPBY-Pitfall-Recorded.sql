--GROUP BY in summary query: pitfall

--GROUP BY restrict what can be in SELECT, only the following:
--   aggregation functions
--   expression in GROUP BY
--   expressions involving GROUP BY columns
--   constant values
--   expression resulting in a constant value


--   aggregation functions
--   expression in GROUP BY
SELECT  vendor_id, COUNT(invoice_id) invoice_quantity
FROM invoices
GROUP BY vendor_id
ORDER BY invoice_quantity;

--   expressions involving GROUP BY columns
SELECT vendor_city || ', ' || vendor_state vendro_loc, COUNT(*)
FROM vendors
GROUP BY  vendor_state, vendor_city --, vendor_city || ', ' || vendor_state 
ORDER BY  vendor_state, vendor_city;


-- constant value
SELECT  'Vendor ', vendor_id, COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id
ORDER BY vendor_id;

----expression resulting in a constant value
SELECT 3+5, vendor_id, COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id
ORDER BY vendor_id;


--invoice_total not allowed here, it's not any of the following:
--   aggregation functions
--   expression in GROUP BY
--   expressions involving GROUP BY columns
--   constant values
--   expression resulting in a constant value
SELECT  vendor_id, invoice_total, COUNT(invoice_id) invoice_quantity
FROM invoices
GROUP BY vendor_id
ORDER BY invoice_quantity;


--NO column alias in GROUP BY: related query
SELECT 'Vendor ' || vendor_id "Vendor", COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY vendor_id 
ORDER BY vendor_id;

--NO column alias in GROUP BY
SELECT  'Vendor ' || vendor_id "Vendor", COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY "Vendor" 
ORDER BY "Vendor";

--ok
SELECT  'Vendor ' || vendor_id "Vendor", COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY 'Vendor ' || vendor_id
ORDER BY "Vendor";

--ok
SELECT  'Vendor ' || vendor_id "Vendor", COUNT(invoice_id) invoice_quantity
FROM invoices
WHERE invoice_total > 500
GROUP BY 'Vendor ' || vendor_id 
ORDER BY 'Vendor ' || vendor_id; 


