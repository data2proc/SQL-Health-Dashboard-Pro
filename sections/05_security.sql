/*
  05_security.sql
  Overview of SQL Server logins, their status, and roles.
*/

PRINT '===== Section 05: Security Overview =====';

SELECT
    sp.name AS LoginName,
    sp.type_desc AS LoginType,
    sp.is_disabled,
    sp.is_expiration_checked,
    sp.is_policy_checked,
    sl.default_database_name,
    sl.create_date,
    sl.modify_date,
    CASE 
        WHEN sp.is_disabled = 1 THEN 'Disabled'
        ELSE 'Enabled'
    END AS Status,
    STUFF((
        SELECT ',' + dp.name
        FROM sys.database_role_members drm
        JOIN sys.database_principals dp ON drm.role_principal_id = dp.principal_id
        WHERE drm.member_principal_id = sp.principal_id
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS DatabaseRoles
FROM sys.server_principals sp
LEFT JOIN sys.sql_logins sl ON sp.principal_id = sl.principal_id
WHERE sp.type IN ('S', 'U', 'G') -- SQL login, Windows user, Windows group
ORDER BY sp.name;

GO
