#!/bin/bash

# Edited by: Paulo José de Oliveira Salgado
# Email: paulo@technosoftware.com.br
#
# Depending on your docker configuration, root might be required. If your nrpe user has rights
# to talk to the docker daemon, then root is not required. This is why root privileges are not
# checked.
#
# The script checks if a container is running.
#   OK - running
#   WARNING - restarting
#   CRITICAL - stopped
#   UNKNOWN - does not exist

function check_docker_container() {
  CONTAINER=$1

  if [ "${CONTAINER}" == "" ]; then
    echo "${RED}--- 3 - UNKNOWN${NC}"
    echo "${RED}--- Container ID or Friendly Name Required${NC}"
    echo "${RED}--- Usage: check_docker_container $0 <container_id_or_friendly_name>${NC}"
    exit 3
  fi

  if [ "$(which docker)" == "" ]; then
    echo "${RED}--- 3 - UNKNOWN${NC}"
    echo "${RED}--- Missing docker binary${NC}"
    exit 3
  fi

  docker info >/dev/null 2>&1
  # shellcheck disable=SC2181
  if [ $? -ne 0 ]; then
    echo "${RED}--- 3 - UNKNOWN${NC}"
    echo "${RED}--- Unable to talk to the docker daemon${NC}"
    exit 3
  fi

  RUNNING=$(docker inspect --format="{{.State.Running}}" "$CONTAINER" 2>/dev/null)

  if [ $? -eq 1 ]; then
    echo "${RED}--- 3 - UNKNOWN${NC}"
    echo "${RED}--- $CONTAINER does not exist.${NC}"
    exit 3
  fi

  if [ "$RUNNING" == "false" ]; then
    echo "${GREEN}---  2 - CRITICAL${NC}"
    echo "${GREEN}---  $CONTAINER is not running.${NC}"
    exit 2
  fi

  RESTARTING=$(docker inspect --format="{{.State.Restarting}}" "$CONTAINER")

  if [ "$RESTARTING" == "true" ]; then
    echo "${YELLOW}--- 1 - WARNING${NC}"
    echo "${YELLOW}--- $CONTAINER state is restarting.${NC}"
    exit 1
  fi

  STARTED=$(docker inspect --format="{{.State.StartedAt}}" "$CONTAINER")
  NETWORK=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "$CONTAINER")

  echo "${GREEN}--- 0 - RUNNING OK${NC}"
  echo "${GREEN}--- $CONTAINER is running.${NC}"
  echo "${GREEN}--- -> IP: $NETWORK${NC}"
  echo "${GREEN}--- Started at: $STARTED${NC}"
}
