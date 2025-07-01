#!/bin/bash

# --- Configuration ---
SOURCE_DIRECTORY="/home/ubuntu/<diretory>"
BACKUP_TARGET_DIR="/mnt/backups/my_data_backups"

# --- Create Backup Directory if it doesn't exist ---
# The -p flag ensures parent directories are created if necessary
# and suppresses error if the directory already exists.
mkdir -p "$BACKUP_TARGET_DIR"

# --- Generate Timestamp for the Backup File ---
# YYYY: Year (e.g., 2025)
# MM: Month (e.g., 06)
# DD: Day (e.g., 30)
# HH: Hour (24-hour format, e.g., 19)
# MM: Minute (e.g., 01)
# SS: Second (e.g., 17)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# --- Define the Full Path for the Backup File ---
# This will create a file like: documents_backup_20250630_190117.tar.gz
BACKUP_FILENAME="documents_backup_${TIMESTAMP}.tar.gz"
FULL_BACKUP_PATH="${BACKUP_TARGET_DIR}/${BACKUP_FILENAME}"

# --- Perform the Backup using tar and gzip ---
# tar: The archiving tool
# -c: Create a new archive
# -z: Compress the archive with gzip
# -v: Verbose output (show files being added)
# -f: Specify the archive file name
# "$FULL_BACKUP_PATH": The name of the output tar.gz file
# "$SOURCE_DIRECTORY": The directory to be archived
echo "Starting backup of ${SOURCE_DIRECTORY} to ${FULL_BACKUP_PATH}..."
tar -czvf "$FULL_BACKUP_PATH" "$SOURCE_DIRECTORY"

# --- Check if the Backup was Successful ---
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Backup file: ${FULL_BACKUP_PATH}"
    # Optionally, list the last few backups
    echo ""
    echo "Last 5 backups in ${BACKUP_TARGET_DIR}:"
    ls -lh "$BACKUP_TARGET_DIR" | tail -n 5
else
    echo "ERROR: Backup failed!"
    echo "Check the source directory, target directory permissions, and disk space."
fi

echo ""
