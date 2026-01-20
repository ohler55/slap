# SLAP

A stand alone SLIP App.

To build a SLIP app, branch this repo and update the "load.go" file to
import the packages desired. Add LISP code to the lisp
directory. Update the go.mod file with replaces to refer to the repos
to be included. Finally call make and the app should be ready as
"slap". Rename to what ever the app should be or update the Makefile
to write the correct named app directly.
