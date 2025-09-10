# logging.sh

log() {
    echo "$(date): $1" | tee -a "$LOGFILE"
}