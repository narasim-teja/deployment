#!/bin/bash

# Default to staging
ENV="staging"

# Parse command line arguments
if [[ $# -gt 0 ]]; then
  case $1 in
    --staging)
      ENV="staging"
      ;;
    --prod|--production)
      ENV="production"
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
  shift
fi

# Set image and compose file based on the environment
IMAGE="ghcr.io/narasim-teja/fastlane:${ENV}"
COMPOSE_FILE="compose.${ENV}.yml"

echo
echo ">>> Pulling the ${ENV^} Docker image..."
docker pull $IMAGE

echo
echo ">>> Booting up the ${ENV^} server using ${COMPOSE_FILE}..."
docker compose -f $COMPOSE_FILE up -d
