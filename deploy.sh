#!/bin/bash

# Default to staging
ENV="staging"
IMAGE="ghcr.io/narasim-teja/fastlane:staging"
COMPOSE_FILE="compose.staging.yml"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --staging)
      ENV="staging"
      IMAGE="ghcr.io/narasim-teja/fastlane:staging"
      COMPOSE_FILE="compose.staging.yml"
      shift
      ;;
    --prod|--production)
      ENV="production"
      IMAGE="ghcr.io/narasim-teja/fastlane:latest"
      COMPOSE_FILE="compose.prod.yml"
      shift
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

echo
echo ">>> Pulling the ${ENV^} Docker image..."
docker pull $IMAGE

echo
echo ">>> Booting up the ${ENV^} server using ${COMPOSE_FILE}..."
docker compose -f $COMPOSE_FILE up -d
