#!/bin/bash

# === Task 1: User Environment Setup ===

INPUT_FILE="$1"
LOGFILE="user_setup_$(date +%Y%m%d_%H%M%S).log"

source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/input.sh"
source "$(dirname "$0")/user.sh"
source "$(dirname "$0")/groups.sh"
source "$(dirname "$0")/folders.sh"
source "$(dirname "$0")/aliases.sh"

check_input_file
confirm_continue

tail -n +2 "$INPUT_FILE" | while IFS=',' read -r email birthDate groups sharedFolder; do
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
done

log "Script finished. See $LOGFILE for details."