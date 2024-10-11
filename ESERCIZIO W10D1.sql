SELECT 
ProductKey AS 'Product Key'
, ProductAlternateKey AS 'Alternate Key'
, EnglishProductName AS 'Product Name'
, Color
, StandardCost AS 'Standard Cost'
, FinishedGoodsFlag AS 'Finished Goods'
FROM dimproduct
WHERE FinishedGoodsFlag=1;

SELECT 
ProductKey AS 'Product Key'
, ProductAlternateKey AS 'Alternate Key'
, EnglishProductName AS 'Product Name'
, Color
, StandardCost AS 'Standard Cost'
, ListPrice AS 'List Price'
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

SELECT 
ProductKey AS 'Product Key'
, ProductAlternateKey AS 'Alternate Key'
, EnglishProductName AS 'Product Name'
, Color
, StandardCost AS 'Standard Cost'
, ListPrice AS 'List Price'
, ListPrice - StandardCost AS 'Markup'
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

SELECT 
ProductKey AS 'Product Key'
, ProductAlternateKey AS 'Alternate Key'
, EnglishProductName AS 'Product Name'
, Color
, StandardCost AS 'Standard Cost'
, ListPrice AS 'List Price'
, FinishedGoodsFlag AS 'Finished Goods'
, ListPrice - StandardCost AS 'Markup'
FROM dimproduct
WHERE FinishedGoodsFlag=1 AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice; 

SELECT *
FROM dimemployee;

SELECT EmployeeKey, ParentEmployeeKey, FirstName, LastName, SalesPersonFlag
FROM dimemployee
WHERE SalesPersonFlag=1;

SELECT *
FROM factresellersales;

SELECT *, SalesAmount-TotalProductCost AS Profit
FROM factresellersales
WHERE ProductKey IN (597, 598, 477, 214) AND OrderDate >= '2020-01-01'
ORDER BY OrderDate;

