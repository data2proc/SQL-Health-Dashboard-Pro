# Section 08: Alerts and Mail Configuration

## ✅ Purpose

Ensures that Database Mail, SQL Server Agent alerts, and operator notifications are properly configured to support automated monitoring and alerting.

---

## 🧪 Checks Performed

| Check                     | Description                                                  |
|---------------------------|--------------------------------------------------------------|
| Database Mail Enabled     | Whether the Database Mail XPs configuration is turned on     |
| Mail Accounts             | Lists all configured Database Mail accounts                  |
| SQL Server Agent Alerts   | Shows active alerts for message IDs or severity levels       |
| Operators                 | Lists operators configured to receive notifications          |
| SQL Agent Mail Profiles   | Verifies that SQL Agent is linked to a valid Mail profile    |

---

## 🖥️ Example Output

### Database Mail XPs

| ConfigName          | ValueInUse |
|---------------------|------------|
| Database Mail XPs   | 1          |

### Mail Accounts

| MailAccountName | EmailAddress        | DisplayName    | LastModified         |
|-----------------|---------------------|----------------|-----------------------|
| SQLMail         | dba@example.com     | SQL Alert Mail | 2025-06-01 08:15:22   |

### SQL Server Agent Alerts

| AlertName        | Severity | Enabled | DatabaseName | LastOccurrence |
|------------------|----------|---------|--------------|----------------|
| Severity 016     | 16       | 1       | msdb         | 20250608       |

### Operators

| OperatorName | EmailAddress       | Enabled | LastEmailDate |
|--------------|--------------------|---------|----------------|
| DBA Team     | dba@example.com    | 1       | 20250608       |

---

## 📊 How to Interpret

- Alerts and mail configurations are essential for proactive monitoring.
- A misconfigured mail system means no alerts during failures.
- Alerts tied to severities or specific errors help DBAs respond quickly.

---

## 🛠️ Recommendations

- Enable Database Mail and test with a sample message.
- Create alerts for high-severity issues (16–25).
- Ensure operators are actively monitored and have valid emails.
- Link SQL Server Agent to a valid Database Mail profile.

---

## 📌 Notes

- Requires `msdb` access and SQLAgentOperatorRole permissions.
- Alerts will not fire unless SQL Server Agent is running.
