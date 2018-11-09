DROP TABLE IF EXISTS TranLogDemo.dbo.DatabaseTransactions;
DROP TABLE IF EXISTS TranLogDemo.dbo.TranLogBatchedLog;
DROP TABLE IF EXISTS TranLogDemo.dbo.TranLogSingleLog;

DROP TABLE IF EXISTS TranLogDemoBatched.dbo.OrderHistoryBatched;

DROP TABLE IF EXISTS TranLogDemoSingle.dbo.OrderHistorySingle;

CREATE TABLE TranLogDemo_Batched.dbo.OrderHistoryBatched
(OrderId INT IDENTITY(1,1)
,OrderDate DATETIME
,CustomerId INT
,CONSTRAINT PK_OrderHistoryBatched_OrderId PRIMARY KEY CLUSTERED(OrderId));

CREATE TABLE TranLogDemo_Single.dbo.OrderHistorySingle
(OrderId INT IDENTITY(1,1)
,OrderDate DATETIME
,CustomerId INT
,CONSTRAINT PK_OrderHistorySingle_OrderId PRIMARY KEY CLUSTERED(OrderId));

CREATE TABLE TranLogDemo.dbo.DatabaseTransactions
(tranid BIGINT
,databaseid INT
,trantype INT
,transtate INT
,logrecordcount BIGINT
,logbytesused BIGINT
,logbytesreserved BIGINT);

CREATE TABLE TranLogDemo.dbo.TranLogBatchedLog
(CurrentLSN NVARCHAR(23)
,TransactionID NVARCHAR(46)
,XactID BIGINT
,TransactionName NVARCHAR(33)
,Operation NVARCHAR(31)
,Context NVARCHAR(31)
,[Description] NVARCHAR(256)
,PreviousLSN NVARCHAR(23)
,AllocUnitName NVARCHAR(387)
,PageID NVARCHAR(14)
,SlotID INT
,BeginTime NVARCHAR(24)
,DatabaseName NVARCHAR(129)
,NumberOfLocks SMALLINT
,LockInformation NVARCHAR(256)
,NewSplitPage NVARCHAR(14));

CREATE TABLE TranLogDemo.dbo.TranLogSingleLog
(CurrentLSN NVARCHAR(23)
,TransactionID NVARCHAR(46)
,XactID BIGINT
,TransactionName NVARCHAR(33)
,Operation NVARCHAR(31)
,Context NVARCHAR(31)
,[Description] NVARCHAR(256)
,PreviousLSN NVARCHAR(23)
,AllocUnitName NVARCHAR(387)
,PageID NVARCHAR(14)
,SlotID INT
,BeginTime NVARCHAR(24)
,DatabaseName NVARCHAR(129)
,NumberOfLocks SMALLINT
,LockInformation NVARCHAR(256)
,NewSplitPage NVARCHAR(14));
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

