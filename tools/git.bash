#!/bin/bash

function get_git_config() {
    echo "${GREEN}--- current git username:${BLUE} $(git config user.name)${NC}"
    echo "${GREEN}--- current git email:${BLUE} $(git config user.email)${NC}"
}

function set_git_work_config() {
    USERNAME=${GITHUB_WORK_USERNAME}
    EMAIL=${GITHUB_WORK_EMAIL}
    echo "${GREEN}--- changed git to work configuration${NC}"
    git config --global user.name "${USERNAME}"
    git config --global user.email "${EMAIL}"
    get_git_config
}

function set_git_personal_config() {
    USERNAME=${GITHUB_PERSONAL_USERNAME}
    EMAIL=${GITHUB_PERSONAL_EMAIL}
    echo "${GREEN}--- Changed git personal configuration -----${BLUE}"
    git config --global user.name "${USERNAME}"
    git config --global user.email "${EMAIL}"
    get_git_config
}

echo "${GREEN}--- git scripts loaded${NC} - available commands: set_git_work_config, set_git_personal_config, get_git_config"
get_git_config

