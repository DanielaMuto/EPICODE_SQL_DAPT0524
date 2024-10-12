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



