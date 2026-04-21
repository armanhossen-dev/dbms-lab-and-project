# DBMS Lab Notes & Project — Spring 2026 (DIU)



# XAMPP (macOS) – MySQL Update / Maintenance Guide

## ⚠️ Important Concept
- 🟢 **XAMPP ON** → Used for SQL login and queries
- 🔴 **XAMPP OFF** → Used for upgrades and maintenance tools

---

# 🟢 Step 1: Start XAMPP (Required for SQL commands)

Open **XAMPP Control Panel** and start:
 MySQL, Apache (optional)

| Open **XAMPP Control Panel** and start:|
|------|-----|
| MySQL | Apache (optional)  |

---


```sql
-- 💻 Login to MySQL
/Applications/XAMPP/xamppfiles/bin/mysql -u root

-- # Reset / Update Root User
-- Inside MySQL shell:
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';

-- Exit MySQL
exit;

```

🔴 Step 2: Stop XAMPP (Required for upgrade)
Stop services using:

XAMPP Control Panel OR
Terminal


sudo /Applications/XAMPP/xamppfiles/xampp stop

Make sure:

❌ MySQL is stopped
❌ Apache is stopped (recommended)

⚙️ Step 3: Run MySQL Upgrade
in terminal 
```bash
cd /Applications/XAMPP/xamppfiles/bin
./mysql_upgrade -u root
```

🔁 Step 4: Restart XAMPP

After upgrade is complete:

Open XAMPP Control Panel
Start:
MySQL
Apache (if needed)