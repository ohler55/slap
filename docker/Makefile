# Run from the repo root: `make -C docker <target>`.

.DEFAULT_GOAL := help

BAKE = docker buildx bake --file ./docker/docker-bake.hcl

# Mirrors the REGISTRY default in docker-bake.hcl. Override with REGISTRY=...
REGISTRY ?= ghcr.io/ohler55
IMAGE     = $(REGISTRY)/slapr

# Stamped into *slapper-version*.
VERSION = $(shell git describe --tags --always --dirty)

# Host architecture, so local builds are native. Override with LOCAL_ARCH=amd64.
UNAME_M := $(shell uname -m)
LOCAL_ARCH ?= $(if $(filter arm64 aarch64,$(UNAME_M)),arm64,amd64)

LOCAL_ENV = LOCAL_ONLY=true LOCAL_ARCH=$(LOCAL_ARCH) VERSION=$(VERSION) REGISTRY=$(REGISTRY)

help:
	@echo "slapr image: run from the repo root as: make -C docker <target>"
	@echo "VERSION: $(VERSION)"
	@echo ""
	@echo "Local (linux/$(LOCAL_ARCH), loaded into docker as :testing + :latest):"
	@echo "  build            build $(IMAGE)"
	@echo "  smoke            run the image: version, user, certs, exit status on failure"
	@echo "  print            resolve the bake file without building"
	@echo "  multiarch-check  compile for amd64 and arm64"
	@echo ""
	@echo "Publishing is CI-only (.github/workflows/ci.yml)."

build:
	cd .. && $(LOCAL_ENV) $(BAKE)

print:
	cd .. && $(LOCAL_ENV) $(BAKE) --print

smoke:
	docker run --rm $(IMAGE):testing
	docker run --rm $(IMAGE):testing sh -c 'printf "(print *slapper-version*)" > /tmp/v.lisp && slapr /tmp/v.lisp'
	docker run --rm $(IMAGE):testing sh -c 'id && command -v slapr && test -s /etc/ssl/certs/ca-certificates.crt && echo "CA bundle present" && test -f /usr/share/zoneinfo/UTC && echo "tzdata present"'
	docker run --rm $(IMAGE):testing sh -c 'printf "(car 1)" > /tmp/f.lisp; slapr /tmp/f.lisp; s=$$?; test $$s -ne 0 && echo "failing script exit status $$s: OK"'
	docker run --rm $(IMAGE):testing sh -c 'slapr /no/such.lisp; s=$$?; test $$s -ne 0 && echo "missing script exit status $$s: OK"'
	docker image ls $(IMAGE)

# Needs a docker-container buildx builder. The result stays in the builder cache.
multiarch-check:
	cd .. && VERSION=$(VERSION) REGISTRY=$(REGISTRY) LOCAL_ONLY=false $(BAKE) \
	  --set 'slapr.output=type=cacheonly'

.PHONY: help build print smoke multiarch-check
