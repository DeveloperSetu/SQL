# SQL
# DROP DATABASE Statement
  DROP DATABASE database_Name;
# Rename Database name statement
  ALTER DATABASE ExName MODIFY NAME= new-database

# DROP Table Statement
  DROP TABLE Table_Name;
# Table Create statement
   CREATE TABLE table_name
# RENAME Table name statement
  ALTER TABLE table_name RENAME TO new_table_name; 








#SQL QUERY
#---===================================DDL==============================--- (CREATE,DROP,AITER)
#-----------------Drop Database-----------------------
DROP DATABASE AP;
GO;

#-----------------Create Database-----------------------
CREATE DATABASE AP;
GO;

#-----------------Rename Database-----------------------
ALTER DATABASE AP MODIFY NAME = APS;
GO;

USE AP;
GO;
#-----------------Drop Table---------------------------
DROP TABLE Invoices;

 #-----------------Create Table---------------------------
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
GO;

#-------------------Adds a new column to the table--------------------
ALTER TABLE Invoices 
ADD BalanceDue MONEY NOT NULL;
GO;

#-------------------Delete a new column to the table------------------
ALTER TABLE Invoices 
DROP Column BalanceDue;
GO;

#-------------------Create a Index on the table-----------------------
CREATE INDEX IX_Invoices_VendorID
       On Invoices(VeldorID);  
GO;
	   



#--===================================DML==============================---(SELECT,INSERT,UPDATE,DELETE)

#-------------------SELECT--------------------
SELECT * FROM Invoices;

SELECT InvoiceNumber,InvoiceDate,InvoiceTotal, PaymentTotal, CreditTotal,
(InvoiceTotal-PaymentTotal-CreditTotal) AS BalanceDue
FROM Invoices
WHERE InvoiceTotal-PaymentTotal-CreditTotal > 0;
GO;

#---------------SELECT > JOIN----------
SELECT VendorName, InvoiceNumber,InvoiceDate,InvoiceTotal FROM Vendors 
INNER JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal >=500
ORDER BY VendorName, InvoiceTotal DESC;
GO;

#----------------INSERT----------------
SELECT * FROM Invoices;
INSERT INTO Invoices(VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal, CreditTotal, TermsID, InvoiceDueDate)
Values(122, 4543455534, CAST ('2012-02-05' AS datetime), 434.3, 232.2, 0.00, 3,  CAST ('2012-02-05' AS datetime) );
GO;

#----------------UPDARE------------------
update Invoices 
set InvoiceDate= CAST('2012-03-03' AS datetime)
WHERE InvoiceID=117;
GO;
#----------------DELETE------------------

DELETE FROM Invoices where InvoiceID=117;
GO;

#----------------Create View------------------
CREATE VIEW VendorMin AS
       SELECT VendorName,VendorState,VendorPhone FROM Vendors;
	   GO;

#----------------Read View--------------------
SELECT * FROM VendorMin
         WHERE VendorState = 'CA';
		 GO;

#----------------Create  Procedure------------------
CREATE PROCEDURE spVendorsByState @stateVar char(2) AS
       SELECT VendorName,VendorState, VendorPhone FROM VendorMin
	   WHERE VendorState = @stateVar
	   ORDER BY VendorName;
#----------------Read  Procedure------------------
EXEC spVendorsByState 'CA';






#---====================================Practice SQL===================================--
SELECT * FROM Invoices;
GO;

SELECT InvoiceNumber, InvoiceTotal, InvoiceDate FROM Invoices
         ORDER BY InvoiceTotal DESC;
         GO;

SELECT InvoiceID, InvoiceTotal , CreditTotal + PaymentTotal AS TotalCredit
        FROM Invoices
        WHERE InvoiceID = 17;
		Go;

SELECT * FROM Invoices
         WHERE InvoiceDate BETWEEN '2012-01-03' AND '2012-01-31'
         ORDER BY InvoiceDate;
         GO;

SELECT * FROM Invoices
         WHERE  InvoiceTotal > 5000; 
