# upload.sh
# Uploads the backup archive to a remote server via SCP

upload_backup() {
    # Log upload destination
    log "Uploading to $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

    # Attempt upload via SCP
    if ! scp -P "$REMOTE_PORT" "$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"; then
        log "ERROR: Upload failed"
        exit 1
    fi
    
    # Log success
    log "Upload completed successfully"
}