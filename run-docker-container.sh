#!/bin/bash
set -e

PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"

EMAIL="EMAIL"
PASSWORD="SECRET"

# docker run --rm --name jd2 \
#     -e EMAIL="${EMAIL}" -e PASSWORD="${PASSWORD}" \
#     "${PROJECT_NAME}:latest"

docker run --rm --name jd2 \
    -e EMAIL="${EMAIL}" -e PASSWORD="${PASSWORD}" \
    -v /config/jd2:/opt/JDownloader/cfg \
    -v "${HOME}/Downloads":/opt/JDownloader/Downloads \
    "${PROJECT_NAME}:latest"