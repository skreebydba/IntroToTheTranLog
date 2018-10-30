USE master;

--Truncate DatabaseTransactions table
TRUNCATE TABLE TranLogDemo.dbo.DatabaseTransactions;

-- Run an infinite loop for the duration of each update script
-- stopping it when the script completes
 
WHILE 1 = 1
BEGIN
 
    INSERT INTO TranLogDemo.[dbo].[DatabaseTransactions]
	(tranid
	,databaseid
	,trantype
	,transtate
	,logrecordcount
	,logbytesused
	,logbytesreserved)
    SELECT transaction_id AS [Tran ID], 
    database_id AS [Database ID], 
    database_transaction_type AS [Tran Type], 
    database_transaction_state AS [Tran State], 
    database_transaction_log_record_count AS [Log Record Count],
    database_transaction_log_bytes_used AS [Log Bytes Used],
    database_transaction_log_bytes_reserved AS [Log Bytes Reserved]
    FROM sys.dm_tran_database_transactions
 
END

