CREATE SCHEMA ESERCIZIO_2_PRODOTTI;
USE ESERCIZIO_2_PRODOTTI;

CREATE TABLE PRODOTTI (
IDProdotto INT
, NomeProdotto VARCHAR(100)
, Prezzo DECIMAL(10,2)
, CONSTRAINT PK_PRODOTTI PRIMARY KEY (IDProdotto));

ALTER TABLE PRODOTTI
MODIFY Prezzo DECIMAL (10,2);

CREATE TABLE CLIENTI (
IDCliente INT
, Nome VARCHAR(50)
, Email VARCHAR(100)
, CONSTRAINT PK_CLIENTI PRIMARY KEY (IDCliente));

CREATE TABLE ORDINE (
IDOrdine INT
, IDProdotto INT
, IDCliente INT
, Quantità INT
, CONSTRAINT PK_ORDINE PRIMARY KEY (IDOrdine)
, CONSTRAINT FK_CLIENTI_ORDINE FOREIGN KEY (IDCliente)
REFERENCES CLIENTI (IDCliente)
, CONSTRAINT FK_PRODOTTI_ORDINE FOREIGN KEY (IDProdotto)
REFERENCES PRODOTTI (IDProdotto));

CREATE TABLE DETTAGLIO_ORDINE (
IDOrdine INT
, IDProdotto INT
, IDCliente INT
, PrezzoTotale DECIMAL(10,2)
, CONSTRAINT PK_IDOrdine_IDProdotto_IDCliente PRIMARY KEY (IDOrdine, IDProdotto, IDCliente)
, CONSTRAINT FK_CLIENTI_DETTAGLIO_ORDINE FOREIGN KEY (IDCliente)
REFERENCES CLIENTI (IDCliente)
, CONSTRAINT FK_PRODOTTI_DETTAGLIO_ORDINE FOREIGN KEY (IDProdotto)
REFERENCES PRODOTTI (IDProdotto)
, CONSTRAINT FK_ORDINE_DETTAGLIO_ORDINE FOREIGN KEY (IDOrdine)
REFERENCES ORDINE (IDOrdine));

INSERT INTO PRODOTTI VALUES
(1, 'Tablet', '300.00')
, (2, 'Mouse', '20.00')
, (3, 'Tastiera', '25.00')
, (4, 'Monitor', '180.00')
, (5, 'HHD', '90.00')
, (6, 'SSD', '200.00')
, (7, 'RAM', '100.00')
, (8, 'Router', '80.00')
, (9, 'Webcam', '45.00')
, (10, 'GPU', '1250.00')
, (11, 'Trackpad', '500.00')
, (12, 'Techmagazine', '5.00')
, (13, 'Martech', '50.00');

INSERT INTO ORDINE VALUES
(1, 2, NULL, 10)
, (2, 6, NULL, 2)
, (3, 5, NULL, 3)
, (4, 1, NULL, 1)
, (5, 9, NULL, 1)
, (6, 4, NULL, 2)
, (7, 11, NULL, 6)
, (8, 10, NULL, 2)
, (9, 3, NULL, 3)
, (10, 3, NULL, 1)
, (11, 2, NULL, 1);

INSERT INTO CLIENTI VALUES
(1, 'Antonio', NULL)
, (2, 'Battista', 'battista@mailmail.it')
, (3, 'Maria', 'maria@posta.it')
, (4, 'Franca', 'franca@lettere.it')
, (5, 'Ettore', NULL)
, (6, 'Arianna', 'arianna@posta.it')
, (7, 'Piero', 'piero@lavoro.it');


SELECT *
FROM PRODOTTI;

SELECT * 
FROM ORDINE;

SELECT *
FROM CLIENTI;


-- ESERCIZIO W10D4 
SELECT ProductKey, s.ProductSubcategoryKey, EnglishProductName, s.EnglishProductSubcategoryName
FROM dimproduct AS p 
INNER JOIN dimproductsubcategory AS s
ON s.ProductSubcategoryKey = p.ProductSubcategoryKey;

SELECT p.EnglishProductName, s.EnglishProductSubcategoryName, c.EnglishProductCategoryName
FROM dimproduct AS p
LEFT OUTER JOIN dimproductsubcategory AS s
ON s.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory AS c
ON s.ProductCategoryKey = c.ProductCategoryKey;

