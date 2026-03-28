# docker-jenkins

Custom Jenkins controller image for CI/CD use cases, including bundled operational tooling and hardened artifact download checks.

## Purpose
- Provide a Jenkins controller image with a reproducible runtime.
- Bundle common platform tools used by pipelines:
  - `kubectl` (latest stable at build time)
  - `helm` (pinned)
  - `terraform` (pinned)
- Start Jenkins through custom entrypoint/support scripts while preserving standard container behavior.

## Repository Contents
- `Dockerfile`: image build definition and pinned version/config values.
- `jenkins.sh`: container startup and Jenkins process launch.
- `jenkins-support`: shared shell helper functions.
- `install-plugins.sh`: plugin install/dependency resolution helper.
- `init.groovy`: initial Jenkins controller setup hook.

## Build
```bash
docker build -t docker-jenkins:local .
```

## Run
```bash
docker run --rm -p 8080:8080 -p 50000:50000 docker-jenkins:local
```

Jenkins UI should be available at `http://localhost:8080`.

## Versioning Notes
- Jenkins WAR is pinned by version and SHA256.
- Helm and Terraform are pinned.
- `kubectl` is pulled from Kubernetes `stable.txt` at build time and checksum-verified.
- Base Java image is pinned to a specific major Temurin tag.
