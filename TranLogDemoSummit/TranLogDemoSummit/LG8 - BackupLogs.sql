USE master;

BACKUP LOG BigLog TO DISK = 'C:\Backups\BigLog.trn' WITH COMPRESSION, STATS = 5;
BACKUP LOG SmallLog TO DISK = 'C:\Backups\SmallLog.trn' WITH COMPRESSION, STATS = 5;