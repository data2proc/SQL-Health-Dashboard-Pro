# Section 08: Disk Monitoring

## ✅ Purpose

Monitor free disk space on drives where SQL Server data and log files reside, to prevent disk space-related issues.

---

## 🧪 Checks Performed

| Check       | Description                          |
|-------------|------------------------------------|
| DriveLetter | Drive letter (e.g., C:, D:)         |
| FreeSpaceMB | Available free space on the drive (MB) |

---

## 🖥️ Example Output

| DriveLetter | FreeSpaceMB |
|-------------|-------------|
| C:          | 15000       |
| D:          | 2000        |

---

## 📊 How to Interpret

- Drives with low free space can cause SQL Server to stop writing logs or data files.
- Monitor and ensure free space stays above a safe threshold (e.g., > 10% or > 5 GB).

---

## 🛠️ Recommendations

- Clean up or expand disk space if free space is low.
- Consider moving data/log files if disk is near capacity.
- Set up alerts for low disk space.

---

## 📌 Notes

- This uses `xp_fixeddrives` extended stored procedure which requires appropriate permissions.
- Total disk size and used percentage are not available directly from SQL Server; consider OS-level monitoring tools for detailed info.
