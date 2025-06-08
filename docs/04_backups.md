# Section 04: Backup and Restore Status

## ✅ Purpose

Provides insight into the backup health of each database by reporting the most recent full, differential, and log backups.

---

## 🧪 Checks Performed

| Check                  | Description                                  |
|------------------------|----------------------------------------------|
| DatabaseName           | Name of the database                          |
| LastBackupDate         | Most recent backup date (any type)           |
| LastFullBackup         | Most recent full backup date                  |
| LastDifferentialBackup | Most recent differential backup date         |
| LastLogBackup          | Most recent transaction log backup date      |

---

## 🖥️ Example Output

| DatabaseName  | LastBackupDate        | LastFullBackup       | LastDifferentialBackup | LastLogBackup         |
|---------------|----------------------|---------------------|-----------------------|----------------------|
| AdventureWorks| 2025-06-07 22:00:00  | 2025-06-07 22:00:00 | 2025-06-08 02:00:00   | 2025-06-08 05:00:00  |
| master        | 2025-06-01 00:00:00  | 2025-06-01 00:00:00 | NULL                  | NULL                 |

---

## 📊 How to Interpret

- Databases should have recent backups according to your backup policy.
- Full backups are critical; differentials and logs depend on your recovery model.
- Missing backups or very old backups are a serious risk.

---

## 🛠️ Recommendations

- Investigate any databases without recent backups.
- Schedule regular full, differential, and log backups based on your RPO and RTO.
- Automate backup monitoring and alert on failures or delays.

---

## 📌 Notes

- This query relies on the `msdb` database backup history tables.
- Requires appropriate permissions to read `msdb.dbo.backupset`.
