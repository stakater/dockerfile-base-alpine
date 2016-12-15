#!/bin/bash
_alpine_version=$1
_alpine_tag=$2
_release_build=false

if [ -z "${_alpine_version}" ]; then
	source ALPINE_VERSION
	_alpine_version=$ALPINE_VERSION
	_alpine_tag=$ALPINE_VERSION
	_release_build=true
fi

echo "ALPINE_VERSION: ${_alpine_version}"
echo "DOCKER TAG: ${_alpine_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --tag "stakater/alpine:${_alpine_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker build --tag "stakater/alpine:latest"  --no-cache=true .
fi