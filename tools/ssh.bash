#!/bin/bash

function init_ssh_connection() {
    echo "Path to the .pem file:"
    read PEM_FILE
    echo "Username:"
    read USERNAME
    echo "Host:"
    read HOST
    chmod 400 ${PEM_FILE}
    ssh -i ${PEM_FILE} ${USERNAME}@${HOST}
}

echo "${GREEN}--- ssh scripts loaded${NC}"
echo "         available commands: init_ssh_connection"