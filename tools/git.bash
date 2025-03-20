#!/bin/bash
source ~/development_scripts/.env

function get_git_config() {
    echo "${GREEN}--- current git username:${BLUE} $(git config user.name)${NC}"
    echo "${GREEN}--- current git email:${BLUE} $(git config user.email)${NC}"
}

function set_git_work_config() {
    echo "${GREEN}--- changed git to work configuration${NC}"
    git config --global user.name ${GITHUB_WORK_USERNAME}
    git config --global user.email ${GITHUB_WORK_EMAIL}
    get_git_config
}

function set_git_personal_config() {
    echo "${GREEN}--- Changed git personal configuration -----${BLUE}"
    git config --global user.name ${GITHUB_PERSONAL_USERNAME}
    git config --global user.email ${GITHUB_PERSONAL_EMAIL}
    get_git_config
}

echo "${GREEN}--- git scripts loaded${NC}"
echo "         available commands: set_git_work_config, set_git_personal_config, get_git_config"
get_git_config

