#!/bin/bash

function get_ip() {
    IP=$(ifconfig en0 | awk '$1 == "inet" {print $2}')
    echo "${GREEN}--- your ip is:${BLUE} $IP${NC}"
}

function check_internet_connection() {
    ping -c 1 google.com &>/dev/null
    if [ $? -eq 0 ]; then
        echo "${GREEN}--- you are connected to the internet.${NC}"
    else
        echo "${RED}--- you are not connected to the internet.${NC}"
    fi
}

function check_connection_speed() {
    if [ -x "$(command -v speedtest --version)" ]; then
        speedtest
    else
        echo "speedtest is not installed."
        echo "go to https://www.speedtest.net/apps/cli"
    fi

}

echo "${GREEN}--- networking scripts loaded${NC} - available commands: check_internet_connection, check_connection_speed, get_ip"
get_ip
