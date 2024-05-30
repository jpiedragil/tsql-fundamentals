-- Example 1
USE TSQLV6;

SELECT
    empid
    , YEAR(orderdate) AS orderyear
    , COUNT(*) AS numorders
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate)
HAVING
    COUNT(*) > 1
ORDER BY
    empid, orderyear;

--  Example 2
SELECT
    orderid
    , custid
    , empid
    , orderdate
    , freight
FROM
    Sales.Orders;

-- Example 3
SELECT
    orderid
    , empid
    , orderdate
    , freight
FROM
    Sales.Orders
WHERE
    custid = 71;

--Example 4
SELECT
    empid
    , YEAR(orderdate) AS orderyear
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate);

-- Example 5
SELECT
  empid
  , YEAR(orderdate) AS orderyear
  , SUM(freight) AS totalfreight
  , COUNT(*) AS numorders
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate);

-- Example 6
SELECT
    empid
    , YEAR(orderdate) AS orderyear
    , freight
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate);

-- Example 7
SELECT
  empid
  , YEAR(orderdate) AS orderyear
  , COUNT(DISTINCT custid) AS numcusts
FROM
    Sales.Orders
GROUP BY
    empid, YEAR(orderdate);

-- Example 8
SELECT
    orderid
    , YEAR(orderdate) AS orderyear
FROM
    Sales.Orders
WHERE
    orderyear > 2021;

-- Example 9
SELECT
    empid
    , YEAR(orderdate) AS orderyear
    , COUNT(*) AS numorders
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate)
HAVING
    numorders > 1;

-- Example 10
SELECT
    empid
    , YEAR(orderdate) AS orderyear
FROM 
    Sales.Orders
WHERE
    custid = 71;

-- Example 11
SELECT
    DISTINCT empid, YEAR(orderdate) AS orderyear
FROM
    Sales.Orders
WHERE
    custid = 71;

-- Example 12: Throws an error
SELECT
    orderid
    , YEAR(orderdate) AS orderyear
    , orderyear + 1 AS nextyear
FROM
    Sales.Orders;

-- Example 12a: Corrects error.
SELECT
    orderid
    , YEAR(orderdate) AS orderyear
    , YEAR(orderdate) + 1 AS nextyear
FROM
    Sales.Orders;

-- Example 13
SELECT empid
    , YEAR(orderdate) AS orderyear
    , COUNT(*) AS numorders
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid, YEAR(orderdate)
    HAVING COUNT(*) > 1
ORDER BY
    empid, orderyear;

-- Example 14: Throws an error.
SELECT
    DISTINCT country
FROM
    HR.Employees
ORDER BY
    empid;

--------------------------------------------------------------------------------
-- TOP Filter
--------------------------------------------------------------------------------

-- Example 15: TOP
SELECT
    TOP (5) orderid
    , orderdate
    , custid
    , empid
FROM
    Sales.Orders
ORDER BY
   orderdate DESC;

-- Example 16: TOP PERCENT
SELECT 
    TOP (1) PERCENT orderid
    , orderdate
    , custid
    , empid
FROM
    Sales.Orders
ORDER BY
    orderdate DESC;

-- Example 17: TOP
SELECT 
    TOP (5) orderid
    , orderdate
    , custid
    , empid
FROM
    Sales.Orders
ORDER BY
    orderdate DESC
    , orderid DESC;

-- Example 18: TOP
SELECT
    TOP (5) WITH TIES orderid
    , orderdate
    , custid, empid
FROM
    Sales.Orders
ORDER BY
    orderdate DESC;

--------------------------------------------------------------------------------
-- OFFSET-FETCH Filter
--------------------------------------------------------------------------------

-- Example 19
SELECT
    orderid
    , orderdate
    , custid
    , empid
FROM
    Sales.Orders
ORDER BY
    orderdate, orderid
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

--------------------------------------------------------------------------------
-- Windows Functions
--------------------------------------------------------------------------------

-- Example 20
SELECT
    orderid
    , custid
    , val
    , ROW_NUMBER() OVER(
        PARTITION BY custid
        ORDER BY val
    ) AS rownum
FROM
    Sales.OrderValues
ORDER BY
    custid, val;

--------------------------------------------------------------------------------
-- Predicates and operators
--------------------------------------------------------------------------------

-- Example 21: The IN predicate
SELECT
    orderid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    orderid IN(10248, 10249, 10250);

-- Example 22: The BETWEEN predicate.
SELECT
    orderid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    orderid BETWEEN 10300 AND 10310;

