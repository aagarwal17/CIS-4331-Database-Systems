--Arun Agarwal

--Q1:
SELECT DISTINCT category_name
FROM categories_mgs c
WHERE category_id IN 
    (SELECT category_id
     FROM products_mgs p)
ORDER BY category_name;

--Q2:
SELECT product_name, (list_price*(1 - (discount_percent*.01))) AS actual_price
FROM products_mgs
WHERE (list_price*(1 - (discount_percent*.01))) >
    (SELECT AVG(list_price*(1 - (discount_percent*.01)))
     FROM products_mgs)
ORDER BY actual_price DESC;

--Q3:
SELECT category_id, category_name
FROM categories_mgs
WHERE category_id NOT IN
    (SELECT category_id
     FROM products_mgs);    

--Q4:
SELECT *
FROM
    (SELECT product_id, product_code, product_name, (list_price*(1 - (discount_percent*.01))) AS actual_price
     FROM products_mgs
     ORDER BY actual_price DESC)
WHERE ROWNUM <= 3;

--Q5:
SELECT *
FROM
    (SELECT p.product_id, p.product_code, p.product_name, c.category_name, (p.list_price*(1 - (p.discount_percent*.01))) AS actual_price
     FROM products_mgs p JOIN categories_mgs c
        ON p.category_id = c.category_id
     ORDER BY actual_price DESC)
WHERE ROWNUM <= 3;

--Q6:
SELECT *
FROM
    (SELECT c.category_id, COUNT(p.product_id) AS product_count
     FROM products_mgs p JOIN categories_mgs c
        ON p.category_id = c.category_id
     GROUP BY c.category_id
     ORDER BY product_count DESC)
WHERE ROWNUM <= 3;

--Q7:
SELECT product_name, discount_percent
FROM products_mgs
WHERE discount_percent IN
    (SELECT discount_percent
     FROM products_mgs
     GROUP BY discount_percent
     HAVING COUNT(*) = 1)
ORDER BY product_name ASC;

--Q8a:
SELECT e.email_address, o.order_id, SUM((i.item_price - i.discount_amount)*i.quantity) AS order_total
FROM customers_mgs e JOIN orders_mgs o
    ON e.customer_id = o.customer_id
    JOIN order_items_mgs i
    ON o.order_id = i.order_id
GROUP BY e.email_address, o.order_id
ORDER BY e.email_address ASC;

--Q8b:
WITH second_query AS
    (
        SELECT e.email_address, o.order_id, SUM((i.item_price - i.discount_amount)*i.quantity) AS order_total
        FROM customers_mgs e JOIN orders_mgs o
            ON e.customer_id = o.customer_id
            JOIN order_items_mgs i
            ON o.order_id = i.order_id
        GROUP BY e.email_address, o.order_id
        ORDER BY e.email_address ASC
    )    
SELECT email_address, MAX(order_total) AS max_order_total
FROM second_query
GROUP BY email_address
ORDER BY email_address ASC;