# Section 03: Performance Metrics

## ✅ Purpose

Collect important performance-related metrics including wait statistics, blocking sessions, and TempDB file usage to identify bottlenecks and performance issues.

---

## 🧪 Checks Performed

| Check               | Description                                         |
|---------------------|-----------------------------------------------------|
| Wait Statistics     | Top 10 wait types by total wait time                 |
| Blocking Sessions   | Current blocking sessions with blocking and blocked session IDs |
| TempDB Usage        | TempDB file sizes, growth settings, and max sizes   |

---

## 🖥️ Example Output

### Top Wait Types
| wait_type           | waiting_tasks_count | WaitTimeSeconds | MaxWaitTimeSeconds | SignalWaitTimeSeconds |
|---------------------|--------------------|-----------------|--------------------|----------------------|
| PAGEIOLATCH_SH      | 1024               | 540             | 120                | 200                  |
| LCK_M_X             | 200                | 320             | 150                | 100                  |

### Blocking Sessions
| BlockingSessionID | BlockedSessionID | wait_duration_ms | wait_type  | resource_description                |
|------------------|------------------|------------------|------------|-----------------------------------|
| 54               | 67               | 1000             | LCK_M_S    | KEY: 72057594037927936             |

### TempDB Usage
| file_id | name        | SizeMB | GrowthMB | max_size | GrowthDisplay |
|---------|-------------|--------|----------|----------|---------------|
| 1       | tempdev     | 256    | 64       | -1       | 64MB          |
| 2       | templog     | 64     | 10       | 512      | 10MB          |

---

## 📊 How to Interpret

- High wait times in specific wait types often highlight performance bottlenecks.
- Blocking sessions indicate concurrency issues that can slow down queries.
- TempDB files should be sized properly with reasonable growth settings to avoid contention and excessive autogrowth.

---

## 🛠️ Recommendations

- Investigate top wait types and address root causes (e.g., optimize queries, add indexes).
- Resolve blocking sessions quickly; consider indexing, query tuning, or isolation levels.
- Pre-size TempDB files adequately and configure growth as fixed MB increments.
- Monitor TempDB contention regularly.

---

## 📌 Notes

Requires `VIEW SERVER STATE` permission to query `sys.dm_os_wait_stats` and `sys.dm_os_waiting_tasks`.
