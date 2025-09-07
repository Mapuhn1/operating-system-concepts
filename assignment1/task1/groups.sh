# groups.sh

setup_groups() {
    local username="$1"
    local groups="$2"
    [[ -z "$groups" ]] && return

    for g in $(echo "$groups" | tr ';' ' '); do
        if ! getent group "$g" >/dev/null; then
            sudo groupadd "$g" && log "Created group $g"
        fi
        sudo usermod -aG "$g" "$username" && log "Added $username to $g"
    done
}