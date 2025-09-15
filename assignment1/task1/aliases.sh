# aliases.sh
# Adds a custom alias to the user's shell if they are a sudoer

setup_aliases() {
    local username="$1"

    # Check if the user is in the sudo group
    if groups "$username" | grep -q "sudo"; then
        # Append the alias definition to the user's .bash_aliases file
        echo "alias myls='ls -al'" | sudo tee -a "/home/$username/.bash_aliases" >/dev/null

        # Ensure the user owns their alias file
        sudo chown "$username:$username" "/home/$username/.bash_aliases"

        # Log the alias creation
        log "Added alias myls for $username"
    fi
}