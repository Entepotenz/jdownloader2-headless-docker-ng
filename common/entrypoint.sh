#!/usr/bin/env bash

# set -o nounset
set -o errexit
set -o pipefail
set -o xtrace

# Set defaults for uid and gid to not be root
if [ -z "$GID" ]; then GID=100;  fi
if [ -z "$UID" ]; then UID=1000; fi

GROUP=jdownloader

if [ "$GID" -ne "0" ]; then
    if [ "$(getent group $GROUP)" ]; then
        echo "group exists -> skipping creation; GROUP:=$GROUP"
    else
        echo "group does not exist -> creating group"
        groupadd --non-unique --gid "$GID" "$GROUP"
    fi
    getent group "$GROUP"
else
	GROUP=root
fi

if [ "$UID" -ne "0" ]; then
    USER=jdownloader
    if getent passwd "$USER" > /dev/null 2>&1; then
        echo "user already exists -> skipping creation; USER:=$USER"
    else
        echo "user does not exist -> creating user"
        # Create user without home (-M) and remove login shell
        useradd -M --shell /bin/false --gid "$GID" --uid "$UID" "$USER"
    fi
    getent passwd "$USER"
else
    USER=root
    usermod --append --gid "$GID" --groups "$GROUP" "$USER"
fi

# Set MyJDownloader credentials
CONFIG_FILE="/opt/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"
if [ -n "$EMAIL" ] ; then
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
