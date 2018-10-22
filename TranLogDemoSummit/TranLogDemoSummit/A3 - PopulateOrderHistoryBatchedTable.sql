USE TranLogDemo;

SET NOCOUNT ON;

DECLARE @loopcount INT,
@looplimit INT,
@orderdate DATETIME,
@random INT;

SELECT @loopcount = 1, @looplimit = 1000000, @orderdate = CURRENT_TIMESTAMP;

WHILE @loopcount <= @looplimit
BEGIN

	SELECT @random = ROUND(RAND() * 1000, 0)	;

	IF @loopcount % 500 = 0
	BEGIN
		
		SELECT @orderdate = DATEADD(HOUR,-12,@orderdate);

	END

	INSERT INTO TranLogDemo.dbo.OrderHistoryBatched
	(OrderDate
	,CustomerId)
	VALUES
	(@orderdate
	,@random)

	SELECT @loopcount += 1;

END
