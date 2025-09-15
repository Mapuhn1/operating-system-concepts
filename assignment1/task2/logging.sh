# logging.sh
# Logs a message with a timestamp to both console and logfile

log() {
    echo "$(date): $1" | tee -a "$LOGFILE"
}