-- Example 23: The LIKE predicate.
SELECT
    empid
    , firstname
    , lastname
FROM
    HR.Employees
WHERE
    lastname LIKE N'D%';

-- Example 23: Comparison operators.
SELECT
    orderid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    orderdate >= '20220101';

-- Example 24: Comparison operators.
SELECT
    orderid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    orderdate >= '20220101'
    AND empid NOT IN(1, 3, 5);

-- Example 25: Arithmetic operators.
SELECT
    orderid
    , productid
    , qty
    , unitprice
    , discount
    , qty * unitprice * (1 - discount) AS val
FROM
    Sales.OrderDetails;

-- Example 26: Operator's precedence.
SELECT
    orderid
    , custid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    custid = 1
    AND empid IN(1, 3, 5)
    OR  custid = 85
    AND empid IN (2, 4, 6);

-- Example 27: Example 26 rewritten for clarity.
SELECT 
    orderid
    , custid
    , empid
    , orderdate
FROM
    Sales.Orders
WHERE
    (
        custid = 1
        AND empid IN(1, 3, 5)
    )
    OR
    (
        custid = 85
        AND empid IN(2, 4, 6)
    );

--------------------------------------------------------------------------------
-- Case expressions
--------------------------------------------------------------------------------

-- Example 27
SELECT
    supplierid
    , COUNT(*) AS numproducts
    , CASE COUNT(*) % 2
        WHEN 0 THEN 'Even'
        WHEN 1 THEN 'Odd'
        ELSE 'Unknown'
        END AS countparity
FROM
    Production.Products
GROUP BY
    supplierid;

-- Example 28
SELECT
    orderid
    , custid
    , val
    , CASE
        WHEN val < 1000.00  THEN 'Less than 1000'
        WHEN val <= 3000.00 THEN 'Between 1000 and 3000'
        WHEN val > 3000.00  THEN 'More than 3000'
        ELSE 'Unknown'
        END AS valuecategory
FROM
    Sales.OrderValues;

--------------------------------------------------------------------------------
-- NULLs
--------------------------------------------------------------------------------

-- Example 29
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region = N'WA';

-- Example 30
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region IS NOT DISTINCT FROM N'WA';

-- Example 31
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region <> N'WA';

-- Example 32
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region = NULL;

-- Example 33
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region IS NULL;

-- Example 34
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region <> N'WA'
    OR region IS NULL;

-- Example 35
SELECT
    custid
    , country
    , region
    , city
FROM
    Sales.Customers
WHERE
    region IS DISTINCT FROM N'WA';

--------------------------------------------------------------------------------
-- The GREATEST and LEAST functions.
--------------------------------------------------------------------------------

-- Example 36
SELECT
    orderid
    , requireddate
    , shippeddate
    , GREATEST(requireddate, shippeddate) AS latestdate
    , LEAST(requireddate, shippeddate) AS earliestdate
FROM
    Sales.Orders
WHERE
    custid = 8;

-- Example 37
SELECT
    orderid
    , requireddate
    , shippeddate
    , CASE
        WHEN requireddate > shippeddate OR shippeddate IS NULL THEN requireddate
        ELSE shippeddate
        END AS latestdate
    , CASE
        WHEN requireddate < shippeddate OR shippeddate IS NULL THEN requireddate
        ELSE shippeddate
        END AS earliestdate
FROM
    Sales.Orders
WHERE
    custid = 8;


-- Example 38
SELECT
    orderid
    , requireddate
    , shippeddate
    , CASE
        WHEN requireddate > shippeddate OR shippeddate IS NULL THEN requireddate
        ELSE shippeddate
      END AS latestdate,
    CASE
        WHEN requireddate < shippeddate OR shippeddate IS NULL THEN requireddate
        ELSE shippeddate
    END AS earliestdate
FROM
    Sales.Orders
WHERE
    custid = 8;

--------------------------------------------------------------------------------
-- All-at-once operations.
--------------------------------------------------------------------------------

-- Example 39
SELECT
  orderid
  , YEAR(orderdate) AS orderyear
  , orderyear + 1 AS nextyear
FROM
    Sales.Orders;

--------------------------------------------------------------------------------
-- Working with character data.
--------------------------------------------------------------------------------

-- Example 40
SELECT
    name
    , description
FROM
    sys.fn_helpcollations();

-- Example 41
SELECT
    empid
    , firstname
    , lastname
FROM
    HR.Employees
