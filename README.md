# SQL-Health-Dashboard-Pro

**SQL-Health-Dashboard-Pro** is a modular, professional-grade SQL Server health check tool designed to help database administrators assess, diagnose, and monitor the overall health of SQL Server instances with ease and clarity.

---

## 🎯 Project Goals

- Deliver a complete, actionable SQL Server health check toolkit
- Use best practices: modular SQL scripts, clean documentation, and automation-ready structure
- Empower DBAs and IT teams to identify problems before they become outages

---

## 📦 Folder Structure

SQL-Health-Dashboard-Pro/  
├── README.md                              # Main project overview  
├── health_dashboard_master.sql           # One-click execution script  
│  
├── sections/  
│   ├── 01_instance_info.sql  
│   ├── 02_database_summary.sql  
│   ├── 03_performance_metrics.sql  
│   ├── 04_backups.sql  
│   ├── 05_security.sql  
│   ├── 06_agent_jobs.sql    
│   ├── 07_index_stats_health.sql   
│   ├── 08_disk_monitoring.sql    
│   └── 09_alerts_mail.sql    
│  
└── docs/  
│   ├── 01_instance_info.md  
│   ├── 02_database_summary.md  
│   ├── 03_performance_metrics.md  
│   ├── 04_backups.md  
│   ├── 05_security.md  
│   ├── 06_agent_jobs.md    
│   ├── 07_index_stats_health.md   
│   ├── 08_disk_monitoring.md    
│   └── 09_alerts_mail.md    
    
  
  
---

## 🛠 How to Use

1. **Clone or download** this repository to your SQL admin machine.
2. Open `health_dashboard_master.sql` in SQL Server Management Studio (SSMS).
3. Execute the script to run all health checks.
4. Review results section-by-section.
5. (Optional) Use PowerShell automation to run and export the results.

> 💡 You must have VIEW SERVER STATE and appropriate privileges to run all checks.

---

## 🧪 Health Check Coverage

| Category              | Description                                      |
|----------------------|--------------------------------------------------|
| Instance Info         | SQL version, uptime, configuration               |
| Database Summary      | State, size, recovery model, file growth         |
| Performance           | Wait stats, top queries, blocking, TempDB usage |
| Backups               | Last full, diff, and log backups                 |
| Security              | Logins, roles, orphaned users                    |
| Agent Jobs            | Failed jobs, disabled jobs, durations            |
| Disk & File Monitoring| Free space, growth settings, fragmentation       |
| Alerts & Mail         | DB mail config, operators, alert status          |

Each of these is documented in detail under `/docs`.

---

## 📅 Planned Features

- Export results to Excel or HTML via PowerShell
- Visual dashboard (optional future module)
- SSIS/SQL Agent job integration

---

## 📧 Contact

Created by a SQL Server professional with 13+ years of experience.  
This tool is designed for daily use and client/server health assurance.  
For inquiries, feedback, or collaboration, please contact via [GitHub](#) or email.

---

## ✅ License

MIT License.


