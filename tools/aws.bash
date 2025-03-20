#!/bin/bash
source ~/development_scripts/.env

function get_aws_config() {
    echo "${GREEN}--- current aws profile:${BLUE} $(aws configure get profile)${NC}"
    echo "${GREEN}--- current aws region:${BLUE} $(aws configure get region)${NC}"

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

function generate_credential_report() {
    echo "${GREEN}--- generating credential report${NC}"
    aws iam generate-credential-report
}

function get_credential_report() {
    echo "${GREEN}--- getting credential report${NC}"
    aws iam get-credential-report
}

function ssh_to_ec2() {
    echo "${GREEN}--- ssh to ec2${NC}"
    if [ -z "$PEM_KEY_FILE" ] || [ -z "$EC2_INSTANCE_IP" ]; then
        echo "${RED}--- pem file or ec2 ip not configured${NC}"
        return
    fi
    chmod 0400 $PEM_KEY_FILE
    ssh -i $PEM_KEY_FILE ec2-user@$EC2_INSTANCE_IP
}

echo "${GREEN}--- aws scripts loaded${NC}"
echo "         available commands: aws_login, get_aws_config, aws_configure, get_current_aws_profile, get_aws_account, get_iam_users, generate_credential_report, get_credential_report"
