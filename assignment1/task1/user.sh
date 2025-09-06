# user.sh

generate_username() {
    local email="$1"
    local firstname=$(echo "$email" | cut -d'.' -f1)
    local surname=$(echo "$email" | cut -d'.' -f2 | cut -d'@' -f1)
    echo "$(echo "${surname:0:1}")$(tr '[:lower:]' '[:upper:]' <<< ${firstname:0:1})${firstname:1}"
}

generate_password() {
    local birth="$1"
    echo "$(echo "$birth" | cut -d'/' -f1)$(echo "$birth" | cut -d'/' -f2)"
}

create_user() {
    local username="$1"
    local password="$2"
}