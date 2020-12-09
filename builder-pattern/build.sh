#!/bin/sh

echo Building ren1007/single:build
docker build -t ren1007/single:build . -f Dockerfile.build

docker container create --name extract ren1007/single:build
docker container cp extract:/go/src/github.com/alexellis/href-counter/app ./app

docker container rm -f extract

echo Building ren1007/single:latest
docker build --no-cache -t ren1007/single:latest .

rm ./app
