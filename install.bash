#!/bin/bash

# check if the entry.bash is already sourced in the .zshrc file and if not, add it
grep -q 'source ~/development_scripts/entry.bash' ~/.zshrc || echo 'source ~/development_scripts/entry.bash' >> ~/.zshrc

# check if the .env file is already created and if not, create it
[ -f ~/development_scripts/.env ] || touch ~/development_scripts/.env

# copy content of the .env.example file to the .env file
cp ~/development_scripts/.env.example ~/development_scripts/.env

# prompt used for personal git username and adjust the variable in the .env file
echo "Enter your personal git username:"
read GITHUB_PERSONAL_USERNAME
sed -i '' "s/GITHUB_PERSONAL_USERNAME=.*/GITHUB_PERSONAL_USERNAME=${GITHUB_PERSONAL_USERNAME}/" ~/development_scripts/.env


# prompt used for personal git email and adjust the variable in the .env file
echo "Enter your personal git email:"
read GITHUB_PERSONAL_EMAIL
sed -i '' "s/GITHUB_PERSONAL_EMAIL=.*/GITHUB_PERSONAL_EMAIL=${GITHUB_PERSONAL_EMAIL}/" ~/development_scripts/.env

# prompt used for work git username and adjust the variable in the .env file
echo "Enter your work git username:"
read GITHUB_WORK_USERNAME
sed -i '' "s/GITHUB_WORK_USERNAME=.*/GITHUB_WORK_USERNAME=${GITHUB_WORK_USERNAME}/" ~/development_scripts/.env

# prompt used for work git email and adjust the variable in the .env file
echo "Enter your work git email:"
read GITHUB_WORK_EMAIL
sed -i '' "s/GITHUB_WORK_EMAIL=.*/GITHUB_WORK_EMAIL=${GITHUB_WORK_EMAIL}/" ~/development_scripts/.env
