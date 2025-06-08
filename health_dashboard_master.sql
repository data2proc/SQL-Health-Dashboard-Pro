/*
  health_dashboard_master.sql
  Master script to run all SQL Server Health Check sections sequentially.
  Author: [Sara]
  Date: [6/08/2025]
  Description: Executes each health check module in order and logs progress.
*/

-- Print header
PRINT '========================================';
PRINT '   SQL Server Health Check Dashboard    ';
PRINT '========================================';
PRINT '';
PRINT 'Start Time: ' + CONVERT(VARCHAR, GETDATE(), 120);
PRINT '';  

-- This script uses the :r directive, which only works in SQLCMD mode (enabled in SSMS or sqlcmd utility)  

-- Section 01: Instance Info
:r .\sections\01_instance_info.sql

-- Section 02: Database Summary
:r .\sections\02_database_summary.sql

-- Section 03: Performance Metrics
:r .\sections\03_performance_metrics.sql

-- Section 04: Backups
:r .\sections\04_backups.sql

-- Section 05: Security
:r .\sections\05_security.sql

-- Section 06: SQL Agent Jobs
:r .\sections\06_agent_jobs.sql

-- Section 07: Index and Statistics Health
:r .\sections\07_index_stats_health.sql

-- Section 08: Disk Monitoring
:r .\sections\08_disk_monitoring.sql

-- Section 09: Alerts and Mail Configuration
:r .\sections\09_alerts_mail.sql

-- Print footer
PRINT '';
PRINT '========================================';
PRINT '     Health Check Completed Successfully';
PRINT '     End Time: ' + CONVERT(VARCHAR, GETDATE(), 120);
PRINT '========================================';

GO
