#!/bin/sh
set -e

# Verify that exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi

GITHUB_REPO=$1
DOCKER_IMAGE=$2

# Create a temporary directory to clone the repository into
TEMP_DIR=$(mktemp -d)

echo "=> Cloning https://github.com/${GITHUB_REPO}..."
git clone "https://github.com/${GITHUB_REPO}.git" "$TEMP_DIR"

echo "=> Building Docker image ${DOCKER_IMAGE}..."
docker build -t "$DOCKER_IMAGE" "$TEMP_DIR"

echo "=> Pushing ${DOCKER_IMAGE} to Docker Hub..."
docker push "$DOCKER_IMAGE"

echo "=> Cleaning up..."
rm -rf "$TEMP_DIR"

echo "=> Success! Image pushed to Docker Hub successfully !"
