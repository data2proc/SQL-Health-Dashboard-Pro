/*
  07_index_stats_health.sql
  Checks for fragmented indexes and outdated statistics on user databases.
*/

PRINT '===== Section 07: Index and Statistics Health =====';

-- Fragmented Indexes (over 30% fragmentation)
SELECT 
    DB_NAME() AS DatabaseName,
    OBJECT_SCHEMA_NAME(ips.object_id) AS SchemaName,
    OBJECT_NAME(ips.object_id) AS TableName,
    i.name AS IndexName,
    ips.index_type_desc,
    ips.avg_fragmentation_in_percent,
    ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.avg_fragmentation_in_percent > 30
  AND ips.page_count > 1000 -- consider only large indexes
ORDER BY ips.avg_fragmentation_in_percent DESC;

-- Outdated Statistics (last updated > 30 days ago)
SELECT 
    DB_NAME() AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    STATS_DATE(t.object_id, s.stats_id) AS StatisticsLastUpdated,
    DATEDIFF(DAY, STATS_DATE(t.object_id, s.stats_id), GETDATE()) AS DaysSinceUpdate,
    s.name AS StatsName
FROM sys.stats s
JOIN sys.tables t ON s.object_id = t.object_id
WHERE STATS_DATE(t.object_id, s.stats_id) < DATEADD(DAY, -30, GETDATE())
ORDER BY DaysSinceUpdate DESC;

GO
