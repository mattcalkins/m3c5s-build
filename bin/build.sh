#!/usr/bin/env sh

set -e

if [ -z "$DOCKER_IMAGE_NAME" ]; then
    echo "Error: DOCKER_IMAGE_NAME environment variable is not set." >&2
    exit 1
fi

if [ -z "$DOCKER_IMAGE_VERSION_NUMBER" ]; then
    echo "Error: DOCKER_IMAGE_VERSION_NUMBER environment variable is not set." >&2
    exit 1
fi

echo "Building $DOCKER_IMAGE_NAME Docker image"

BUILD_NUMBER=$(TZ=America/Los_Angeles date "+%Y-%m-%d--%H-%M-%S")
SEMANTIC_VERSION_NUMBER="${DOCKER_IMAGE_VERSION_NUMBER}+${BUILD_NUMBER}"
DOCKER_IMAGE_TAG=$(echo "$SEMANTIC_VERSION_NUMBER" | sed 's/+/--/g')

echo "  Semantic version number: $SEMANTIC_VERSION_NUMBER"
echo "         Docker image tag: $DOCKER_IMAGE_TAG\n\n"

COMMAND="\
    docker build \
    --platform linux/amd64 \
    --pull \
    --tag \"$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION_NUMBER\" \
    --tag \"$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG\" \
    --tag \"$DOCKER_IMAGE_NAME:latest\" \
    . \
"

echo "$COMMAND\n"
eval "$COMMAND"
