# input.sh

check_backup_directory() {
    if [[ -z "$BACKUP_DIR" ]]; then
        read -p "Enter directory path to backup: " BACKUP_DIR
    fi
    
    if [[ ! -d "$BACKUP_DIR" ]]; then
        log "ERROR: Directory '$BACKUP_DIR' does not exist"
        exit 1
    fi
    
    BACKUP_DIR=$(realpath "$BACKUP_DIR")
    BACKUP_NAME=$(basename "$BACKUP_DIR")
    ARCHIVE_NAME="${BACKUP_NAME}.tar.gz"
    
    log "Backing up: $BACKUP_DIR -> $ARCHIVE_NAME"
}

get_remote_details() {
    read -p "Enter remote server IP/hostname: " REMOTE_HOST
    read -p "Enter port: " REMOTE_PORT
    read -p "Enter username: " REMOTE_USER
    read -p "Enter remote directory: " REMOTE_DIR
    
    REMOTE_PORT=${REMOTE_PORT:-22}
}