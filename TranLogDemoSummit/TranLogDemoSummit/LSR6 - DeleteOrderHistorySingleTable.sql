USE TranLogDemo_Single;

DECLARE @maxlsn NVARCHAR(46);

SELECT @maxlsn = CONCAT(N'0x',MAX([Current LSN])) FROM fn_dblog(NULL,NULL);

BEGIN TRANSACTION
		
	DELETE FROM OrderHistorySingle
	WHERE OrderDate <= DATEADD(MONTH,-2,CURRENT_TIMESTAMP);

COMMIT TRANSACTION

--INSERT INTO TranLogDemo.dbo.TranLogSingleLog
--(CurrentLSN
--,TransactionID
--,XactID
--,TransactionName
--,Operation
--,Context
--,[Description]
--,PreviousLSN
--,AllocUnitName
--,PageID
--,SlotID
--,BeginTime
--,DatabaseName
--,NumberOfLocks
--,LockInformation
--,NewSplitPage)
--SELECT [Current LSN]
--,[Transaction ID]
--,[Xact ID]
--,[Transaction Name]
--,Operation
--,Context
--,[Description]
--,[Previous LSN]
--,AllocUnitName
--,[Page ID]
--,[Slot ID]
--,[Begin Time]
--,[Database Name]
--,[Number of Locks]
--,[Lock Information]
--,[New Split Page]
--FROM fn_dblog(@maxlsn,NULL);

