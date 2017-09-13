#!/bin/bash

set -e

DOCKER_IMAGE="imarcagency/php-apache"

VERSION_PATTERN="^([0-9]+)\.([0-9]+)\.([0-9]+)"

if [[ $1 =~ $VERSION_PATTERN ]]
then
	MAJOR=${BASH_REMATCH[1]}
	MINOR=${BASH_REMATCH[2]}
	PATCH=${BASH_REMATCH[3]}

	git tag -f "$MAJOR.$MINOR.$PATCH"
	git tag -f "$MAJOR.$MINOR"
	git tag -f "$MAJOR"

	docker build -t "$DOCKER_IMAGE:latest" .

	#docker build -t "$DOCKER_IMAGE:rc" .

	docker tag "$DOCKER_IMAGE:latest" "$DOCKER_IMAGE:$MAJOR.$MINOR.$PATCH"
	docker tag "$DOCKER_IMAGE:latest" "$DOCKER_IMAGE:$MAJOR.$MINOR"
	docker tag "$DOCKER_IMAGE:latest" "$DOCKER_IMAGE:$MAJOR"

	# docker push $DOCKER_IMAGE
fi

