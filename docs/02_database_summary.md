# Section 02: Database Summary

## ✅ Purpose

Provides a comprehensive overview of all databases on the SQL Server instance, focusing on status, size, recovery models, and key properties.

---

## 🧪 Checks Performed

| Check              | Description                                       |
|--------------------|-------------------------------------------------|
| DatabaseName       | Name of the database                             |
| State              | Database state (ONLINE, RESTORING, SUSPECT, etc.) |
| RecoveryModel      | Recovery model (FULL, SIMPLE, BULK_LOGGED)       |
| UserAccess         | Access mode (MULTI_USER, SINGLE_USER, RESTRICTED_USER) |
| ReadOnly           | Whether the database is read-only                 |
| AutoShrink         | Whether auto-shrink is enabled                    |
| AutoClose          | Whether auto-close is enabled                     |
| CompatibilityLevel | SQL Server compatibility level                    |
| SizeMB             | Total size of the database in MB                   |
| CreateDate         | Database creation date                             |
| ModifyDate         | Last modification date                             |

---

## 🖥️ Example Output

| DatabaseName | State   | RecoveryModel | UserAccess | ReadOnly | AutoShrink | AutoClose | CompatibilityLevel | SizeMB  | CreateDate            | ModifyDate            |
|--------------|---------|---------------|------------|----------|------------|-----------|--------------------|---------|-----------------------|-----------------------|
| master       | ONLINE  | SIMPLE        | MULTI_USER | 0        | 0          | 0         | 150                | 5.12    | 2005-11-07 11:23:45.0 | 2025-06-01 13:00:00.0 |
| AdventureWorks | ONLINE | FULL          | MULTI_USER | 0        | 0          | 0         | 150                | 1024.75 | 2014-07-01 09:45:00.0 | 2025-06-05 10:15:00.0 |

---

## 📊 How to Interpret

- Databases should generally be **ONLINE** and accessible.
- Recovery model selection should align with your backup/restore strategy.
- AutoShrink and AutoClose are usually recommended to be **OFF** for production.
- Compatibility level indicates the SQL Server version features the DB supports.
- Large database size may affect backup and maintenance times.

---

## 🛠️ Recommendations

- Investigate any databases not ONLINE.
- Ensure recovery models match your disaster recovery plan.
- Disable AutoShrink and AutoClose if enabled in production.
- Review database size trends for capacity planning.

---

## 📌 Notes

Requires standard access to `sys.databases`.
