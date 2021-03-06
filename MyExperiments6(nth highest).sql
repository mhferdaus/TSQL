use AdventureWorksLT2012;

SELECT * FROM HumanResources.EmployeePayHistory ORDER BY Rate DESC;

SELECT TOP 1 Rate FROM
(SELECT DISTINCT TOP 3 Rate
FROM HumanResources.EmployeePayHistory
ORDER BY Rate DESC)
RESULT
ORDER BY Rate;

-- using denserank

WITH TEMP AS
(
  SELECT Rate, DENSE_RANK() OVER (ORDER BY Rate DESC) AS DENSERANK
  FROM HumanResources.EmployeePayHistory
)
SELECT TOP 1 Rate
FROM TEMP
WHERE TEMP.DENSERANK = 3;

-- using rowcount ( warning duplicate rate would not work )

WITH TEMP AS
(
  SELECT Rate, ROW_NUMBER() OVER (ORDER BY Rate DESC) AS ROWNUMBER
  FROM HumanResources.EmployeePayHistory
)
SELECT TOP 1 Rate
FROM TEMP
WHERE TEMP.ROWNUMBER = 3;

-- using subquery

-- for second highest salary
SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory
WHERE Rate < ( SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory);


-- for third highest salary
SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory
WHERE Rate <
(SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory
WHERE Rate < ( SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory));

