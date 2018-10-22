USE master;

DROP TABLE IF EXISTS #dbtransactions;
 
-- Create a temp table to hold the result set from sys.dm_tran_database_transactions
 
CREATE TABLE #dbtransactions
(tranid BIGINT
,databaseid INT
,trantype INT
,transtate INT
,recordcount INT
,bytesused BIGINT
,bytesreserved BIGINT)

DROP TABLE IF EXISTS #activetransactions;

CREATE TABLE #activetransactions
(transaction_id BIGINT
,[name] NVARCHAR(32)
,transaction_begin_time DATETIME
,transaction_type INT
,transaction_uow UNIQUEIDENTIFIER
,transaction_state INT
,transaction_status INT
,transaction_status2 INT
,dtc_state INT
,dtc_status INT
,dtc_isolation_level INT
,filestream_transaction_id VARBINARY(128))

WHILE 1 = 1
BEGIN

	INSERT INTO #activetransactions 
	(transaction_id
	,[name]
	,transaction_begin_time
	,transaction_type
	,transaction_uow
	,transaction_state
	,transaction_status
	,transaction_status2
	,dtc_state
	,dtc_status
	,dtc_isolation_level
	,filestream_transaction_id)
	SELECT 
	transaction_id
	,[name]
	,transaction_begin_time
	,transaction_type
	,transaction_uow
	,transaction_state
	,transaction_status
	,transaction_status2
	,dtc_state
	,dtc_status
	,dtc_isolation_level
	,filestream_transaction_id
	FROM 
	sys.dm_tran_active_transactions
	WHERE [name] = 'user_transaction';

	INSERT INTO #dbtransactions
	(tranid
	,databaseid
	,trantype
	,transtate
	,recordcount
	,bytesused
	,bytesreserved)
    SELECT transaction_id AS [Tran ID], 
    database_id AS [Database ID], 
    database_transaction_type AS [Tran Type], 
    database_transaction_state AS [Tran State], 
    database_transaction_log_record_count AS [Log Record Count],
    database_transaction_log_bytes_used AS [Log Bytes Used],
    database_transaction_log_bytes_reserved AS [Log Bytes Reserved]
    FROM sys.dm_tran_database_transactions
	
END 

SELECT * FROM #activetransactions;

SELECT * FROM #activetransactions
WHERE transaction_id IN
(SELECT tranid
FROM #dbtransactions
WHERE recordcount > 1000)
AND transaction_type = 1
AND transaction_state = 6
AND [name] = 'user_transaction';
SELECT tranid, 
MAX(recordcount) AS [Record Count], 
(MAX(bytesused)/1045876) AS [MB Used], 
(MAX(bytesreserved)/1045876) AS [MB Reserved] 
FROM #dbtransactions
WHERE databaseid = DB_ID('TranLogDemo_Single')  -- Make sure to use the correct database name
AND trantype = 1
AND transtate = 4
GROUP BY tranid

SELECT tranid, 
MAX(recordcount) AS [Record Count], 
(MAX(bytesused)/1024) AS [MB Used], 
(MAX(bytesreserved)/1024) AS [MB Reserved] 
FROM #dbtransactions
WHERE databaseid = DB_ID('TranLogDemo_Batched')  -- Make sure to use the correct database name
AND trantype = 1
AND transtate = 4
GROUP BY tranid
ORDER BY [Record Count] DESC