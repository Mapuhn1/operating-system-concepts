# folders.sh
# Sets up a shared folder and links it into the user's home directory

setup_shared_folder(){
    local username="$1"
    local folder="$2"

    # Skip if folder is empty
    [[ -z "$folder" ]] && return

    # Create folder if it doesn't exist
    if [[ ! -d "$folder" ]]; then
        sudo mkdir -p "$folder"
        sudo chmod 770 "$folder"
        sudo chown root:root "$folder"
        log "Created shared folder $folder"
    fi

    # Use folder name as group name
    local group=$(basename "$folder")

    # Create group if it doesn't exist
    if ! getent group "$group" >/dev/null; then
        sudo groupadd "$group" && log "Created group $group for folder"
    fi

    # Add user to group and set folder permissions
    sudo usermod -aG "$group" "$username"
    sudo chgrp "$group" "$folder"
    sudo chmod 770 "$folder"

    # Link folder into user's home and set ownership
    sudo ln -s "$folder" "/home/$username/shared"
    sudo chown -h "$username:$username" "/home/$username/shared"
 
    log "Linked $folder into /home/$username/shared"
}