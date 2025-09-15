#!/bin/bash

function is_linux() {
    [[ "$(uname)" == "Linux" ]] && return 0 || return 1
}


function is_ubuntu() {
    if is_linux; then
        [[ -f /etc/os-release ]] || return 1
        source /etc/os-release
        [[ "$ID" == "ubuntu" ]] && return 0 || return 1
    else
        return 1
    fi
}
