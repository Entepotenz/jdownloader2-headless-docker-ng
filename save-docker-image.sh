#!/bin/bash
set -e
set -x

PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"
OUTPUT_FILE_NAME_PREFIX="jdownloader2-headless-docker-ng"

docker save "${PROJECT_NAME}:latest" | gzip > "${OUTPUT_FILE_NAME_PREFIX}.tar.gz"

docker save "${PROJECT_NAME}:latest-ffmpeg" | gzip > "${OUTPUT_FILE_NAME_PREFIX}-ffmpeg.tar.gz"