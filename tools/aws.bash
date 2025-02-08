#!/bin/bash

function get_aws_config() {
    echo "${GREEN}--- current aws profile:${BLUE} $(aws configure get profile)${NC}"
}

function aws_configure() {
    echo "${GREEN}--- configuring aws${NC}"
    aws configure
    get_aws_config
}

function aws_login_default() {
    echo "${GREEN}--- logging out of aws${NC}"
    aws configure set profile default
    get_aws_config
}

function get_current_aws_profile() {
    echo "${GREEN}--- current aws profile:${BLUE} $(aws configure get profile)${NC}"
}

function get_aws_account() {
    echo "${GREEN}--- current aws account:${BLUE} $(aws sts get-caller-identity --output text)${NC}"
}

function get_iam_users() {
    echo "${GREEN}--- iam users:${BLUE} $(aws iam list-users --output json)${NC}"
}

echo "${GREEN}--- aws scripts loaded${NC} - available commands: aws_login, get_aws_config, aws_configure, get_current_aws_profile, get_aws_account, get_iam_users"

get_aws_config
get_aws_account
