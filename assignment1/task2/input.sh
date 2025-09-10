# input.sh

check_backup_directory() {
    if [[ -z "$BACKUP_DIR" ]]; then
        read -p "Enter directory path to backup: " BACKUP_DIR
    fi
}
