module github.com/ohler55/slap

go 1.25

require (
	github.com/ohler55/slip v1.4.0
	github.com/ohler55/slip-fhir v1.4.0
	github.com/ohler55/slip-ggql v1.4.0
	github.com/ohler55/slip-mongo v1.4.0
	golang.org/x/term v0.39.0
)

require (
	github.com/golang/snappy v0.0.4 // indirect
	github.com/klauspost/compress v1.18.0 // indirect
	github.com/montanaflynn/stats v0.7.1 // indirect
	github.com/ohler55/ojg v1.27.0 // indirect
	github.com/uhn/ggql v1.2.14 // indirect
	github.com/xdg-go/pbkdf2 v1.0.0 // indirect
	github.com/xdg-go/scram v1.1.2 // indirect
	github.com/xdg-go/stringprep v1.0.4 // indirect
	github.com/youmark/pkcs8 v0.0.0-20240726163527-a2c0da244d78 // indirect
	go.mongodb.org/mongo-driver v1.17.6 // indirect
	golang.org/x/crypto v0.41.0 // indirect
	golang.org/x/sync v0.16.0 // indirect
	golang.org/x/sys v0.40.0 // indirect
	golang.org/x/text v0.28.0 // indirect
)

replace github.com/ohler55/slip => ../slip

replace github.com/ohler55/slip-fhir => ../slip-fhir

// replace github.com/ohler55/slip-jet => ../slip-jet

replace github.com/ohler55/slip-mongo => ../slip-mongo

replace github.com:ohler55/slip-ggql/slipggql => ../slip-ggql

// replace github.com:ohler55/slip-message/message => ../slip-message

// replace github.com:ohler55/slip-parquet/slipparquet => ../slip-parquet
