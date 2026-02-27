# NodeODM Fork: GPU Build And Usage Guide

This fork keeps a focused setup for building and running the GPU image reliably.

For full upstream docs, API details, and original project notes, see:
https://github.com/OpenDroneMap/NodeODM

## What This Fork Changes

- `Dockerfile.gpu` now copies project files before running `install_deps.sh`.
- `Dockerfile.gpu` normalizes line endings for shell scripts during build.
- `install_deps.sh` now installs `ca-certificates`, pins `nodemon@2.0.22`, and retries `npm install --production`.
- `.gitattributes` enforces LF line endings for `*.sh`, `Dockerfile`, and `Dockerfile.*`.

## Prerequisites

- Docker Desktop (Linux container mode).
- NVIDIA driver and Docker GPU support.
- A GPU runtime check should pass:

```bash
docker run --rm --gpus all nvidia/cuda:10.0-base nvidia-smi
```

## Build GPU Image

```bash
git pull
docker build --no-cache -f Dockerfile.gpu -t nodeodm:gpu .
```

## Run GPU Container

```bash
docker run -p 3000:3000 --gpus all nodeodm:gpu
```

## Run With Data Volume Mapping

Linux path example:

```bash
docker run -p 3000:3000 --gpus all -v /path/to/data:/var/www/data nodeodm:gpu
```

Windows path example:

```bash
docker run -p 3000:3000 --gpus all -v D:\odm-data:/var/www/data nodeodm:gpu
```

## Rename Local Image Tag

```bash
docker tag nodeodm:gpu my-nodeodm:gpu
docker rmi nodeodm:gpu
```

## Recommended Workflow

- Use one environment consistently for Git and Docker commands.
- If Windows path mapping is required, do `pull/build/run` consistently on Windows.
- Avoid mixing Windows Git and WSL Git on the same working tree.

## Troubleshooting

- Error: `install_deps.sh: No such file or directory`
Fix: pull latest changes; this is fixed by Dockerfile build order.

- Error: `$'\r': command not found`
Fix: pull latest changes; line ending normalization is included in build and `.gitattributes`.

- Error: `npm ERR! cb() never called!`
Fix: pull latest changes; dependency install retry logic is now included in `install_deps.sh`.
