# Section 01: Instance and Server Info

## ✅ Purpose

Gather essential information about the SQL Server instance and its host environment to assess version, configuration, and resource baseline.

---

## 🧪 Checks Performed

| Check                        | Description                                  |
|-----------------------------|----------------------------------------------|
| ServerName                  | The SQL Server instance name                   |
| MachineName                 | The host machine name                          |
| InstanceName                | Named or default instance                       |
| IsClustered                 | Whether the instance is part of a cluster     |
| Edition                     | Edition (Express, Standard, Enterprise, etc.) |
| ProductVersion & Level      | Version number and patch level                 |
| EngineEdition               | Engine type (1=Personal, 2=Standard, etc.)    |
| FullText Installed          | If full-text search feature is installed       |
| Integrated Security Only    | Whether only integrated security is allowed    |
| SQL Server Start Time       | Date/time SQL Server last restarted             |
| CPU Count                   | Number of CPUs allocated                        |
| Physical Memory             | Total physical RAM in MB                        |
| Virtual Machine Type        | Whether running on a VM and which kind          |
| Memory State                | Memory state description                         |

---

## 🖥️ Example Output

| ServerName | MachineName | InstanceName | IsClustered | Edition     | ProductVersion | SQLServerStartTime       | CpuCount | PhysicalMemoryMB | VirtualMachineType | MemoryState      |
|------------|-------------|--------------|-------------|-------------|----------------|-------------------------|----------|-----------------|-------------------|------------------|
| SQLPROD01  | HOST01      | MSSQLSERVER  | 0           | Enterprise  | 15.0.2000.5    | 2025-06-08 08:45:12.000 | 8        | 16384           | None              | Normal           |

---

## 📊 How to Interpret

- Verify that **SQL Server version** and **edition** meet your support and feature requirements.
- Confirm the **uptime** (start time); frequent restarts may indicate instability.
- Check if running on a **virtual machine** and assess if resources match expectations.
- Check that **full-text indexing** and **security mode** fit your environment needs.

---

## 🛠️ Recommendations

- Patch SQL Server to the latest supported build.
- If using VMs, verify resource allocation and host configuration.
- Ensure SQL Server is part of a cluster if required for HA.
- Monitor server restarts and investigate unexpected reboots.

---

## 📌 Notes

Requires `VIEW SERVER STATE` permission to access `sys.dm_os_sys_info`.
