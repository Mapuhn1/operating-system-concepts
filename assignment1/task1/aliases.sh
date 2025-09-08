# aliases.sh

setup_aliases() {
    local username="$1"
    if groups "$username" | grep -q "sudo"; then
    
}