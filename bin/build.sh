#!/usr/bin/env sh

PACKAGE_NAME=$(node -p "require('./package.json').name")

echo "Building $PACKAGE_NAME Docker image"

PACKAGE_VERSION_NUMBER=$(node -p "require('./package.json').version")
BUILD_NUMBER=$(TZ=America/Los_Angeles date "+%Y-%m-%d--%H-%M-%S")
SEMANTIC_VERSION_NUMBER="${PACKAGE_VERSION_NUMBER}+${BUILD_NUMBER}"
DOCKER_IMAGE_TAG=$(echo "$SEMANTIC_VERSION_NUMBER" | sed 's/+/--/g')

echo "  Semantic version number: $SEMANTIC_VERSION_NUMBER"
echo "         Docker image tag: $DOCKER_IMAGE_TAG\n\n"

COMMAND="\
    docker build \
    --platform linux/amd64 \
    --pull \
    --tag $PACKAGE_NAME:$PACKAGE_VERSION_NUMBER \
    --tag $PACKAGE_NAME:$DOCKER_IMAGE_TAG \
    --tag $PACKAGE_NAME:latest \
    . \
"

echo "$COMMAND\n"

eval "$COMMAND"

if [ $? -ne 0 ]; then
    echo "Error: docker build failed."
    exit 1
fi
