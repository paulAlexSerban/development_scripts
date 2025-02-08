#!/bin/bash

function yarn_clean() {
    rm -rfv node_modules
    yarn cache clean
    yarn $@
}

echo "${GREEN}--- yarn helper scripts loaded${NC} - available commands: yarn_clean"
