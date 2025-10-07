#!/bin/bash
# user_activity_report.sh - Monitors user login activity and generates a report

# Variables
REPORT_DIR="$HOME/user_activity"
REPORT_FILE="$REPORT_DIR/user_activity_$(date +'%Y-%m-%d_%H-%M-%S').log"

# Create report directory if it doesn't exist
mkdir -p "$REPORT_DIR"

#Header
echo "=======================User Activity Report======================" > "$REPORT_FILE"
echo "Generated on: $(date)" >> "$REPORT_FILE"
echo "-----------------------------------------------------------------" >> "$REPORT_FILE"

#Section 1: Currently logged-in users
echo -e "\n[1] Currently Logged-in Users:" >> "$REPORT_FILE"
who >> "$REPORT_FILE"

#Section 2: Last login details
echo -e "\n[2] Last Login Details:" >> "$REPORT_FILE"
lastlog | head -n 20 >> "$REPORT_FILE"

#Section 3: Recent login sessions
echo -e "\n[3] Recent Login Session (last 10 entries):" >> "$REPORT_FILE"
last -n 10 >> "$REPORT_FILE"

#Section 4: Failed login attempts
echo -e "\n[4] Failed Login Attempts (if any):" >> "$REPORT_FILE"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -n 10 >> "$REPORT_FILE"
else
    echo "auth.log not found or insufficient permission" >> "$REPORT_FILE"
fi

#Section 5: Idle users
echo -e "\n[5] Idle users:" >> "$REPORT_FILE"
w | awk 'NR>2 {print $1, $5}' >> "$REPORT_FILE"

#Section 6: Active user processes
echo -e "\n[6] Active User Processes:" >> "$REPORT_FILE"
ps -eo user,pid,ppid,stime,etime,cmd --sort=user | head -n 20 >> "$REPORT_FILE"

#Footer
echo -e "\n=======================================================" >> "$REPORT_FILE"
echo "Report saved to: $REPORT_FILE"
echo "============================================================"

#Display path of report
echo "User activity report generated at: $REPORT_FILE"
