/*
  02_database_summary.sql
  Summary information about all databases on the instance.
*/

PRINT '===== Section 02: Database Summary =====';

SELECT
    name AS DatabaseName,
    state_desc AS State,
    recovery_model_desc AS RecoveryModel,
    user_access_desc AS UserAccess,
    is_read_only,
    is_auto_shrink_on,
    is_auto_close_on,
    compatibility_level,
    (size * 8) / 1024.0 AS SizeMB,
    create_date,
    modify_date
FROM sys.databases
ORDER BY name;

GO
