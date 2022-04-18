#!/bin/bash
set -e
# set -x

TODAY=$(date +%Y%m%d)
PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"

docker build --pull --platform linux/amd64 \
    -t "${PROJECT_NAME}:${TODAY}" \
    -t "${PROJECT_NAME}:latest" \
    -t "ghcr.io/${PROJECT_NAME}:latest" . \
    --file="Dockerfile"

docker image push "ghcr.io/${PROJECT_NAME}:latest"


docker build --pull --platform linux/amd64 \
    -t "${PROJECT_NAME}:${TODAY}" \
    -t "${PROJECT_NAME}:latest-ffmpeg" \
    -t "ghcr.io/${PROJECT_NAME}:latest-ffmpeg" . \
    --file="Dockerfile-ffmpeg"

docker image push "ghcr.io/${PROJECT_NAME}:latest-ffmpeg"
