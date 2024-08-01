export DOCKER_IMAGE_NAME="m3c5s-tools-test"
export DOCKER_IMAGE_VERSION_NUMBER=$(node -p "require('../package.json').version")

npx m3c5s-build
