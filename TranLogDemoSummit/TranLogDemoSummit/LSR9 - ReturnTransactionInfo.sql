USE master
GO

DECLARE @version NVARCHAR(128);

SELECT @version = CAST(SERVERPROPERTY('ProductVersion') AS NVARCHAR(128));

IF CAST(SUBSTRING(@version,1,2) AS INT) >= 13
BEGIN

	DROP TABLE IF EXISTS #batched;

END
ELSE
BEGIN

	IF OBJECT_ID('tempdb.dbo.#batched') IS NOT NULL
	BEGIN

		DROP TABLE #batched;

	END
END
-- Drop temp table if it exists
-- Version check to use DROP TABLE IF EXISTS
 
-- Create a temp table to hold the result set from sys.dm_tran_database_transactions
 
CREATE TABLE #batched
(tranid BIGINT
,recordcount INT
,kbused BIGINT
,kbreserved BIGINT);
 
-- Use the select statement below to see the results
-- This query will return a single row per transaction
-- for read/write activity (trantype = 1)
-- that has generated log records (transtate = 4)

INSERT INTO #batched
(tranid
,recordcount
,kbused
,kbreserved)
SELECT tranid, 
MAX(recordcount) AS [Record Count], 
(MAX(bytesused)/1024) AS [KB Used], 
(MAX(bytesreserved)/1024) AS [KB Reserved] 
FROM tempdb.dbo.DatabaseTransactions
WHERE databaseid = DB_ID('TranLogDemo_Batched')  -- Make sure to use the correct database name
AND trantype = 1
AND transtate = 4
GROUP BY tranid
HAVING MAX(recordcount) > 12
ORDER BY [Record Count] DESC;

SELECT COALESCE(CAST(tranid AS NVARCHAR(15)), 'Total') AS [Tran ID], 
SUM(recordcount) AS [Record Count], 
SUM(kbused) AS [KB Used],
SUM(kbreserved) AS [KB Reserved]
FROM #batched
GROUP BY tranid WITH ROLLUP
ORDER BY SUM(recordcount);

SELECT tranid, 
MAX(recordcount) AS [Record Count], 
(MAX(bytesused)/1024) AS [KB Used], 
(MAX(bytesreserved)/1024) AS [KB Reserved] 
FROM tempdb.dbo.DatabaseTransactions
WHERE databaseid = DB_ID('TranLogDemo_Single')  -- Make sure to use the correct database name
AND trantype = 1
AND transtate = 4
GROUP BY tranid
HAVING MAX(recordcount) > 12
ORDER BY [Record Count] DESC


 
-- Clean up the temp table after the run
 
--DROP TABLE tempdb.dbo.DatabaseTransactions