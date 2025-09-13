#!/bin/bash

# === Task 2: Backup Script Setup ===

DIR_PATH="$1"
LOGFILE="backup_$(date +%Y%m%d_%H%M%S).log"

source "$(dirname "$0")/logging.sh"



