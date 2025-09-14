#backup.sh

create_backup() {
    log "Creating archive: $ARCHIVE_NAME"

    if tar -czf "$ARCHIVE_NAME" -C "$(dirname "$BACKUP_DIR")" "$(basename "$BACKUP_DIR")"; then
        log "Archive created: $ARCHIVE_NAME"
    else
        log "ERROR: Failed to create archive"
        exit 1
    fi
}