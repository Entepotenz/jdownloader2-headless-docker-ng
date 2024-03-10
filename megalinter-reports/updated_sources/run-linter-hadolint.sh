#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

pushd "$PWD"

cd "${SCRIPT_DIR}/.github/linters"

find "${SCRIPT_DIR}" -iname "Dockerfile" -exec hadolint {} \;

popd
