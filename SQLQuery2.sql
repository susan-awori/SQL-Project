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

    