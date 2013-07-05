CREATE TABLE Tran (transactionid integer PRIMARY KEY AUTOINCREMENT,accountnumber text,amount double,description text,timestamp text);
INSERT INTO Tran ( transactionid,accountnumber,amount,description,timestamp ) VALUES ( '1','0123456789','50.0','','2012-01-01 12:12:12' );
INSERT INTO Tran ( transactionid,accountnumber,amount,description,timestamp ) VALUES ( '2','0123456789','50.0','','2012-01-01 12:12:13' );
INSERT INTO Tran ( transactionid,accountnumber,amount,description,timestamp ) VALUES ( '3','0123456789','50.0','','2012-01-01 12:12:14' );
INSERT INTO Tran ( transactionid,accountnumber,amount,description,timestamp ) VALUES ( '4','0123456789','50.0','','2012-01-01 12:12:15' );
INSERT INTO Tran ( transactionid,accountnumber,amount,description,timestamp ) VALUES ( '5','0123456789','50.0','','2012-01-01 12:12:16' );