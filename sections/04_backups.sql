/*
  04_backups.sql
  Check backup status and last backup times for all databases.
*/

PRINT '===== Section 04: Backup and Restore Status =====';

SELECT
    d.name AS DatabaseName,
    MAX(b.backup_finish_date) AS LastBackupDate,
    CASE 
        WHEN MAX(b.backup_finish_date) IS NULL THEN 'No backups found'
        ELSE CONVERT(VARCHAR(30), MAX(b.backup_finish_date), 120)
    END AS LastBackupDateFormatted,
    MIN(CASE WHEN b.type = 'D' THEN b.backup_finish_date END) AS LastFullBackup,
    MIN(CASE WHEN b.type = 'I' THEN b.backup_finish_date END) AS LastDifferentialBackup,
    MIN(CASE WHEN b.type = 'L' THEN b.backup_finish_date END) AS LastLogBackup
FROM sys.databases d
LEFT JOIN msdb.dbo.backupset b ON b.database_name = d.name
WHERE d.state = 0 -- ONLINE
GROUP BY d.name
ORDER BY d.name;

GO
