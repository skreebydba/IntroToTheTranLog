SELECT TransactionID, Operation, COUNT(*) 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY TransactionID, Operation
ORDER BY TransactionID, COUNT(*) DESC;

SELECT TransactionID, Operation, COUNT(*) 
FROM TranLogDemo.dbo.TranLogSingleLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY TransactionID, Operation
ORDER BY TransactionID, COUNT(*) DESC;

SELECT TransactionID, Operation, Context, COUNT(*) 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY TransactionID, Operation, Context
ORDER BY TransactionID, COUNT(*) DESC;

SELECT TransactionID, Operation, Context, COUNT(*) 
FROM TranLogDemo.dbo.TranLogSingleLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
GROUP BY TransactionID, Operation, Context
ORDER BY TransactionID, COUNT(*) DESC;

SELECT TOP 1 * 
FROM TranLogDemo.dbo.TranLogSingleLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR';

SELECT TOP 1 * 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
AND Context = N'LCX_MARK_AS_GHOST';

SELECT TOP 1 * 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
AND Context = N'LCX_CLUSTERED';

SELECT TOP 1 * 
FROM TranLogDemo.dbo.TranLogBatchedLog
WHERE Operation = 'LOP_DELETE_ROWS'
AND Context <> 'LCX_INDEX_INTERIOR'
AND NumberOfLocks = 3;