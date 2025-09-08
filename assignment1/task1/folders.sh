# folders.sh

setup_shared_folder(){
    local username="$1"
    local folder="$2"
    [[ -z "$folder" ]] && return

    if [[ ! -d "$folder" ]]; then
        sudo mkdir -p "$folder"
        sudo chmod 770 "$folder"
        sudo chown root:root "$folder"
        log "Created shared folder $folder"
    fi

    local group=$(basename "$folder")
    if ! getent group "$group" >/dev/null; then
        sudo groupadd "$group" && log "Created group $group for folder"
    fi

    sudo usermod -aG "$group" "$username"
    sudo chgrp "$group" "$folder"
    sudo chmod 770 "$folder"
}