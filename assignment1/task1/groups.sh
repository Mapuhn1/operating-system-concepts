# groups.sh
# Adds the user to one or more groups, creating groups if they don't exist

setup_groups() {
    local username="$1"
    local groups="$2"

    # Skip if no groups are provided
    [[ -z "$groups" ]] && return

    # Split group list by semicolon and process each
    for g in $(echo "$groups" | tr ';' ' '); do
        # Create group if it doesn't exist
        if ! getent group "$g" >/dev/null; then
            sudo groupadd "$g" && log "Created group $g"
        fi

        # Add user to the group
        sudo usermod -aG "$g" "$username" && log "Added $username to $g"
    done
}