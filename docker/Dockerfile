# syntax=docker/dockerfile:1

# Builds an Alpine image that runs slip scripts: `slapr <script.lisp> [args]`.
# The image holds no scripts; mount them or build FROM this image and COPY them.
#
# Stages:
#   deps    -> modules fetched from go.mod/go.sum
#   build   -> static, stripped, version-stamped slapr for TARGETPLATFORM
#   runtime -> alpine + ca-certificates + tzdata + slapr, non-root

# Cross-compiles from BUILDPLATFORM. slip is cgo-free, so the binary is static.
FROM --platform=$BUILDPLATFORM golang:1.27-alpine AS deps
WORKDIR /src
ENV GOWORK=off
COPY --from=project go.mod go.sum ./
RUN go mod download

# Only slapr/ is compiled. VERSION lands in *slapper-version*.
FROM deps AS build
ARG TARGETOS TARGETARCH VERSION=dev
ENV CGO_ENABLED=0
COPY --from=project slapr/ ./slapr/
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build \
        -trimpath -ldflags "-s -w -X main.version=${VERSION}" \
        -o /out/slapr ./slapr

# Alpine rather than scratch so a shell and #!/usr/bin/env slapr scripts work.
# ca-certificates for TLS, tzdata so TZ resolves. Fixed uid/gid 10001.
FROM alpine:3.24 AS runtime
RUN apk add --no-cache ca-certificates tzdata \
    && addgroup -g 10001 slapr \
    && adduser -u 10001 -G slapr -h /home/slapr -D slapr
COPY --from=build /out/slapr /usr/local/bin/slapr

ENV HOME=/home/slapr
WORKDIR /app
USER slapr:slapr

# No ENTRYPOINT: the container command names the script. A bare run prints usage.
CMD ["/bin/sh", "-c", "echo 'slapr: run a slip script, e.g.'; echo '  slapr /app/scripts/job.lisp [args...]'; echo; echo 'Mount scripts into the container, or build FROM this image and COPY them.'; printf '(princ *slapper-version*)' > /tmp/v.lisp && printf 'slapr version: ' && slapr /tmp/v.lisp && echo"]
