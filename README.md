# chiadog-docker

## Basic Startup
```
docker run --name <container-name> -d artjacobson/chiadog-docker:latest
(optional -v /path/to/config_dir:/root/.chiadog)
```

## Configuration
The path to `config.yaml` can be passed via the `config_dir` environment variable
```
-e config_dir="/root/.chiadog/config.yaml"
```
