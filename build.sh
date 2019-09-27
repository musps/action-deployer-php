#!/bin/sh

HUB=docker.pkg.github.com
PKG=action-deployer-php
VERSION=latest

docker login $HUB --username $BUILD_USERNAME --password $BUILD_TOKEN
docker tag $PKG $HUB/$BUILD_USERNAME/$PKG/$PKG:$VERSION
docker push $HUB/$BUILD_USERNAME/$PKG/$PKG:$VERSION
