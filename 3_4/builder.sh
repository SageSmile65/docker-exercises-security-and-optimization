#!/bin/sh
set -e

# Verify that exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: <github-repo> <docker-image>"
  exit 1
fi

GITHUB_REPO=$1
DOCKER_IMAGE=$2

# Log in to Docker Hub using the environment variables
if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
  echo "=> Logging into Docker Hub as ${DOCKER_USER}..."
  echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
else
  echo "=> Error: DOCKER_USER and DOCKER_PWD environment variables are required."
  exit 1
fi

TEMP_DIR=$(mktemp -d)

echo "=> Cloning https://github.com/${GITHUB_REPO}..."
git clone "https://github.com/${GITHUB_REPO}.git" "$TEMP_DIR"

echo "=> Building Docker image ${DOCKER_IMAGE}..."
docker build -t "$DOCKER_IMAGE" "$TEMP_DIR"

echo "=> Pushing ${DOCKER_IMAGE} to Docker Hub..."
docker push "$DOCKER_IMAGE"

echo "=> Cleaning up..."
rm -rf "$TEMP_DIR"

echo "=> Success! Image pushed to Docker Hub."
