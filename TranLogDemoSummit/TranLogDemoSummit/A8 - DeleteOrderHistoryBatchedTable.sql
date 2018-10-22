USE TranLogDemo;

DECLARE @deletedate DATETIME,
@rowcount BIGINT;

SELECT @deletedate = DATEADD(YEAR, -2, CURRENT_TIMESTAMP);

SELECT @rowcount = COUNT(*)
FROM OrderHistoryBatched
WHERE OrderDate < @deletedate;

SELECT @deletedate, @rowcount;

WHILE @rowcount > 0
BEGIN

	BEGIN TRANSACTION

	DELETE TOP (2000) FROM OrderHistoryBatched
	WHERE OrderDate < @deletedate;

	COMMIT TRANSACTION

	SELECT @rowcount -= 2000;

END