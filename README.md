# 🚀 DevOps Practice Repository

This repository contains my **Week 1 DevOps Foundation Practice** — focusing on **Linux, Git, Bash scripting, and DevOps fundamentals**.

---

## 🧩 Week 1 Overview

### 🔹 Focus Areas
- Linux Commands & Automation
- Git & GitHub Version Control
- Bash Scripting
- DevOps Core Concepts (CI/CD, IaC, GitOps, Observability)

---

## 📜 Bash Scripts

| Script | Description |
|--------|--------------|
| `Backup_Scripts` | Takes backup of `/var/log` and stores it in `/backup`. |
| `log_cleanup.sh` | Deletes logs older than 7 days. |
| `disk_monitor.sh` | Checks disk usage and sends alerts if usage exceeds threshold. |
| `system_health_check.sh` | (Optional) Checks CPU, memory, and process stats. |
| `user_activity_report.sh` | (Optional) Monitors user logins and activity. |

### ▶ How to Run Scripts
```bash
cd scripts/
chmod +x <script_name>.sh
./<script_name>.sh

--------
Simulate High Disk Usage:-
Create a large dummy file using sudo fallocate -l 5G /tmp/fillfile
Verify your Diks usage script then remove the dummy file sudo rm -f /tmp/fillfile
