export DOCKER_IMAGE_NAME="m3c5s-tools-test"
export DOCKER_IMAGE_VERSION_NUMBER=$(node -p "require('../package.json').version")
export DOCKER_IMAGE_REPOSITORY_URI="docker.io/mattcalkins/m3c5s-tools-test"

npx m3c5s-push
