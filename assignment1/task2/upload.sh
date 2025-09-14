# upload.sh

upload_backup() {
    log "Uploading to $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
    
    if ! scp -P "$REMOTE_PORT" "$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"; then
        log "ERROR: Upload failed"
        exit 1
    fi
    
    log "Upload completed successfully"
}