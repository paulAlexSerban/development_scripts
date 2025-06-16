#!/bin/bash

function create_hash_password() {
    local username="$1"
    local password="$2"

    if [[ -z "$username" || -z "$password" ]]; then
        echo "Usage: create_hash_password <username> <password>"
        return 1
    fi

    htpasswd -nb "$username" "$password" | sed -e 's/\\$/\\$\\$/g'
}
