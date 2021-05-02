# chiadog-docker

## Overview

This repo provides a basic Docker image that can be used to run the [Chiadog](https://github.com/martomi/chiadog) monitoring daemon for [Chia](https://www.chia.net).

## Startup
It is recommended to store the Chiadog `config.yaml` in persistent storage outside of the Docker container. Chiadog will also need access to the `chia-blockchain` logs at `INFO` level.

In this example the optional flags mount a persistent directory for Chiadog configuration at `/root/.chiadog` and it provides read-only access to Chia logs in the normal location.  Your Chia keys are not visable to this container. 
```
docker pull artjacobson/chiadog-docker:latest
docker run --name <container-name> -d artjacobson/chiadog-docker:latest
(optional -v /path/to/config_dir:/root/.chiadog -v path-to-chia-logs:/root/.chia/mainnet/log:ro)
```

If Chia is also running in a container, sharing a volume between the `chia-docker` and `chiadog-docker` can be done instead of sharing an absolute path on the host machine.
```
docker volume create chia-home
docker run --name <container-name> -d artjacobson/chiadog-docker:latest -v chia-home:/root/.chia:ro
docker run --name <container-name> -d ghcr.io/chia-network/chia:latest -v chia-home:/root/.chia <additional args for keys and plots>
```

## Configuration

The path to `config.yaml` can be passed via the `config_dir` environment variable.  Ensure that your `config.yaml` is on a persistent volume, and the `file_log_consumer` has been configured with a correct absolute path within the container. 

The timezone can also be set via the `TZ` environment variable.  A list of available timezones can be found [here](http://manpages.ubuntu.com/manpages/focal/man3/DateTime::TimeZone::Catalog.3pm.html).
```
-e config_dir="/root/.chiadog/config.yaml" -e TZ="America/Chicago"
```

## Updating

Provided that the configuration is on a persistent volume, updating can be done by deleting the container, fetching the latest image, and relaunching it with the appropriate arguments.
```docker stop <container-name>
docker rm <container-name>
docker pull artjacobson/chiadog-docker:latest
docker run --name <container-name> -d artjacobson/chiadog-docker:latest -v /path/to/config_dir:/root/.chiadog -v path-to-chia-logs:/root/.chia/mainnet/log:ro -e config_dir="/root/.chiadog/config.yaml"
```
