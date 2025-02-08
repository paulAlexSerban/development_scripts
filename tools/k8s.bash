#!/bin/bash

# Function to update kubeconfig for all EKS clusters in the current AWS account
function update_kubeconfig() {
    # Get AWS account ID
    ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account')
    if [ $? -ne 0 ]; then
        echo -e "${RED}--- Failed to get AWS account ID. Please check your AWS credentials. ${NC}"
        exit 1
    fi

    echo -e "${BLUE}--- Updating kubeconfig for all EKS clusters in account $ACCOUNT_ID ${NC}"

    # List all EKS clusters and update kubeconfig for each
    CLUSTERS=$(aws eks list-clusters --output text --query 'clusters')
    if [ $? -ne 0 ]; then
        echo -e "${RED}--- Failed to list EKS clusters. Please check your AWS permissions. ${NC}"
        exit 1
    fi

    if [ -z "$CLUSTERS" ]; then
        echo -e "${RED}--- No EKS clusters found in account $ACCOUNT_ID ${NC}"
        exit 0
    fi

        # Convert space-separated cluster names to array
    CLUSTER_ARRAY=($(echo "$CLUSTERS" | tr -s ' ' '\n'))

    # Iterate over each cluster name in the list
    for CLUSTER in $CLUSTER_ARRAY; do
        echo -e "${BLUE}--- Updating kubeconfig for cluster: $CLUSTER ${NC}"
        aws eks update-kubeconfig --name "$CLUSTER"
        if [ $? -ne 0 ]; then
            echo -e "${RED}--- Failed to update kubeconfig for cluster: $CLUSTER ${NC}"
        else
            echo -e "${GREEN}--- Successfully updated kubeconfig for cluster: $CLUSTER ${NC}"
        fi
    done
}

echo -e "${GREEN}--- K8S scripts loaded${NC} - available commands: update_kubeconfig"
