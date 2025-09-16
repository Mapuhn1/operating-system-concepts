#!/bin/bash

# === Task 1: User Environment Setup ===

INPUT_FILE="$1"
LOGFILE="user_setup_$(date +%Y%m%d_%H%M%S).log"

# Source component modules
source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/input.sh"
source "$(dirname "$0")/user.sh"
source "$(dirname "$0")/groups.sh"
source "$(dirname "$0")/folders.sh"
source "$(dirname "$0")/aliases.sh"

# Validate input and confirm execution
check_input_file
confirm_continue

# Process each user entry
while IFS=',' read -r email birthDate groups sharedFolder; do
    username=$(generate_username "$email")
    password=$(generate_password "$birthDate")
    

    log "Processing user: $username ($email)"
    if id "$username" &>/dev/null; then
        log "User $username already exists, skipping..."
        continue
    fi

    create_user "$username" "$password"   
    setup_groups "$username" "$groups"
    setup_shared_folder "$username" "$sharedFolder"
    setup_aliases "$username"

    log "Finished setting up $username"
    echo "-------------------------------------------"
done < <(tail -n +2 "$INPUT_FILE" | tr -d '\r' | sed 's/"//g')

log "Script finished. See $LOGFILE for details."