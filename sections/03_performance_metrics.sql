/*
  03_performance_metrics.sql
  Key performance metrics including waits, blocking, and TempDB usage.
*/

PRINT '===== Section 03: Performance Metrics =====';

-- Wait Statistics (top 10 waits by wait time)
PRINT '--- Top 10 Wait Types ---';
SELECT TOP 10
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS WaitTimeSeconds,
    max_wait_time_ms / 1000.0 AS MaxWaitTimeSeconds,
    signal_wait_time_ms / 1000.0 AS SignalWaitTimeSeconds
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('CLR_SEMAPHORE','LAZYWRITER_SLEEP','RESOURCE_QUEUE','SLEEP_TASK',
                        'SLEEP_SYSTEMTASK','SQLTRACE_BUFFER_FLUSH','WAITFOR','LOGMGR_QUEUE',
                        'CHECKPOINT_QUEUE','REQUEST_FOR_DEADLOCK_SEARCH','XE_TIMER_EVENT',
                        'XE_DISPATCHER_WAIT', 'BROKER_TO_FLUSH', 'BROKER_TASK_STOP', 'CLR_MANUAL_EVENT',
                        'CLR_AUTO_EVENT', 'DISPATCHER_QUEUE_SEMAPHORE', 'FT_IFTS_SCHEDULER_IDLE_WAIT',
                        'XE_DISPATCHER_JOIN', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP')
ORDER BY wait_time_ms DESC;

-- Blocking Sessions
PRINT '--- Current Blocking ---';
SELECT
    blocking_session_id AS BlockingSessionID,
    session_id AS BlockedSessionID,
    wait_duration_ms,
    wait_type,
    resource_description
FROM sys.dm_os_waiting_tasks
WHERE blocking_session_id <> 0;

-- TempDB Usage Summary
PRINT '--- TempDB File Usage ---';
SELECT
    file_id,
    name,
    size / 128.0 AS SizeMB,
    growth / 128.0 AS GrowthMB,
    max_size,
    is_percent_growth,
    CASE WHEN is_percent_growth = 1 THEN CAST(growth AS VARCHAR) + '%' ELSE CAST(growth * 8 AS VARCHAR) + 'KB' END AS GrowthDisplay
FROM tempdb.sys.database_files;

GO
