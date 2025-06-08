# Section 05: Security Overview

## ✅ Purpose

Summarizes the server-level logins, their types, status, and database role memberships to help assess the security configuration.

---

## 🧪 Checks Performed

| Check               | Description                                 |
|---------------------|---------------------------------------------|
| LoginName          | Name of the login                            |
| LoginType          | Type (SQL Login, Windows User, Windows Group) |
| Status             | Enabled or Disabled                          |
| Password Policy    | Whether password expiration and policy are checked |
| DefaultDatabase    | Default database for the login              |
| CreateDate         | When the login was created                   |
| ModifyDate         | Last modification date                       |
| DatabaseRoles      | Comma-separated list of roles assigned in current database |

---

## 🖥️ Example Output

| LoginName | LoginType     | Status  | PasswordPolicy | DefaultDatabase | CreateDate           | ModifyDate           | DatabaseRoles      |
|-----------|---------------|---------|----------------|-----------------|----------------------|----------------------|--------------------|
| sa        | SQL Login     | Enabled | Yes            | master          | 2005-11-07 11:23:45  | 2024-12-01 10:00:00  | db_owner           |
| DOMAIN\User| Windows User  | Enabled | N/A            | master          | 2019-05-10 15:30:00  | 2020-06-15 12:00:00  | db_datareader, db_datawriter |

---

## 📊 How to Interpret

- Identify disabled logins to verify if they can be removed or require re-enabling.
- Check adherence to password policies for SQL logins.
- Review login default databases to avoid issues.
- Review role memberships for excessive privileges.

---

## 🛠️ Recommendations

- Disable or remove unused logins.
- Enforce strong password policies.
- Limit permissions according to the principle of least privilege.
- Audit and review logins regularly.

---

## 📌 Notes

Requires `VIEW SERVER STATE` and appropriate permissions to query `sys.server_principals` and `sys.sql_logins`.
