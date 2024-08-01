export DOCKER_IMAGE_NAME="m3c5s-tools-test"
export DOCKER_IMAGE_VERSION_NUMBER=$(node -p "require('../package.json').version")

if [ -z "$DOCKER_IMAGE_VERSION_NUMBER" ]; then
    echo "Error: DOCKER_IMAGE_VERSION_NUMBER environment variable is not set." >&2
    exit 1
fi

COMMAND="docker run --rm \"$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION_NUMBER\""

echo "$COMMAND\n"
eval "$COMMAND"
