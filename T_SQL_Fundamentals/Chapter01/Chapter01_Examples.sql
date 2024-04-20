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