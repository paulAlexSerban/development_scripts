#!/bin/bash

# makes sure the folder containing the script will be the root folder
cd "$(dirname "$0")" || exit

function create_hash_password() {
    local username="$1"
    local password="$2"

    if [[ -z "$username" || -z "$password" ]]; then
        echo "Usage: create_hash_password <username> <password>"
        return 1
    fi

    htpasswd -nb "$username" "$password" | sed -e 's/\\$/\\$\\$/g'
}
