#!/bin/bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

function set_local_node_version() {
  local node_version
  node_version=$(cat .nvmrc)
  nvm install "$node_version"
  nvm use
}

echo "${GREEN}--- nvm scripts loaded${NC}"
echo "         available commands: set_local_node_version"

if [ -f .nvmrc ]; then
  set_local_node_version
else
  echo "${RED}--- no .nvmrc file found${NC}"
  echo "${GREEN}--- current node version:${BLUE} $(node -v)${NC}"
fi
