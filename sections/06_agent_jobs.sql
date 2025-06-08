/*
  06_sql_agent_jobs.sql
  Overview of SQL Server Agent jobs, their status, schedules, and last run outcome.
*/

PRINT '===== Section 06: SQL Agent Jobs =====';

SELECT
    j.job_id,
    j.name AS JobName,
    j.enabled,
    CASE j.enabled WHEN 1 THEN 'Enabled' ELSE 'Disabled' END AS JobStatus,
    COALESCE(sched.next_run_date, 0) AS NextRunDate,
    COALESCE(sched.next_run_time, 0) AS NextRunTime,
    COALESCE(run_history.run_status, -1) AS LastRunStatus,
    CASE run_history.run_status
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Canceled'
        WHEN 4 THEN 'In Progress'
        ELSE 'Never Run'
    END AS LastRunStatusDescription,
    run_history.run_date AS LastRunDate,
    run_history.run_time AS LastRunTime
FROM msdb.dbo.sysjobs j
LEFT JOIN msdb.dbo.sysjobschedules js ON j.job_id = js.job_id
LEFT JOIN msdb.dbo.sysschedules sched ON js.schedule_id = sched.schedule_id
OUTER APPLY (
    SELECT TOP 1
        run_status,
        run_date,
        run_time
    FROM msdb.dbo.sysjobhistory h
    WHERE h.job_id = j.job_id
      AND h.step_id = 0 -- job outcome
    ORDER BY run_date DESC, run_time DESC
) run_history
ORDER BY j.n
