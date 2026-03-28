# Coding Agent Instructions

## Scope
This repository builds a custom Jenkins controller image with extra tooling for CI/CD workflows.

## Structure Rules
- Keep responsibilities separated by file:
  - `Dockerfile`: base image, pinned tool/runtime versions, package and binary installation
  - `jenkins.sh`: container entrypoint and Jenkins JVM startup behavior
  - `jenkins-support`: shared shell helpers (copy/install/retry/version helpers)
  - `install-plugins.sh`: plugin download + dependency resolution logic
- Do not mix runtime behavior changes into `Dockerfile` when they belong in `jenkins.sh` or helper scripts.

## Version Update Workflow
When updating image/tool versions, change all related items in one patch:
1. Base JDK image tag in `Dockerfile`.
2. Jenkins WAR pins:
   - `JENKINS_VERSION`
   - `JENKINS_SHA` from `${JENKINS_URL}.sha256`
3. Tool pins (`HELM_VERSION`, `TERRAFORM_VERSION`, `TINI_VERSION`) and any matching download URLs.
4. Keep checksum/signature verification in place for downloaded artifacts.

## Binary Install Standards
- Prefer pinned versions over implicit `latest`.
- Verify downloaded binaries with checksum or signature.
- Keep installs non-interactive and suitable for Docker build context.

## Documentation
- Update `README.md` whenever behavior, defaults, or required configuration changes.
