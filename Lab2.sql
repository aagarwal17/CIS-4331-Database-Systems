--Lab 2
--Arun Agarwal

--Q1:
SELECT Product_Id, Product_Name, Discount_Percent
FROM Products_Mgs
ORDER BY discount_percent ASC, Product_Id ASC;

--Q2:
SELECT Last_Name || ', ' || First_Name AS "Customer Name"
FROM Customers_Mgs
WHERE Last_Name BETWEEN 'B' AND 'T'
Order By Last_Name DESC;
--Q3:
SELECT Product_Code, Discount_Percent, Date_Added
FROM Products_Mgs
WHERE Discount_Percent BETWEEN 20 AND 30
ORDER BY Date_Added DESC;
--Q4:
SELECT Product_Name || ' was $' || List_Price || ', now is $' || (List_Price * (1 - (Discount_Percent/100))) AS "Product Price Info"
FROM Products_Mgs
WHERE rownum <= 3
ORDER BY (List_Price * (1 - (Discount_Percent/100))) DESC;
--Q5:
SELECT Item_Id, Item_Price, Discount_Amount, (Item_Price*Quantity) AS "TOTAL_PRICE_BEFORE_DISCOUNT",(Discount_Amount*Quantity) AS "TOTAL_DISCOUNT_AMOUNT"
FROM Order_Items_Mgs
WHERE (Discount_Amount*Quantity) > 600
ORDER BY "TOTAL_DISCOUNT_AMOUNT" DESC;
--Q6:
SELECT Order_Id, Customer_Id, Order_Date, Ship_Amount
FROM Orders_Mgs
WHERE SHIP_DATE IS NULL;
--Q7:
SELECT ('Hello! Today is ' || TO_CHAR(sysdate, 'Mon-DD-YYYY')) AS GREETING
FROM dual;
--Q8:
SELECT 799.99 AS PRICE_BEFORE_TAX, 0.08 AS TAX_RATE, 799.99*0.08 AS TAX_AMOUNT, 799.99*1.08 AS PRICE_AFTER_TAX
FROM dual;
--Q9:
SELECT DISTINCT Product_Id, Item_Price, Discount_Amount
FROM Order_Items_Mgs
ORDER BY Item_Price DESC;
