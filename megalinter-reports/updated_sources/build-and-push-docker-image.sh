#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
if [ "${TRACE-0}" -eq 1 ]; then set -o xtrace; fi

TODAY=$(date +%Y%m%d)
PROJECT_NAME="entepotenz/jdownloader2-headless-docker-ng"
PLATFORM_NAME="linux/amd64"

docker build --pull --platform "${PLATFORM_NAME}" \
	-t "$PROJECT_NAME:$TODAY" \
	-t "$PROJECT_NAME:latest" \
	-t "ghcr.io/$PROJECT_NAME:latest" . \
	--file="Dockerfile"

docker image push "ghcr.io/$PROJECT_NAME:latest"

docker build --pull --platform "$PLATFORM_NAME" \
	-t "$PROJECT_NAME:$TODAY-ffmpeg" \
	-t "$PROJECT_NAME:latest-ffmpeg" \
	-t "ghcr.io/$PROJECT_NAME:latest-ffmpeg" . \
	--file="Dockerfile-ffmpeg"

docker image push "ghcr.io/$PROJECT_NAME:latest-ffmpeg"
