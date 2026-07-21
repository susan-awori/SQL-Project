SELECT COUNT(*) AS Categories FROM CATEGORIES;

SELECT COUNT(*) AS Customers FROM CUSTOMERS;

SELECT COUNT(*) AS Employees FROM EMPLOYEES;

SELECT COUNT(*) AS Suppliers FROM SUPPLIERS;

SELECT COUNT(*) AS Products FROM PRODUCTS;

SELECT COUNT(*) AS Orders FROM ORDERS;

SELECT COUNT(*) AS OrderDetails FROM ORDER_DETAILS;

SELECT TOP 5 * FROM EMPLOYEES;

SELECT TOP 1 * FROM PRODUCTS;
GO

SELECT TOP 1 * FROM ORDERS;
GO

SELECT TOP 1 * FROM ORDER_DETAILS;
GO

SELECT TOP 1 * FROM SUPPLIERS;
GO

/*
Question 3
Display male employees whose net salary is >= 8000
*/

SELECT
    EMPLOYEE_int AS Employee_Number,
    FIRST_NAME,
    LAST_NAME,
    DATEDIFF(YEAR, BIRTH_DATE, GETDATE()) AS Age,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Seniority
FROM EMPLOYEES
WHERE TITLE = 'Mr.'
  AND (SALARY + ISNULL(COMMISSION, 0)) >= 8000
ORDER BY Seniority DESC;


/*
Question 4
Display products that meet the following criteria: (C1) quantity is packaged in bottle(s), 
(C2) the third character in the product name is 't' or 'T', (C3) supplied by suppliers 1, 2,
or 3, (C4) unit price ranges between 70 and 200, and (C5) units ordered are specified (not null). 
The resulting table should include the following columns: product number, product name, supplier 
number, units ordered, and unit price.*/
SELECT
    PRODUCT_REF,
    PRODUCT_NAME,
    SUPPLIER_int,
    UNITS_ON_ORDER,
    UNIT_PRICE
FROM PRODUCTS
WHERE LOWER(QUANTITY) LIKE '%bottle%'
    AND UPPER(SUBSTRING(PRODUCT_NAME, 3, 1)) = 'T'
    AND SUPPLIER_int IN (1, 2, 3)
    AND UNIT_PRICE BETWEEN 70 AND 200
    AND UNITS_ON_ORDER IS NOT NULL;

    /*
    Question 5
    Display customers who reside in the same region as supplier 1, meaning they share the
    same country, city, and the last three digits of the postal code. The query should 
    utilize a single subquery. The resulting table should include all columns from the customer table.*/

    SELECT *
FROM CUSTOMERS
WHERE COUNTRY = (
    SELECT COUNTRY
    FROM SUPPLIERS
    WHERE SUPPLIER_int = 1
)
AND CITY = (
    SELECT CITY
    FROM SUPPLIERS
    WHERE SUPPLIER_int = 1
)
AND RIGHT(POSTAL_CODE, 3) = (
    SELECT RIGHT(POSTAL_CODE, 3)
    FROM SUPPLIERS
    WHERE SUPPLIER_int = 1
);

/*
Question 6
For each order number between 10998 and 11003, do the following:  
-Display the new discount rate, which should be 0% if the total order amount before discount
(unit price * quantity) is between 0 and 2000, 5% if between 2001 and 10000, 10% if between 
10001 and 40000, 15% if between 40001 and 80000, and 20% otherwise.
-Display the message "apply old discount rate" if the order number is between 10000 and 10999,
and "apply new discount rate" otherwise. 
The resulting table should display the columns: order number, new discount rate, and discount 
rate application note.*/

SELECT
    ORDER_int,

    CASE
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 0 AND 2000 THEN '0%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 2001 AND 10000 THEN '5%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 10001 AND 40000 THEN '10%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 40001 AND 80000 THEN '15%'
        ELSE '20%'
    END AS NEW_DISCOUNT_RATE,

    CASE
        WHEN ORDER_int BETWEEN 10000 AND 10999
            THEN 'apply old discount rate'
        ELSE 'apply new discount rate'
    END AS DISCOUNT_NOTE

FROM ORDER_DETAILS
WHERE ORDER_int BETWEEN 10998 AND 11003
GROUP BY ORDER_int
ORDER BY ORDER_int;

