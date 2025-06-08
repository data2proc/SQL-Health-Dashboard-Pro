/*
  01_instance_info.sql
  SQL Server Instance and Host Information
*/

PRINT '===== Section 01: Instance and Server Info =====';

SELECT
    @@SERVERNAME AS ServerName,
    SERVERPROPERTY('MachineName') AS MachineName,
    SERVERPROPERTY('InstanceName') AS InstanceName,
    SERVERPROPERTY('IsClustered') AS IsClustered,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel,
    SERVERPROPERTY('EngineEdition') AS EngineEdition,
    SERVERPROPERTY('IsFullTextInstalled') AS IsFullTextInstalled,
    SERVERPROPERTY('IsIntegratedSecurityOnly') AS IsIntegratedSecurityOnly,
    (SELECT sqlserver_start_time FROM sys.dm_os_sys_info) AS SQLServerStartTime,
    (SELECT cpu_count FROM sys.dm_os_sys_info) AS CpuCount,
    (SELECT physical_memory_kb FROM sys.dm_os_sys_info) / 1024 AS PhysicalMemoryMB,
    (SELECT virtual_machine_type_desc FROM sys.dm_os_sys_info) AS VirtualMachineType,
    (SELECT system_memory_state_desc FROM sys.dm_os_sys_info) AS MemoryState

GO
