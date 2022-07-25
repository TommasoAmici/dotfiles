#!/bin/sh

# Options
DOMAIN=#XXX
ADMIN_TOKEN=#XXX
DATA_DIR=#XXX
PORT=8100

# Pull image
IMAGE=vaultwarden/server:1.25.1-alpine
docker pull $IMAGE

# Stop and restart container
CONTAINER=vaultwarden

docker stop $CONTAINER
docker rm $CONTAINER

docker run --restart=always -d --name "$CONTAINER" -p "127.0.0.1:$PORT:80" \
  -v "$DATA_DIR:/data/" \
  --log-driver journald --log-opt tag=$CONTAINER \
  -e "ADMIN_TOKEN=$ADMIN_TOKEN" \
  -e "DOMAIN=$DOMAIN" \
  $IMAGE
