#!/bin/bash

# Path to your JSON config
GIT_CONFIG_JSON="$HOME/.git_profiles.json"

set_git_profile() {
    local key=$1

    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo "❌ Error: 'jq' is not installed. Install it with 'brew install jq' or 'sudo apt install jq'."
        return 1
    fi

    # Check if the profile exists in JSON
    local exists=$(jq -r "has(\"$key\")" "$GIT_CONFIG_JSON")
    if [ "$exists" != "true" ]; then
        echo "❌ Profile '$key' not found in $GIT_CONFIG_JSON"
        return 1
    fi

    # Extract values from JSON
    local name=$(jq -r ".\"$key\".name" "$GIT_CONFIG_JSON")
    local email=$(jq -r ".\"$key\".email" "$GIT_CONFIG_JSON")
    local ssh_key=$(jq -r ".\"$key\".ssh_key" "$GIT_CONFIG_JSON")
    local gpg_key=$(jq -r ".\"$key\".gpg_key" "$GIT_CONFIG_JSON")

    # Apply Git Config
    git config --global user.name "$name"
    git config --global user.email "$email"
    
    if [ -n "$gpg_key" ] && [ "$gpg_key" != "null" ]; then
        git config --global user.signingkey "$gpg_key"
    fi

    # Handle SSH Key
    ssh-add -D &>/dev/null
    eval ssh-add "${ssh_key/#\~/$HOME}" &>/dev/null

    echo "🔄 Active GitHub Profile: $key ($email)"
}

# Path-based auto-switcher
# Path-based auto-switcher
check_git_profile_by_path() {
    local current_dir=$(pwd)
    
    # Check if the JSON file exists and is valid first to avoid spamming terminal errors
    if [ ! -f "$GIT_CONFIG_JSON" ]; then
        return
    fi
    
    # Robust jq filter: iterates over top keys, ensures the value is an object, 
    # verifies 'path' exists as a string, and looks for a substring match.
    local profile=$(jq -r --arg current_dir "$current_dir" '
        . as $profiles |
        keys_unsorted[] as $k |
        $profiles[$k] as $p |
        select(
            ($p | type == "object") and
            ($p.path | type == "string") and
            ($current_dir | contains($p.path))
        ) | $k
    ' "$GIT_CONFIG_JSON" | head -n 1)

    # If no match or null, exit without changing anything
    if [[ -z "$profile" || "$profile" == "null" ]]; then
        return
    fi

    # Verify if a switch is actually needed to prevent redundant output on every prompt load
    local target_email=$(jq -r ".\"$profile\".email" "$GIT_CONFIG_JSON")
    if [[ "$(git config --global user.email)" != "$target_email" ]]; then
        set_git_profile "$profile"
    fi

    echo "🔄 Automatically switched to $profile ($target_email)"
}

# Register Hooks
alias gprofile=set_git_profile

if [ -n "$BASH_VERSION" ]; then
    PROMPT_COMMAND="check_git_profile_by_path; $PROMPT_COMMAND"
elif [ -n "$ZSH_VERSION" ]; then
    chpwd_functions+=(check_git_profile_by_path)
    check_git_profile_by_path # Run on startup
fi