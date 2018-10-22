USE TranLogDemo;

DECLARE @deletedate DATETIME;

SELECT @deletedate = DATEADD(YEAR, -2, CURRENT_TIMESTAMP);

SELECT @deletedate;

SELECT COUNT(*) FROM OrderHistorySingle
WHERE OrderDate < @deletedate;

BEGIN TRANSACTION

	DELETE FROM OrderHistorySingle
	WHERE OrderDate < @deletedate;

COMMIT TRANSACTION