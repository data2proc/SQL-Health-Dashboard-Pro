# Section 07: Index and Statistics Health

## ✅ Purpose

Identifies indexes with high fragmentation and statistics that have not been updated recently, which can impact query performance.

---

## 🧪 Checks Performed

| Check                     | Description                                          |
|---------------------------|------------------------------------------------------|
| Fragmented Indexes        | Indexes with fragmentation percentage over 30%      |
| Outdated Statistics       | Statistics not updated in over 30 days               |

---

## 🖥️ Example Output

### Fragmented Indexes
| DatabaseName | SchemaName | TableName | IndexName      | IndexType        | AvgFragmentationInPercent | PageCount |
|--------------|------------|-----------|----------------|------------------|---------------------------|-----------|
| MyDatabase   | dbo        | Orders    | IX_Orders_Date | NONCLUSTERED     | 45.7                      | 15000     |

### Outdated Statistics
| DatabaseName | SchemaName | TableName | StatisticsLastUpdated | DaysSinceUpdate | StatsName   |
|--------------|------------|-----------|----------------------|-----------------|-------------|
| MyDatabase   | dbo        | Orders    | 2025-04-01           | 68              | IX_Orders_Date |

---

## 📊 How to Interpret

- Index fragmentation over 30% on large indexes usually indicates the need for rebuilding or reorganizing.
- Statistics older than 30 days may cause suboptimal query plans.
- Regular maintenance improves performance and plan quality.

---

## 🛠️ Recommendations

- Schedule index maintenance tasks (REBUILD or REORGANIZE) based on fragmentation levels.
- Update statistics regularly, either manually or with auto update statistics enabled.
- Monitor and adjust maintenance frequency as needed.

---

## 📌 Notes

- This query should be run per user database.
- Requires permissions to query `sys.dm_db_index_physical_stats`, `sys.indexes`, `sys.stats`.
