SELECT 
   invoice_date,  
   COUNT(*) AS invoice_qty,  
   SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY invoice_date
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC
