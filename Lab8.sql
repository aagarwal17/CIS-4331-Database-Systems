-- Lab8
-- Arun Agarwal

--Q1:
INSERT INTO categories_mgs
VALUES (5, 'Percussion');

COMMIT;

--Q2:
UPDATE categories_mgs
SET category_name = 'String'
WHERE category_id = 5;

--Q3:
DELETE FROM categories_mgs 
WHERE category_name = 'String';

--Q4:
INSERT INTO products_mgs (product_id, category_id, 
        product_code, product_name, description, 
        list_price, discount_percent, date_added)
VALUES (11, 4, 'YDP162R', 
    'Yamaha Arius YDP162R Traditional Console Style Digital Piano',
    'The best keyboard on the market. Offers excellent sound rendering
 that truly separates it from the rest of the pack.',
    1599.99, 10, SYSDATE);

--Q5:
DELETE FROM products_mgs
WHERE category_id = 4;

DELETE FROM categories_mgs
WHERE category_id = 4;

ROLLBACK;

--Q6:
INSERT INTO customers_mgs (customer_id, email_address,
        password, first_name, last_name)
VALUES (9, 'john@yahoo.com', 'funny', 'John', 'Oliver');

--Q7:
UPDATE customers_mgs
SET password = 'hello';

--Q8:
UPDATE customers_mgs
SET password = 'excellent'
WHERE customer_id IN (
    SELECT customer_id
    FROM orders_mgs
    GROUP BY customer_id
    HAVING COUNT(*) > 1);

--Q9:
ROLLBACK;


--Q10:
-- Completed: Open the script named create_mgs_tables.sql and run this script.
-- Complted: Rerun the script will make sure that the data in the database are 
-- restored for future labs.
-- Note: needed to modify script because Professor forgot that she had us
-- not install a mgs database but rather have everything be placed under one
-- database. Nonetheless, process was completed successfully.

--Q11:
CREATE TABLE menu
(
  menu_id       NUMBER          PRIMARY KEY,
  description   VARCHAR2(100),   
  menu_type     VARCHAR2(50)
);

CREATE TABLE event
(
  event_id      NUMBER          PRIMARY KEY,
  event_date    DATE,            
  location      VARCHAR2(50),
  menu_id       NUMBER          REFERENCES menu (menu_id)
);

--Q12:
DROP TABLE event;
DROP TABLE menu;

--Q13:
CREATE INDEX event_date_ix 
ON event (event_date);

--Q14:
CREATE SEQUENCE menu_id_seq;

--Q15:
INSERT INTO menu
VALUES (menu_id_seq.NEXTVAL, 'Menu 1 for vegetarians', 'Vegetarian');
