--Week 3, Murach Ch4
--In Class Practice, Questions & Answers

--INNER JOIN, SELF-JOIN

--1.
--Print the vendor name, invoice number, invoice date, and balance due amount
-- for each vendor and each of its invoices that have a non-zero remaining balance.
-- Display the heading for the remaing balance as REMAINING_BALANCE,
-- Sort the query result in the increasing order of remaining balances.
SELECT v.vendor_name, i.invoice_number, i.invoice_date, (i.invoice_total - i.payment_total - i.credit_total) AS REMAINING_BALANCE
FROM vendors v INNER JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE (i.invoice_total - i.payment_total - i.credit_total) <> 0
ORDER BY REMAINING_BALANCE ASC;


--2.
--Print all vendors' names, their invoices' invoice dates and invoice numbers, and 
--  the sequence numbers and item amounts of all items in their invoices.
-- Sort the result first by vendor name, then by invoice date, then by invoice number,
--    then by invoice sequence number. All sorting are in increasing orders.
SELECT v.vendor_name, i.invoice_date, i.invoice_number, il.invoice_sequence, il.line_item_amt
FROM vendors v INNER JOIN invoices i ON (v.vendor_id = i.vendor_id)
               INNER JOIN invoice_line_items il
               ON (i.invoice_id = il.invoice_id)
ORDER BY v.vendor_name, i.invoice_date, i.invoice_number, il.invoice_sequence ASC;


--3.
--Print the vendor ids, vendor names, vendor contact first and last names of vendors that 
--   share the same contact last names as another vendor.
--Print the vendor contact's first and last name in this format:
--    Steve Jobs
--Print the heading for the vendor contact's first and last name as Contact Name.
SELECT v1.vendor_id, v1.vendor_name, v1.vendor_contact_first_name || ' ' || v1.vendor_contact_last_name AS "Contact Name"
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_contact_last_name = v2.vendor_contact_last_name
WHERE v1.vendor_contact_first_name || ' ' || v1.vendor_contact_last_name != v2.vendor_contact_first_name || ' ' || v2.vendor_contact_last_name;

--COULD ALSO WRITE INSTEAD OF WHERE LINE:
--(AND v1.vendor_id <> v2.vendor_id);
     
     
