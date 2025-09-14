# aliases.sh

setup_aliases() {
    local username="$1"
    if groups "$username" | grep -q "sudo"; then
        echo "alias myls='ls -al'" | sudo tee -a "/home/$username/.bash_aliases" >/dev/null
        sudo chown "$username:$username" "/home/$username/.bash_aliases"

        log "Added alias myls for $username"
    fi
}