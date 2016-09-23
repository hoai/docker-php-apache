#!/bin/bash

REGEXP="^([0-9]+)\.([0-9]+)\.([0-9]+)"

[[ $1 =~ $REGEXP ]]

MAJOR=${BASH_REMATCH[1]}
MINOR=${BASH_REMATCH[2]}
PATCH=${BASH_REMATCH[3]}

git tag "$MAJOR.$MINOR.$PATCH"
git tag "$MAJOR.$MINOR"
git tag "$MAJOR"
