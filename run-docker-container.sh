#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
if [ "${TRACE-0}" -eq 1 ]; then set -o xtrace; fi

PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"

EMAIL="EMAIL"
PASSWORD="SECRET"

# docker run --rm --pull=always \
#     -e EMAIL="${EMAIL}" -e PASSWORD="${PASSWORD}" --platform linux/amd64 \
#     "ghcr.io/${PROJECT_NAME}:latest"

docker run --rm --pull=always \
    -e EMAIL="$EMAIL" -e PASSWORD="$PASSWORD" \
    -v /config/jd2:/app/cfg \
    -v "$HOME/Downloads":/data \
    "ghcr.io/$PROJECT_NAME:latest"
