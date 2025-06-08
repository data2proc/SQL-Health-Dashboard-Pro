/*
  08_disk_monitoring.sql
  Checks disk space usage for drives used by SQL Server data and log files.
*/

PRINT '===== Section 08: Disk Monitoring =====';

-- Get drives used by SQL Server files
DECLARE @drives TABLE (DriveLetter CHAR(2));

INSERT INTO @drives (DriveLetter)
SELECT DISTINCT LEFT(physical_name, 2)
FROM sys.master_files
WHERE physical_name LIKE '[A-Z]:%';

-- Check free space and total space for each drive
CREATE TABLE #DiskSpace (
    DriveLetter CHAR(2),
    TotalSizeMB BIGINT,
    FreeSpaceMB BIGINT,
    UsedSpaceMB BIGINT,
    UsedPercent DECIMAL(5,2)
);

DECLARE @drive CHAR(2);
DECLARE @sql NVARCHAR(MAX);

DECLARE drive_cursor CURSOR FOR SELECT DriveLetter FROM @drives;

OPEN drive_cursor;
FETCH NEXT FROM drive_cursor INTO @drive;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = '
    EXEC master.dbo.xp_fixeddrives;
    ';

    -- xp_fixeddrives returns free space per drive in MB
    -- We'll query this for each drive and join with total size by WMI or other means
    -- Since xp_fixeddrives only returns free space, for simplicity, we use it here

    INSERT INTO #DiskSpace (DriveLetter, FreeSpaceMB)
    EXEC master.dbo.xp_fixeddrives;

    FETCH NEXT FROM drive_cursor INTO @drive;
END

CLOSE drive_cursor;
DEALLOCATE drive_cursor;

-- Simplify: Just show free space from xp_fixeddrives for all drives with SQL files

SELECT
    DriveLetter,
    FreeSpaceMB,
    NULL AS TotalSizeMB,
    NULL AS UsedSpaceMB,
    NULL AS UsedPercent
FROM #DiskSpace
WHERE DriveLetter IN (SELECT DriveLetter FROM @drives);

DROP TABLE #DiskSpace;

GO
