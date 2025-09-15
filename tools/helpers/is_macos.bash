#!/bin/bash

function is_macos() {
    [[ "$(uname)" == "Darwin" ]] && return 0 || return 1
}