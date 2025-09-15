# input.sh
# Handles input file validation and user confirmation

check_input_file() {
    # Prompt for input if not provided
    if [[ -z "$INPUT_FILE" ]]; then
        read -p "Enter path or URL to CSV file: " INPUT_FILE
    fi

    # Download file if input is a URL
    if [[ "$INPUT_FILE" =~ ^http ]]; then
        log "Downloading remote CSV file..."
        wget -O users.csv "$INPUT_FILE" || { log "Download failed"; exit 1; }
        INPUT_FILE="users.csv"
    fi

    # Exit if file doesn't exist
    if [[ ! -f "$INPUT_FILE" ]]; then
        log "CSV file not found!"
        exit 1
    fi
}

confirm_continue() {
    # Count users excluding header
    USER_COUNT=$(($(wc -l < "$INPUT_FILE") - 1))
    log "Found $USER_COUNT users in file."

    # Ask for confirmation before continuing
    read -p "Do you want to continue? (y/n): " confirm
    [[ "$confirm" != "y" ]] && exit 0
}