USE TranLogDemo;

EXEC sp_spaceused OrderHistoryBatched;

EXEC sp_spaceused OrderHistorySingle;
--SELECT OrderDate, COUNT(*) FROM 
--OrderHistoryBatched
--GROUP BY OrderDate
--ORDER BY OrderDate;

--SELECT OrderDate, COUNT(*) FROM 
--OrderHistorySingle
--GROUP BY OrderDate
--ORDER BY OrderDate;
