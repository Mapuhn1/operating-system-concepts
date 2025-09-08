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

confirm_continue() {
    USER_COUNT=$(($(wc -l < "$INPUT_FILE") - 1))
    log "Found $USER_COUNT users in file."
    read -p "Do you want to continue? (y/n): " confirm
    [[ "$confirm" != "y" ]] && exit 0
}