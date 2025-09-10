# input.sh

check_backup_directory() {
    if [[ -z "$BACKUP_DIR" ]]; then
        read -p "Enter directory path to backup: " BACKUP_DIR
    fi
    
    if [[ ! -d "$BACKUP_DIR" ]]; then
        log "ERROR: Directory '$BACKUP_DIR' does not exist"
        exit 1
    fi
