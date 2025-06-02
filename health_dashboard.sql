/* 
=========================================================
  SQL Health Dashboard Pro
  Author: data2proc
  Version: 1.0.0
  Description: Comprehensive SQL Server Health Check
=========================================================
*/

/* ===============================
   1. SQL Server Version Info
=============================== */
SELECT 
    SERVERPROPERTY('MachineName') AS Machine,
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel;

/* ===============================
   2. Database Status & Size
=============================== */
SELECT 
    name AS DatabaseName,
    state_desc AS Status,
    recovery_model_desc AS RecoveryModel,
    compatibility_level,
    size * 8 / 1024 AS SizeMB
FROM sys.databases d
JOIN sys.master_files f ON d.database_id = f.database_id
WHERE type_desc = 'ROWS'
GROUP BY name, state_desc, recovery_model_desc, compatibility_level, size;

/* ===============================
   3. Last Full, Diff, Log Backups
=============================== */
SELECT 
    database_name,
    MAX(CASE WHEN type = 'D' THEN backup_finish_date END) AS LastFullBackup,
    MAX(CASE WHEN type = 'I' THEN backup_finish_date END) AS LastDiffBackup,
    MAX(CASE WHEN type = 'L' THEN backup_finish_date END) AS LastLogBackup
FROM msdb.dbo.backupset
GROUP BY database_name;

/* ===============================
   4. SQL Agent Job Failures (Last 24h)
=============================== */
SELECT 
    j.name AS JobName,
    h.run_date,
    h.run_time,
    h.run_status,
    h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status != 1
  AND CONVERT(DATETIME, CONVERT(CHAR(8), h.run_date), 112) >= GETDATE() - 1;

/* ===============================
   5. Index Fragmentation > 30%
=============================== */
SELECT 
    DB_NAME() AS DatabaseName,
    OBJECT_NAME(ps.object_id) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE ps.avg_fragmentation_in_percent > 30
  AND ps.index_id > 0;

/* ===============================
   6. Disk Space Usage (via xp_fixeddrives)
=============================== */
EXEC xp_fixeddrives;

/* ===============================
   7. Autogrowth Events (Last 7 Days)
=============================== */
SELECT 
    name AS [Database],
    file_id,
    size_on_disk_bytes / 1024 / 1024 AS SizeMB,
    io_stall_read_ms,
    io_stall_write_ms
FROM sys.dm_io_virtual_file_stats(NULL, NULL);

/* ===============================
   8. Wait Stats (Top 10)
=============================== */
SELECT TOP 10 
    wait_type, 
    wait_time_ms / 1000.0 AS WaitSeconds,
    percent_complete = ROUND(100.0 * wait_time_ms / SUM(wait_time_ms) OVER (), 2)
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC;

/* ===============================
   9. Long Running Queries (> 30 sec)
=============================== */
SELECT 
    r.session_id,
    r.status,
    r.start_time,
    r.cpu_time,
    r.total_elapsed_time / 1000.0 AS DurationSec,
    t.text AS QueryText
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.total_elapsed_time > 30000;

/* ===============================
   10. Blocked Sessions
=============================== */
SELECT 
    session_id, 
    blocking_session_id, 
    wait_type, 
    wait_time, 
    wait_resource
FROM sys.dm_exec_requests
WHERE blocking_session_id <> 0;

-- End of Health Check Script