SELECT DISTINCT p.ProductKey, p.EnglishProductName, s.SalesOrderNumber
FROM dimproduct AS p
INNER JOIN factresellersales AS s
ON p.ProductKey = s.ProductKey;

SELECT p.ProductKey, p.EnglishProductName, s.ProductKey, FinishedGoodsFlag
FROM dimproduct AS p 
LEFT OUTER JOIN factresellersales AS s
ON p.ProductKey = s.ProductKey
WHERE s.ProductKey IS NULL AND p.FinishedGoodsFlag = 1;

SELECT p.EnglishProductName, s.*
FROM factresellersales AS s
INNER JOIN dimproduct AS p
ON s.ProductKey = p.ProductKey

SELECT p.EnglishProductName, c.EnglishProductCategoryName, s.*
FROM factresellersales AS s
LEFT OUTER JOIN dimproduct AS p
ON s.ProductKey = p.ProductKey
LEFT OUTER JOIN dimproductsubcategory AS sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory AS c
ON sc.ProductCategoryKey = c.ProductCategoryKey;

SELECT *
FROM dimreseller;

SELECT r.ResellerKey, r.ResellerName, g.GeographyKey, g.EnglishCountryRegionName
FROM dimreseller AS r
INNER JOIN dimgeography AS g
ON r.GeographyKey = g.GeographyKey;

SELECT s.SalesOrderNumber, s.SalesOrderLineNumber, s.OrderDate, s.UnitPrice, s.OrderQuantity, s.TotalProductCost, p.EnglishProductName, c.EnglishProductCategoryName, r.ResellerName, g.EnglishCountryRegionName
FROM factresellersales AS s
INNER JOIN dimproduct AS p
ON s.ProductKey = p.ProductKey
INNER JOIN dimproductsubcategory AS sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
INNER JOIN dimproductcategory AS c
ON sc.ProductCategoryKey = c.ProductCategoryKey
INNER JOIN dimreseller AS r
ON s.ResellerKey = r.ResellerKey
INNER JOIN dimgeography AS g
ON r.GeographyKey = g.GeographyKey;


-- ESERCIZIO W11D1
SELECT ProductKey, COUNT(*)
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;

SELECT SalesOrderNumber, SalesOrderLineNumber, COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) > 1;

SELECT OrderDate, COUNT(DISTINCT SalesOrderNumber) AS Num_Transazioni
FROM factresellersales
WHERE YEAR(OrderDate) >= 2020
GROUP BY OrderDate
ORDER BY OrderDate;

SELECT p.ProductKey, p.EnglishProductName AS NomeProdotto
, SUM(s.SalesAmount) AS TOT_FATTURATO
, SUM(s.OrderQuantity) AS TOT_QUANTITA
, SUM(s.SalesAmount)/SUM(s.OrderQuantity) AS PrezzoMedio
FROM dimproduct AS p
INNER JOIN factresellersales AS s
ON p.ProductKey = s.ProductKey
WHERE YEAR(s.OrderDate) >= 2020
GROUP BY p.ProductKey, p.EnglishProductName;

SELECT c.EnglishProductCategoryName AS NomeCategoria
, SUM(s.SalesAmount) AS tot_fatturato
, SUM(s.OrderQuantity) AS tot_quantita
FROM dimproductcategory AS c
INNER JOIN dimproductsubcategory AS sc
ON c.ProductCategoryKey=sc.ProductCategoryKey
INNER JOIN dimproduct AS p
ON sc.ProductSubcategoryKey=p.ProductSubcategoryKey
INNER JOIN factresellersales AS s
ON p.ProductKey=s.ProductKey
GROUP BY c.EnglishProductCategoryName;

SELECT g.City, SUM(s.SalesAmount) AS tot_fatturato
FROM factresellersales AS s
INNER JOIN dimreseller AS r
ON r.ResellerKey=s.ResellerKey
INNER JOIN dimgeography AS g
ON g.GeographyKey=r.GeographyKey
WHERE YEAR(s.OrderDate) >=2020
GROUP BY g.City
HAVING SUM(s.SalesAmount)>60000;










