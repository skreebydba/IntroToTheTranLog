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

--Current LSN	nvarchar	no	46
--Transaction ID	nvarchar	no	28
--Xact ID	bigint	no	8
--Transaction Name	nvarchar	no	66
--Operation	nvarchar	no	62
--Context	nvarchar	no	62
--Description	nvarchar	no	512
--Previous LSN	nvarchar	no	46
--AllocUnitName	nvarchar	no	774
--Page ID	nvarchar	no	28
--Slot ID	int	no	4
--Begin Time	nvarchar	no	48
--Database Name	nvarchar	no	258
--Number of Locks	smallint	no	2
--Lock Information	nvarchar	no	512
--New Split Page	nvarchar	no	28

