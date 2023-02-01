#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
if [ "${TRACE-0}" -eq 1 ]; then set -o xtrace; fi

# Set defaults for uid and gid to not be root
if [ -z "${GID}" ]; then GID=100;  fi
if [ -z "${UID}" ]; then UID=1000; fi

if [ "$GID" -ne "0" ]; then
    GROUP=jdownloader
    # if group does not exist
    if [ ! "$(getent group $GROUP)" ]; then
        groupadd -g "$GID" "$GROUP"
    fi
else
	GROUP=root
fi

if [ "$UID" -ne "0" ]; then
    USER=jdownloader

    # Create user without home (-M) and remove login shell
    useradd -M -s /bin/false -g "$GID" -u "$UID" "$USER"
else
    USER=root
    usermod -ag "$GID"
fi

# Set MyJDownloader credentials
CONFIG_FILE="/opt/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"
if [ -n "${EMAIL}" ] ; then
    if [ ! -f "$CONFIG_FILE" ] || [ ! -s "$CONFIG_FILE" ] ; then
        echo '{}' > "$CONFIG_FILE"
    fi

    CFG=$(jq -r --arg EMAIL "$EMAIL" --arg PASSWORD "$PASSWORD" '.email = $EMAIL | .password = $PASSWORD' "$CONFIG_FILE")
    [ -n "$CFG" ] && echo "$CFG" > "$CONFIG_FILE"
fi

chown -R "$UID:$GID" /opt/JDownloader

su-exec "$UID:$GID" "$@"

# Keep container alive when jd2 restarts
while sleep 3600; do :; done
