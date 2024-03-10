#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
if [ "${TRACE-0}" -eq 1 ]; then set -o xtrace; fi

PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"
OUTPUT_FILE_NAME_PREFIX="jdownloader2-headless-docker-ng"

docker save "$PROJECT_NAME:latest" | gzip >"$OUTPUT_FILE_NAME_PREFIX.tar.gz"

docker save "$PROJECT_NAME:latest-ffmpeg" | gzip >"$OUTPUT_FILE_NAME_PREFIX-ffmpeg.tar.gz"
