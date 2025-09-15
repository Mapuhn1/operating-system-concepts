#!/bin/bash

# === Task 2: Backup Script Setup ===

# Get target directory from first argument
DIR_PATH="$1"

# Create a timestamped logfile
LOGFILE="backup_$(date +%Y%m%d_%H%M%S).log"

# Load modular components
source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/input.sh"
source "$(dirname "$0")/backup.sh"
source "$(dirname "$0")/upload.sh"

# Validate backup directory
check_backup_directory

# Create compressed backup
create_backup

# Get remote upload details
get_remote_details

# Upload backup to remote location
upload_backup