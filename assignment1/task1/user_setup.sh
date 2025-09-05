#!/bin/bash

# === Task 1: User Environment Setup ===

INPUT_FILE="$1"
LOGFILE="user_setup_$(date +%Y%m%d_%H%M%S).log"
source "$(dirname "$0")/input.sh"
check_input_file
