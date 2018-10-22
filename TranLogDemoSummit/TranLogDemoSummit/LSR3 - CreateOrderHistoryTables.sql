USE TranLogDemo;

DROP TABLE IF EXISTS OrderHistoryBatched;
DROP TABLE IF EXISTS OrderHistorySingle;

CREATE TABLE OrderHistoryBatched
(OrderId INT IDENTITY(1,1)
,OrderDate DATETIME
,CustomerId INT
,CONSTRAINT PK_OrderHistoryBatched_OrderId PRIMARY KEY CLUSTERED(OrderId));

USE TranLogDemo;

CREATE TABLE OrderHistorySingle
(OrderId INT IDENTITY(1,1)
,OrderDate DATETIME
,CustomerId INT
,CONSTRAINT PK_OrderHistorySingle_OrderId PRIMARY KEY CLUSTERED(OrderId));

