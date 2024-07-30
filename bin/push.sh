#!/usr/bin/env sh

get_package_json_property() {
    local PROPERTY="$1"
    local VALUE=$(node -e "try { console.log(require('./package.json')['$PROPERTY'] || ''); } catch (e) { console.log(''); }")
    if [ -z "$VALUE" ]; then
        echo "Error: $PROPERTY is not defined in package.json" >&2
        return 1
    fi
    echo "$VALUE"
    return 0
}

DOCKER_IMAGE_REPOSITORY_URI=$(get_package_json_property "docker-image-repository-uri")
if [ $? -ne 0 ]; then
    exit 1
fi

PACKAGE_NAME=$(get_package_json_property "name")
if [ $? -ne 0 ]; then
    exit 1
fi

PACKAGE_VERSION_NUMBER=$(get_package_json_property "version")
if [ $? -ne 0 ]; then
    exit 1
fi

echo "Pushing $PACKAGE_NAME to $DOCKER_IMAGE_REPOSITORY_URI"

execute_command() {
    local COMMAND="$1"
    echo "$COMMAND"
    eval "$COMMAND"
    if [ $? -ne 0 ]; then
        echo "Error: failed"
        exit 1
    fi
}

execute_command "docker tag $PACKAGE_NAME:$PACKAGE_VERSION_NUMBER $DOCKER_IMAGE_REPOSITORY_URI:$PACKAGE_VERSION_NUMBER"
execute_command "docker tag $PACKAGE_NAME:$PACKAGE_VERSION_NUMBER $DOCKER_IMAGE_REPOSITORY_URI:latest"
execute_command "docker push $DOCKER_IMAGE_REPOSITORY_URI:$PACKAGE_VERSION_NUMBER"
execute_command "docker push $DOCKER_IMAGE_REPOSITORY_URI:latest"
