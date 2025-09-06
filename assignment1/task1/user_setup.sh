#!/bin/bash

# === Task 1: User Environment Setup ===

INPUT_FILE="$1"
LOGFILE="user_setup_$(date +%Y%m%d_%H%M%S).log"

source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/input.sh"
source "$(dirname "$0")/user.sh"

check_input_file
tail -n +2 "$INPUT_FILE" | while IFS=',' read -r email birthDate groups sharedFolder; do
    username=$(generate_username "$email")

