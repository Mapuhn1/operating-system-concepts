# user.sh
# Generates usernames and passwords

generate_username() {
    # Extract firstname and surname from email
    local email="$1"
    local firstname=$(echo "$email" | cut -d'.' -f1)
    local surname=$(echo "$email" | cut -d'.' -f2 | cut -d'@' -f1)

    # Format as first letter of surname + capitalised firstname
    echo "$(echo "${surname:0:1}")$(tr '[:lower:]' '[:upper:]' <<< ${firstname:0:1})${firstname:1}"
}

generate_password() {
    # Convert birthdate to YYYYMM format
    local birth="$1"
    local formatted_date=$(echo "$birth" | sed 's|/|-|g')
    local password=$(date -d "$formatted_date" +%Y%m 2>/dev/null)

    # Validate password format
    if [[ ! "$password" =~ ^[0-9]{6}$ ]]; then
        echo "Error: Invalid birthdate format ($birth). Expected YYYY/MM/DD"
        return 1
    fi
}

create_user() {
    # Create user and set password
    local username="$1"
    local password="$2"

    sudo useradd -m -s /bin/bash "$username" && log "Created user $username" || {
        log "Failed to create $username"
        return 1
    }

    echo "$username:$password" | sudo chpasswd
    sudo chage -d 0 "$username"  # Force password change on first login
}