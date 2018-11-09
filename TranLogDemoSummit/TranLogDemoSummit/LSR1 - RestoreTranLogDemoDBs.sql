USE [master]
RESTORE DATABASE [TranLogDemo_Batched] 
FROM DISK = N'C:\Backup\TranLogDemo1000000.bak' 
WITH  FILE = 1,  
MOVE N'TranLogDemo' TO N'C:\Data\TranLogDemo_Batched.mdf',  
MOVE N'TranLogDemo_log' TO N'C:\Log\TranLogDemo_Batched_log.ldf',  
NOUNLOAD,
REPLACE,  
STATS = 5

GO

RESTORE DATABASE [TranLogDemo_Single] 
FROM DISK = N'C:\Backup\TranLogDemo1000000.bak' 
WITH  FILE = 1,  
MOVE N'TranLogDemo' TO N'C:\Data\TranLogDemo_Single.mdf',  
MOVE N'TranLogDemo_log' TO N'C:\Log\TranLogDemo_Single_log.ldf',  
NOUNLOAD, 
REPLACE, 
STATS = 5

GO


