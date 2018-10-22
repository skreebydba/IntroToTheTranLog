USE TranLogDemo
GO
 
-- Declare @loopcount variable to run the loop
-- Declare @textlen to vary the length of the text fields
 
DECLARE @loopcount INT
DECLARE @textlen TINYINT
SET @loopcount = 1
 
-- Begin an explicit transaction that will remain open for the duration of the loop
BEGIN TRAN
 
WHILE @loopcount <= 10
BEGIN
 
    -- Use the modulus operator to set text length to the remainder of @loopcount / 10
 
    -- Update onetranu using the values described below
    UPDATE OrderHistorySingle
    -- Set rundate equal the current datetime
    SET Processed = 1,
	ProcessedDate = CURRENT_TIMESTAMP;
 
    -- Increment @loopcount
    SET @loopcount = @loopcount + 1
 
END
 
COMMIT