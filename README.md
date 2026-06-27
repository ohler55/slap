# SLAP

A stand alone Slip App.

To build a Slip app, branch this repo and update the "load.go" file to
import the packages desired. Add Lisp code to the lisp
directory. Update the go.mod file with replaces to refer to the repos
to be included. Finally call make and the app should be ready as
"slap". Rename to what ever the app should be or update the Makefile
to write the correct named app directly.
