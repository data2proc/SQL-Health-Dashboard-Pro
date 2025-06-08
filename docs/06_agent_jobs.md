# Section 06: SQL Agent Jobs

## ✅ Purpose

Provides a detailed summary of SQL Server Agent jobs including their status, schedules, and last run outcomes for monitoring job health.

---

## 🧪 Checks Performed

| Check                 | Description                                  |
|-----------------------|----------------------------------------------|
| JobName               | Name of the SQL Agent job                    |
| JobStatus             | Enabled or Disabled                          |
| NextRunDate & Time    | Scheduled next run date and time             |
| LastRunStatus         | Status code of the last job execution        |
| LastRunStatusDescription | Human-readable description of last run status |
| LastRunDate & Time    | Timestamp of the last job execution           |

---

## 🖥️ Example Output

| JobName           | JobStatus | NextRunDate | NextRunTime | LastRunStatus | LastRunStatusDescription | LastRunDate | LastRunTime |
|-------------------|-----------|-------------|-------------|---------------|--------------------------|-------------|-------------|
| NightlyBackupJob  | Enabled   | 20250609    | 020000      | 1             | Succeeded                | 20250608    | 020005      |
| DataCleanupJob    | Disabled  | 0           | 0           | -1            | Never Run                | NULL        | NULL        |

---

## 📊 How to Interpret

- Enabled jobs should be running as scheduled.
- Review jobs with failed last runs and investigate.
- Disabled jobs may require review if they are critical.
- Check job schedules to ensure they align with operational windows.

---

## 🛠️ Recommendations

- Fix or disable failing jobs.
- Schedule jobs to minimize resource contention.
- Regularly monitor SQL Agent jobs for success.
- Clean up unused or obsolete jobs.

---

## 📌 Notes

Requires access to `msdb` database and permissions to read SQL Agent job info.
