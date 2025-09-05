#!/bin/bash
# Simple User Onboarding Script
# This script reads users.csv and creates users, groups, and directories

# Variables
CSV_FILE="users.csv"
LOG_FILE="/var/log/user_onboarding_audit.log"

# Function to log messages with timestamp
log_action() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

# Start logging
log_action "=== Starting user onboarding process ==="

# Check if CSV file exists
if [ ! -f "$CSV_FILE" ]; then
    log_action "ERROR: users.csv file not found!"
    exit 1
fi

# Read CSV file line by line
while IFS=',' read -r username groupname shell
do
    # Skip empty lines and header
    if [ -z "$username" ] || [ "$username" = "username" ]; then
        continue
    fi
    
    # Remove any extra spaces
    username=$(echo "$username" | tr -d ' ')
    groupname=$(echo "$groupname" | tr -d ' ')
    shell=$(echo "$shell" | tr -d ' ')
    
    log_action "Processing user: $username, group: $groupname, shell: $shell"
    
    # Check if username has valid characters (basic check)
    if [[ ! "$username" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        log_action "ERROR: Invalid username: $username"
        continue
    fi
    
    # Check if shell exists
    if [ ! -f "$shell" ]; then
        log_action "ERROR: Shell $shell does not exist"
        continue
    fi
    
    # 1. Check if user exists
    if id "$username" &>/dev/null; then
        log_action "User $username already exists, updating shell"
        usermod -s "$shell" "$username"
        log_action "Updated shell for $username to $shell"
    else
        log_action "Creating new user: $username"
        useradd -m -s "$shell" "$username"
        log_action "Created user $username with shell $shell"
    fi
    
    # 2. Check if group exists, create if not
    if ! getent group "$groupname" &>/dev/null; then
        log_action "Creating group: $groupname"
        groupadd "$groupname"
        log_action "Created group $groupname"
    fi
    
    # 3. Add user to group
    usermod -a -G "$groupname" "$username"
    log_action "Added user $username to group $groupname"
    
    # 4. Setup home directory with 700 permissions
    HOME_DIR="/home/$username"
    if [ -d "$HOME_DIR" ]; then
        chown "$username:$username" "$HOME_DIR"
        chmod 700 "$HOME_DIR"
        log_action "Set permissions 700 for home directory $HOME_DIR"
    else
        log_action "ERROR: Home directory $HOME_DIR does not exist"
    fi
    
    # 5. Create project directory
    PROJECT_DIR="/opt/projects/$username"
    
    # Create /opt/projects if it doesn't exist
    if [ ! -d "/opt/projects" ]; then
        mkdir -p "/opt/projects"
        log_action "Created /opt/projects directory"
    fi
    
    # Create user's project directory
    mkdir -p "$PROJECT_DIR"
    chown "$username:$groupname" "$PROJECT_DIR"
    chmod 750 "$PROJECT_DIR"
    log_action "Created project directory $PROJECT_DIR with permissions 750"
    
    log_action "Successfully processed user: $username"
    log_action "---"
    
done < "$CSV_FILE"

log_action "=== User onboarding process completed ==="

# Show summary
echo ""
echo "Script completed! Check the log file for details:"
echo "cat $LOG_FILE"
