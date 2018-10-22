USE TranLogDemo_Batched;

DECLARE @mindate DATETIME,
@maxdate DATETIME,
@maxlsn NVARCHAR(46);

SELECT @maxlsn = CONCAT(N'0x',MAX([Current LSN])) FROM fn_dblog(NULL,NULL);

SELECT @mindate = MIN(OrderDate)
FROM OrderHistoryBatched;

SELECT @maxdate = DATEADD(MONTH,-2,CURRENT_TIMESTAMP);

WHILE @mindate < @maxdate
BEGIN

	BEGIN TRANSACTION
		
		DELETE FROM OrderHistoryBatched
		WHERE OrderDate <= @mindate;

		SELECT @mindate = DATEADD(MONTH,3,@mindate);

	COMMIT TRANSACTION

END

INSERT INTO tempdb.dbo.TranLogBatchedLog
(CurrentLSN
,TransactionID
,XactID
,TransactionName
,Operation
,Context
,[Description]
,PreviousLSN
,AllocUnitName
,PageID
,SlotID
,BeginTime
,DatabaseName
,NumberOfLocks
,LockInformation
,NewSplitPage)
SELECT [Current LSN]
,[Transaction ID]
,[Xact ID]
,[Transaction Name]
,Operation
,Context
,[Description]
,[Previous LSN]
,AllocUnitName
,[Page ID]
,[Slot ID]
,[Begin Time]
,[Database Name]
,[Number of Locks]
,[Lock Information]
,[New Split Page]
FROM fn_dblog(@maxlsn,NULL);

SELECT TransactionID, Operation, COUNT(*) 
FROM tempdb.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
GROUP BY TransactionID, Operation
ORDER BY COUNT(*) DESC;

SELECT * FROM 
tempdb.dbo.TranLogBatchedLog
WHERE TransactionID IN (
	SELECT DISTINCT TransactionID 
	FROM tempdb.dbo.TranLogBatchedLog
	WHERE Operation = 'LOP_DELETE_ROWS')
AND Operation = 'LOP_BEGIN_XACT';

SELECT TransactionName, COUNT(*) 
FROM tempdb.dbo.TranLogBatchedLog
GROUP BY TransactionName
ORDER BY COUNT(*);
--WHERE TransactionID IS NOT NULL;

SELECT * FROM tempdb.dbo.TranLogBatchedLog;

SELECT CONVERT(INT, CONVERT(VARBINARY,SUBSTRING(TransactionID, 6, 13), 2)), CHARINDEX(':',TransactionID), LEN(TransactionID) FROM tempdb.dbo.TranLogBatchedLog
WHERE TransactionID = N'0000:001ea7dc';

SELECT CONVERT(INT, CONVERT(VARBINARY, 'F535BA', 2))
--F535BA
