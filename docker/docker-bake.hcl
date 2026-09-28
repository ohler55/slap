# Build config for the slapr image. The `project` context is the repo root.
# Locally, `make -C docker build` drives it with LOCAL_ONLY=true; publishing
# happens in CI through docker/bake-action.

variable "TAG"      { default = "testing" }
variable "REGISTRY" { default = "ghcr.io/ohler55" }
variable "VERSION"  { default = "dev" }
variable "SOURCE"   { default = "https://github.com/ohler55/slap" }

variable "PLATFORMS" { default = ["linux/amd64", "linux/arm64"] }

# Architecture of a local (LOCAL_ONLY) build; the Makefile sets it from the host.
variable "LOCAL_ARCH" { default = "arm64" }
variable "LOCAL_ONLY" { default = false }

function "image_name" {
  params = [app, tag]
  result = REGISTRY != "" ? "${REGISTRY}/${app}:${tag}" : "${app}:${tag}"
}

# Local: load the native arch into docker. Otherwise: multi-arch, pushed.
function "get_output" {
  params = []
  result = LOCAL_ONLY ? ["type=docker"] : ["type=registry"]
}
function "get_platforms" {
  params = []
  result = LOCAL_ONLY ? ["linux/${LOCAL_ARCH}"] : PLATFORMS
}

group "default" { targets = ["slapr"] }

target "slapr" {
  dockerfile = "./docker/Dockerfile"
  target     = "runtime"
  contexts   = { project = "." }
  platforms  = get_platforms()
  output     = get_output()
  args       = { VERSION = VERSION }
  tags = [
    image_name("slapr", TAG),
    image_name("slapr", "latest"),
  ]
  labels = {
    "org.opencontainers.image.title"       = "slapr"
    "org.opencontainers.image.description" = "slapr: runs slip scripts on Alpine"
    "org.opencontainers.image.source"      = SOURCE
    "org.opencontainers.image.version"     = VERSION
  }
}
