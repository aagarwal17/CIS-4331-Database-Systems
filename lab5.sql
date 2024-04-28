--Lab 5

--Arun Agarwal

-- Q1:
SELECT COUNT(order_id) AS order_count, SUM(tax_amount) AS total_tax
FROM orders_mgs;

-- Q2:
SELECT COUNT(card_type) AS visa_order_count, SUM(tax_amount) AS visa_total_tax
FROM orders_mgs
WHERE card_type = 'Visa';

-- Q3:
SELECT card_type, COUNT(card_type) AS card_order_count, SUM(tax_amount) AS card_total_tax
FROM orders_mgs
GROUP BY card_type;

-- Q4:
SELECT c.category_name, COUNT(product_id) AS product_count, MAX(list_price) AS highest_listing_price, MIN(list_price) AS lowest_listing_price
FROM products_mgs p JOIN categories_mgs c
    ON p.category_id = c.category_id
GROUP BY c.category_name;

-- Q5:
SELECT c.category_name, COUNT(product_id) AS product_count_over$400, MAX(list_price) AS highest_listing_price_over$400, MIN(list_price) AS lowest_listing_price_over$400
FROM products_mgs p JOIN categories_mgs c
    ON p.category_id = c.category_id
WHERE list_price > 400
GROUP BY c.category_name;

-- Q6:
SELECT card_type, COUNT(card_type) AS hot_card_order_count, SUM(tax_amount) AS hot_card_total_tax
FROM orders_mgs
GROUP BY card_type
HAVING COUNT(card_type) >= 2;

-- Q7:
SELECT c.category_name, COUNT(product_id) AS hot_cat_product_count, MAX(list_price) AS hot_cat_highest_listing_price, MIN(list_price) AS hot_cat_lowest_listing_price
FROM products_mgs p JOIN categories_mgs c
    ON p.category_id = c.category_id
GROUP BY c.category_name
HAVING COUNT(product_id) >= 3;

-- Q8:
SELECT card_type, COUNT(card_type) AS hot_card_order_count, SUM(tax_amount) AS hot_card_total_tax
FROM orders_mgs
WHERE order_date > '30-MAR-12'
GROUP BY card_type
HAVING COUNT(card_type) >= 2;
