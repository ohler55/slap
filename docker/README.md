# Docker

Builds the `slapr` container image: `Dockerfile`, a bake file,
and a `Makefile` for local builds.

| image | contents |
|---|---|
| `ghcr.io/ohler55/slapr` | Alpine + `ca-certificates` + `tzdata` + `slapr` at `/usr/local/bin/slapr` |

`slapr` runs one slip script and exits: `slapr <script.lisp> [args...]`. The
plugins imported by `slapr/main.go` are compiled in. The image holds no
scripts, so one image serves any script.

## Building

### In CI

`.github/workflows/ci.yml` builds for linux/amd64 and linux/arm64 and pushes
to GHCR when a `v*.*.*` tag is pushed or the workflow is run by hand. A tag
build is tagged with the tag name, a manual run with its branch name; both
also get `latest`. The registry is `ghcr.io/<repository owner>`. Pull
requests build linux/amd64 and run the smoke test without pushing.

    git tag v1.5.2 && git push origin v1.5.2


### Locally

    make -C docker                  # help
    make -C docker build            # native arch, as ghcr.io/ohler55/slapr:testing + :latest
    make -C docker smoke            # run the image and check the basics
    make -C docker print            # resolve the bake file without building
    make -C docker multiarch-check  # compile both arches, push nothing

`make docker` at the root runs `make -C docker build`. Force an architecture
with `LOCAL_ARCH=amd64`. `multiarch-check` needs a docker-container builder:

    BUILDX_BUILDER=<name> make -C docker multiarch-check

There is no push target. Publishing is done by CI from a tag so every
published image is traceable to a workflow run.

## Running a script

The image has no ENTRYPOINT. A bare `docker run` prints usage and the
version. Otherwise name the script:

    docker run --rm -v "$PWD/scripts:/app/scripts:ro" ghcr.io/ohler55/slapr:latest \
        slapr /app/scripts/job.lisp arg1 arg2

`*slapper-version*` holds the version stamped at build time. A script that
raises, or a path that does not exist, exits with status 1.

The container runs as user `slapr` (uid/gid 10001, `HOME=/home/slapr`) in
`/app`, which is root-owned and read-only. Write to a mounted volume or
`/tmp`.

To bake scripts in, build a derived image:

    FROM ghcr.io/ohler55/slapr:v1.5.2
    COPY --chmod=0755 scripts/ /app/scripts/

Executable scripts with `#!/usr/bin/env slapr` can be run by path directly.
`*load-pathname*` is the script's absolute path, so `(load ...)` relative to
the script's directory works.
