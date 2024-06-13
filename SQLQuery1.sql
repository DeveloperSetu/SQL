--===================================DDL==============================---(CREATE,DROP,AITER)

-----------------Create Database-----------------------
CREATE DATABASE AP;

USE AP;
-----------------Create Table---------------------------
CREATE TABLE Invoices
(
InvoiceID         INT         NOT NULL IDENTITY PRIMARY KEY,
VendorID          INT         NOT NULL REFERENCES Vendors(VendorID),
InvoiceNumber     VARCHAR(50) NOT NULL,
InvoiceDate       DATE        NOT NULL,
InvoiceTotal      MONEY       NOT NULL,
PaymentToal       MONEY       NOT NULL DEFAULT 0,
CreditTotal       MONEY       NOT NULL DEFAULT 0,
TermsID           INT         NOT NULL REFERENCES Terms(TermsID),
InvoiceDueDate    DATE        NOT NULL,
PaymentDate       DATE        NULL
);

-------------------Adds a new column to the table--------------------
ALTER TABLE Invoices 
ADD BalanceDue MONEY NOT NULL;

-------------------Delete a new column to the table------------------
ALTER TABLE Invoices 
DROP Column BalanceDue;

-------------------Create a Index on the table-----------------------
CREATE INDEX IX_Invoices_VendorID
       On Invoices(VeldorID);  
	   



--===================================DML==============================---(SELECT,INSERT,UPDATE,DELETE)

-------------------SELECT--------------------
SELECT * FROM Invoices;

SELECT InvoiceNumber,InvoiceDate,InvoiceTotal, PaymentTotal, CreditTotal,
(InvoiceTotal-PaymentTotal-CreditTotal) AS BalanceDue
FROM Invoices
WHERE InvoiceTotal-PaymentTotal-CreditTotal > 0;

---------------SELECT > JOIN----------
SELECT VendorName, InvoiceNumber,InvoiceDate,InvoiceTotal FROM Vendors 
INNER JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal >=500
ORDER BY VendorName, InvoiceTotal DESC;

----------------INSERT----------------
SELECT * FROM Invoices;
INSERT INTO Invoices(VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal, CreditTotal, TermsID, InvoiceDueDate)
Values(122, 4543455534, CAST ('2012-02-05' AS datetime), 434.3, 232.2, 0.00, 3,  CAST ('2012-02-05' AS datetime) );

----------------UPDARE------------------
update Invoices 
set InvoiceDate= CAST('2012-03-03' AS datetime)
WHERE InvoiceID=117;

----------------DELETE------------------

DELETE FROM Invoices where InvoiceID=117;

