# jdownloader2-headless-docker-ng

[![Create and publish a Docker image](https://github.com/Entepotenz/jdownloader2-headless-docker-ng/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Entepotenz/jdownloader2-headless-docker-ng/actions/workflows/docker-image.yml)
[![Lint Code Base](https://github.com/Entepotenz/jdownloader2-headless-docker-ng/actions/workflows/linter.yml/badge.svg)](https://github.com/Entepotenz/jdownloader2-headless-docker-ng/actions/workflows/linter.yml)

This is a docker container which creates a headless instance of JDownloader.
You can control this JDownloader instance by configuring your [MyJDownloader](https://my.jdownloader.org/) account.
This container checks once a week if a new baseimage is available and builds/pushes a new image.

This code is based on this repository: [https://github.com/PlusMinus0/headless-jd2-docker](https://github.com/PlusMinus0/headless-jd2-docker)

## Supported tags
* `latest`
* `latest-ffmpeg`


## Running the container

0. Become root if your user is not part of the docker group:

    ```shell
    sudo su
    ```
1. Create a folder on your host for the configuration files (eg. `sudo mkdir /config/jd2`)
2. Run the container:

    ```shell
    docker run -d --name jd2 \
        -e EMAIL=my@mail.com -e PASSWORD=my_secret_password
        -v /config/jd2:/opt/JDownloader/cfg \
        -v /home/user/Downloads:/opt/JDownloader/Downloads \
        entepotenz/jdownloader2-headless-docker-ng:latest
    ```

If you don't want to specify your credentials on the command-line, remove them from the command above (`-e EMAIL=... -e PASSWORD=...`)
and add them manually to the file `<config-dir>/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json` as in

```json
{ "email" : "my@mail.com", "password" : "my_secret_password" }
```

## Optional environment variables
Environment Variable | Description
---------------------|------------
EMAIL                | The MyJDownloader account email. Is written automatically to config-file, if set.
PASSWORD             | The MyJDownloader account password. Is written automatically to config-file, if set.
UID                  | Specifies the UID the daemon should run as. All created files will be owned by this UID. Defaults to 1000.
GID                  | Specifies the GID for all created files. This only works in combination with the UID. Defaults to 100 for users.

Not setting `UID` / `GID` will default to `1000`:`100`.
