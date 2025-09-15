# input.sh
# Handles backup directory validation and remote upload details

check_backup_directory() {
    # Prompt for backup directory if not set
    if [[ -z "$BACKUP_DIR" ]]; then
        read -p "Enter directory path to backup: " BACKUP_DIR
    fi

    # Exit if directory doesn't exist
    if [[ ! -d "$BACKUP_DIR" ]]; then
        log "ERROR: Directory '$BACKUP_DIR' does not exist"
        exit 1
    fi

    # Set the path and its archive name
    BACKUP_DIR=$(realpath "$BACKUP_DIR")
    BACKUP_NAME=$(basename "$BACKUP_DIR")
    ARCHIVE_NAME="${BACKUP_NAME}.tar.gz"

    log "Backing up: $BACKUP_DIR -> $ARCHIVE_NAME"
}

get_remote_details() {
    # Prompt for remote upload details
    read -p "Enter remote server IP/hostname: " REMOTE_HOST
    read -p "Enter port: " REMOTE_PORT
    read -p "Enter username: " REMOTE_USER
    read -p "Enter remote directory: " REMOTE_DIR

    # Default to port 22 if not provided
    REMOTE_PORT=${REMOTE_PORT:-22}

    # Exit if any required field is missing
    if [[ -z "$REMOTE_HOST" || -z "$REMOTE_USER" || -z "$REMOTE_DIR" ]]; then
        log "ERROR: All remote details are required"
        exit 1
    fi
}