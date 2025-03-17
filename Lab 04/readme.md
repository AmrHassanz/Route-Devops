# **Lab 4: Shell Scripting**

## **Objective**
This lab focuses on automating essential system tasks using Bash scripting. The scripts aim to enhance system management by automating updates, log maintenance, and backup procedures while ensuring efficient logging and alerting mechanisms.

---

## **Tasks Overview**

### **1. Automate System Updates & Logging**
#### **Script: `system_update.sh`**
**Purpose:**
- Automates system updates.
- Creates a log file for tracking update history.
- Appends timestamps to logs for reference.

**Implementation:**
- Updates the package list and upgrades all installed packages.
- Logs output and errors into `/var/log/system_update.log`.
- Adds a separator line after each run to maintain readability.



---

### **2. Compress & Move Log Files Older Than 7 Days**
#### **Script: `compress_old_logs.sh`**
**Purpose:**
- Reduces log file storage by compressing older log files.
- Moves compressed files to a designated backup directory.

**Implementation:**
- Ensures `gzip` is installed.
- Creates a backup directory if it doesn’t exist.
- Finds and compresses `.log` files older than 7 days.
- Moves compressed files to the backup directory.



### **3. Automate Daily System Backup & Alerts**
#### **Script: `daily_backup.sh`**
**Purpose:**
- Backs up critical system directories daily.
- Implements log rotation to manage backup history.
- Sends an alert email if the backup process fails.

**Implementation:**
- Creates a compressed backup of the `/home` directory.
- Stores backups in `/var/backups` with a timestamped filename.
- Logs backup status.
- Sends an email notification upon failure (requires `mailutils`).


## **Automating Execution with Cron Jobs**
To ensure these scripts run automatically, we can schedule them using `crontab`:


---

## **Conclusion**
These scripts enhance system automation by:
- Keeping the system updated.
- Managing log file storage efficiently.
- Ensuring critical data is backed up with failure alerts.

By scheduling them via `cron`, system administrators can ensure regular execution without manual intervention, improving overall system reliability and efficiency.

