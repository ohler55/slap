// Copyright (c) 2026, Peter Ohler, All rights reserved.

package main

import (
	"embed"
	"io"
	"io/fs"
	"path/filepath"
	"strings"

	// Pull in all functions.
	"github.com/ohler55/slip"
	_ "github.com/ohler55/slip-fhir/fhir"
	_ "github.com/ohler55/slip-ggql/slipggql"
	_ "github.com/ohler55/slip-jet/jet"
	_ "github.com/ohler55/slip-message/message"
	_ "github.com/ohler55/slip-mongo/slipmongo"
	_ "github.com/ohler55/slip/pkg"
	// _ "github.com/ohler55/slip-parquet/slipparquet"
)

//go:embed all:lisp
var lispFS embed.FS

func loadEmbed(scope *slip.Scope) (listProvs slip.ProvSet) {
	defer func() {
		scope.Remove(slip.Symbol("*load-pathname*"))
		scope.Remove(slip.Symbol("*load-truename*"))
	}()
	var (
		code  slip.Code
		paths slip.List
	)

	_ = fs.WalkDir(lispFS, ".",
		func(path string, _ fs.DirEntry, err error) error {
			if err != nil || !strings.HasSuffix(strings.ToLower(path), ".lisp") {
				return nil
			}
			var f fs.File
			if f, err = lispFS.Open(path); err != nil {
				panic(err)
			}
			var buf []byte
			buf, err = io.ReadAll(f)
			_ = f.Close()
			if err != nil {
				panic(err)
			}
			paths = append(paths, slip.String(path))
			if path[0] != '/' {
				path = filepath.Join(slip.WorkingDir, path)
			}
			var c slip.Code
			c, listProvs = slip.ReadProv(buf, scope, path, listProvs)
			code = append(code, c...)
			return nil
		})
	scope.UnsafeLet(slip.Symbol("*load-pathname*"), paths)
	scope.UnsafeLet(slip.Symbol("*load-truename*"), paths)
	code.CompileWithProvenance(listProvs)
	code.Eval(scope, nil)

	return
}
