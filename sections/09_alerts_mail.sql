/*
  08_alerts_mail.sql
  Verifies configuration of Database Mail and SQL Server Agent Alerts.
*/

PRINT '===== Section 08: Alerts and Mail Configuration =====';

-- Check if Database Mail is enabled
SELECT
    name AS ConfigName,
    value_in_use AS ValueInUse
FROM sys.configurations
WHERE name = 'Database Mail XPs';

-- List all configured Database Mail accounts
SELECT
    name AS MailAccountName,
    email_address,
    display_name,
    description,
    last_mod_date
FROM msdb.dbo.sysmail_account;

-- List enabled SQL Agent Alerts
SELECT
    name AS AlertName,
    message_id,
    severity,
    enabled,
    delay_between_responses,
    last_occurrence_date,
    last_response_date,
    include_event_description_in,
    database_name
FROM msdb.dbo.sysalerts
WHERE enabled = 1;

-- List operators configured for notifications
SELECT
    name AS OperatorName,
    email_address,
    enabled,
    weekday_pager_start_time,
    weekday_pager_end_time,
    last_email_date
FROM msdb.dbo.sysoperators;

-- Check SQL Agent Mail Profile configuration
EXEC msdb.dbo.sysmail_help_profile_sp;

GO
