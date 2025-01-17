#!/bin/bash

# check if a log directory is provided as an argument

if [ -z "$1" ]; then
 echo "Error: No log directory provided"
 echo "Usage: log-arhive <log-directory>"
 exit 1
fi

# Define Variables
LOG_DIR="$1"
ARCHIVE_DIR="/var/log_archive"  # destination sdirectory for archived logs
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")  # Current date and time
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"  # Archive file name
LOG_FILE="/var/log_archive/archive_log.txt"  # Log file to store archive info

# Ensure the log directory exits
if [ ! -d "$LOG_DIR" ]; then
 echo "Error: Log directory '$LOG_DIR' does not exits."
 exit 1
fi

# Create the archive directory if it doesn't exist
if [ ! -d "$ARCHIVE_DIR" ]; then
 mkdir -p "ARCHIVE_DIR"
fi

# Archive logs, excluding the journal directory
if tar --exclude=/var/log/journal -czf "$ARCHIVE_DIR/logs_archive_${TIMESTAMP}.tar.gz" "$LOG_DIR"; then
 echo "Logs succesfully archived at $ARCHIVE_DIR/logs_archive_${TIMESTAMP}.tar.gz"
else
 echo "Error: failed to archive logs."
 exit 1
fi

# Compress the logs and store in the archive directory
tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .

#Check is the compression was suuccessful
if [ $? -eq 0 ]; then
 echo "Logs archived succesfully: ${ARCHIVE_DIR}/${ACHIVE_NAME}"

 #  Log the operation with date and time
 echo "[$(date + "%Y-%m-%d %H:%M:%S")] Logs archived to ${ARCHIVE_NAME}" >> "$LOG_FILE"
else
 echo "Error: failed to archive logs."
 exit
fi

this is the final code but to be honest i don't understand anything what is happening here what should i learn to uderstand this what is im lacking