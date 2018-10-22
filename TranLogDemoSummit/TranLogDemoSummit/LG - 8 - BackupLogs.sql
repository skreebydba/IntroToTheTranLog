USE master;

BACKUP LOG BigLog TO DISK = 'D:\Backup\BigLog.trn' WITH COMPRESSION, STATS = 5;
BACKUP LOG SmallLog TO DISK = 'D:\Backup\SmallLog.trn' WITH COMPRESSION, STATS = 5;