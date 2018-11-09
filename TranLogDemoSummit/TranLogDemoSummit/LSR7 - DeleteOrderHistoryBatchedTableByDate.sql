USE TranLogDemo_Batched;

--DELETE FROM tempdb.dbo.TranLogBatchedLog;

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

INSERT INTO TranLogDemo.dbo.TranLogBatchedLog
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

SELECT TransactionID, Operation, Context, COUNT(*) 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY TransactionID, Operation, Context
ORDER BY COUNT(*) DESC;

--SELECT * FROM 
--TranLogDemo.dbo.TranLogBatchedLog
--WHERE TransactionID IN (
--	SELECT DISTINCT TransactionID 
--	FROM TranLogDemo.dbo.TranLogBatchedLog
--	WHERE Operation = 'LOP_DELETE_ROWS')
--AND Operation = 'LOP_BEGIN_XACT'
--AND TransactionName = 'user_transaction';

--SELECT TransactionName, COUNT(*) 
--FROM TranLogDemo.dbo.TranLogBatchedLog
--GROUP BY TransactionName
--ORDER BY COUNT(*);
----WHERE TransactionID IS NOT NULL;

--SELECT * FROM TranLogDemo.dbo.TranLogBatchedLog
--WHERE TransactionName = 'user_transaction';

SELECT CurrentLSN,
Operation,
Context,
AllocUnitName,
PageID,
SlotID,
NumberOfLocks,
LockInformation 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE PageID = '0001:00000379'
--AND Context = 'LCX_MARK_AS_GHOST'
ORDER BY CurrentLSN;

SELECT PageID, Context, NumberOfLocks, COUNT(*)
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY PageID, Context, NumberOfLocks
ORDER BY PageID, COUNT(*) DESC;

SELECT CurrentLSN,
Operation,
Context,
AllocUnitName,
PageID,
SlotID,
NumberOfLocks,
LockInformation 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE PageID = '0001:00000da0'
--AND Context = 'LCX_MARK_AS_GHOST'
ORDER BY CurrentLSN;


--SELECT CONVERT(INT, CONVERT(VARBINARY,SUBSTRING(TransactionID, 6, 13), 2)), CHARINDEX(':',TransactionID), LEN(TransactionID) FROM TranLogDemo.dbo.TranLogBatchedLog
--WHERE TransactionID = N'0000:001ea7dc';

--SELECT CONVERT(INT, CONVERT(VARBINARY, 'F535BA', 2))
----F535BA

--DBCC PAGE(11,1,6266,3) WITH TABLERESULTS;

--SELECT DB_ID(N'TranLogDemo_Batched')
