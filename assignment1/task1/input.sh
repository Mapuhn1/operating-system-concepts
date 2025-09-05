# input.sh

check_input_file() {
    if [[ -z "$INPUT_FILE" ]]; then
        read -p "Enter path or URL to CSV file: " INPUT_FILE
    fi

    if [[ "$INPUT_FILE" =~ ^http ]]; then
        log "Downloading remote CSV file..."
        wget -O users.csv "$INPUT_FILE" || { log "Download failed"; exit 1; }
        INPUT_FILE="users.csv"
    fi

    if [[ ! -f "$INPUT_FILE" ]]; then
        log "CSV file not found!"
        exit 1
    fi
}
