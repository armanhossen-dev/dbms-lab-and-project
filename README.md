# DBMS Lab Notes & Project — Spring 2026 (DIU)


Notes: **XAMPP** (macOS) – MySQL Update / Maintenance Guide

## ⚠️ Important Concept
- 🟢 **XAMPP ON** → Used for SQL login and queries
- 🔴 **XAMPP OFF** → Used for upgrades and maintenance tools

---

# 🟢 Step 1: Start XAMPP (Required for SQL commands)

Open **XAMPP Control Panel** and start:
 MySQL, Apache (optional)

# Open **XAMPP Control Panel** and start:|
| Service 1 | Service 2 |
| :--- | :--- |
| MySQL | Apache (optional) |

## Paste the sql commands following the comments.

```sql
-- 💻 Login to MySQL
/Applications/XAMPP/xamppfiles/bin/mysql -u root
```

# Reset / Update Root User
```sql
-- Inside MySQL shell:
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
```

## wait for finish

```sql
-- Exit MySQL
exit;
```

# 🔴 Step 2: Stop XAMPP (Required for upgrade)

|Make sure |
|:---|:---|
| MySQL is stopped | Apache is stopped  (recommended)|

```sql
sudo /Applications/XAMPP/xamppfiles/xampp stop
```

# ⚙️ Step 3: Run MySQL Upgrade
```sql
cd /Applications/XAMPP/xamppfiles/bin
./mysql_upgrade -u root
```

# 🔁 Step 4: Restart XAMPP

- After upgrade is complete:
- Open XAMPP Control Panel
- Start:
  - MySQL
  - Apache (if needed)
