# SLAP

A stand alone Slip App.

To build a Slip app, branch this repo and update the "load.go" file to
import the packages desired. Add Lisp code to the lisp
directory. Update the go.mod file to require the modules to be
included. Finally call make and the app should be ready as
"slap". Rename to what ever the app should be or update the Makefile
to write the correct named app directly.

## Developing against local Slip checkouts

`go.mod` pins released versions of slip and its plugins. To build against
local checkouts instead, use a Go workspace rather than `replace`
directives. It is ignored by git, so the repo keeps building from the
released modules.

With the checkouts as siblings of this repo:

    go work init . ../slip ../slip-fhir ../slip-ggql ../slip-jet ../slip-message ../slip-mongo

That writes a `go.work` like this; list only the modules you want to
override:

    go 1.27

    use (
        .
        ../slip
        ../slip-fhir
        ../slip-ggql
        ../slip-jet
        ../slip-message
        ../slip-mongo
    )

`go build`, `go test` and `make` then use those directories. To confirm:

    go list -m -f '{{.Version}} {{.Dir}}' github.com/ohler55/slip

An empty version and a local path means the workspace is in effect. To
build from the released modules, as CI and the Docker image do:

    GOWORK=off go build ./...