WHERE
    lastname = N'davis';

-- Example 42
SELECT 
    empid
    , firstname
    , lastname
FROM
    HR.Employees
WHERE
    lastname COLLATE Latin1_General_CS_AS = N'davis';

--------------------------------------------------------------------------------
-- String concatenation (plus-sign [+] operator and CONCAT and CONCAT_WS 
-- functions)
--------------------------------------------------------------------------------

-- Example 43
SELECT 
    empid
    , firstname + N' ' + lastname AS fullname
FROM
    HR.Employees;

-- Example 44
SELECT
    custid
    , country
    , region
    , city
    , country + N',' + region + N',' + city AS location
FROM
    Sales.Customers;

-- Example 45
SELECT
    custid
    , country
    , region
    , city,
    country + COALESCE(N',' + region, N'') + N',' + city AS location
FROM
    Sales.Customers;

-- Example 46
SELECT
    custid
    , country
    , region
    , city
    , CONCAT(country, N',' + region, N',' + city) AS location
FROM
    Sales.Customers;

-- Example 47
SELECT
    custid
    , country
    , region
    , city
    , CONCAT_WS(N',', country, region, city) AS location
FROM
    Sales.Customers;

--------------------------------------------------------------------------------
-- The SUBSTRING function
--------------------------------------------------------------------------------

-- Example 48
SELECT SUBSTRING('abcde', 1, 3);

--------------------------------------------------------------------------------
-- The LEFT and RIGHT functions.
--------------------------------------------------------------------------------

-- Example 49
SELECT RIGHT('abcde', 3);

--------------------------------------------------------------------------------
-- The LEN and DATALENGTH functions
--------------------------------------------------------------------------------

-- Example 50
SELECT LEN(N'abcde');

-- Example 51
SELECT DATALENGTH(N'abcde');

--------------------------------------------------------------------------------
-- The CHARINDEX function
--------------------------------------------------------------------------------

-- Example 52
SELECT CHARINDEX(' ', 'Itzik Ben-Gan');

--------------------------------------------------------------------------------
-- The CHARINDEX function
--------------------------------------------------------------------------------

-- Example 53
SELECT PATINDEX('%[0-9]%', 'abcd123efgh');

--------------------------------------------------------------------------------
-- The REPLACE function
--------------------------------------------------------------------------------

-- Example 54
SELECT REPLACE('1-a 2-b', '-', ':');

-- Example 55
SELECT
    empid
    , lastname
    , LEN(lastname) - LEN(REPLACE(lastname, 'e', '')) AS numoccur
FROM
    HR.Employees;

--------------------------------------------------------------------------------
-- The TRANSLATE function
--------------------------------------------------------------------------------

-- Example 56
SELECT REPLACE(REPLACE('123.456.789,00', '.', ','), ',', '.');

-- Example 57
SELECT REPLACE(REPLACE(REPLACE('123.456.789,00', '.', '~'), ',', '.'), '~', ',');

-- Example 58
SELECT TRANSLATE('123.456.789,00', '.,', ',.');

--------------------------------------------------------------------------------
-- The REPLICATE function
--------------------------------------------------------------------------------

-- Example 59
SELECT REPLICATE('abc', 3);

-- Example 60
SELECT
    supplierid
    , RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
FROM
    Production.Suppliers;

--------------------------------------------------------------------------------
-- The STUFF function
--------------------------------------------------------------------------------

-- Example 61
SELECT STUFF('xyz', 2, 1, 'abc');

--------------------------------------------------------------------------------
-- The UPPER and LOWER functions
--------------------------------------------------------------------------------

-- Example 62
SELECT UPPER('Itzik Ben-Gan');

-- Example 63
SELECT LOWER('Itzik Ben-Gan');

--------------------------------------------------------------------------------
-- The RTRIM, LTRIM, and TRIM functions
--------------------------------------------------------------------------------

-- Example 64
SELECT RTRIM(LTRIM('   abc   '));

-- Example 65
SELECT TRIM('   abc   ');

-- Example 65
SELECT
    TRANSLATE(TRIM(TRANSLATE(TRIM(TRANSLATE(
    '//\\ remove leading and trailing backward (\) and forward (/) slashes \\//',
    ' /', '~ ')), ' \', '^ ')), ' ^~', '\/ ')
    AS outputstring;

-- Example 66
SELECT TRIM( '/\'
        FROM '//\\ remove leading and trailing backward (\) and forward (/) slashes \\//' )
       AS outputstring;
