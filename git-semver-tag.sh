#!/bin/bash

REGEXP="^([0-9]+)\.([0-9]+)\.([0-9]+)"

if [[ $1 =~ $REGEXP ]]
then
	MAJOR=${BASH_REMATCH[1]}
	MINOR=${BASH_REMATCH[2]}
	PATCH=${BASH_REMATCH[3]}

	git tag "$MAJOR.$MINOR.$PATCH"
	git tag -f "$MAJOR.$MINOR"
	git tag -f "$MAJOR"
fi
