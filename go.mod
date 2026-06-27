module github.com/ohler55/slap

go 1.26

require (
	github.com/ohler55/slip v1.5.0
	github.com/ohler55/slip-fhir v1.5.0
	github.com/ohler55/slip-ggql v1.5.0
	github.com/ohler55/slip-jet v1.5.0
	github.com/ohler55/slip-message v1.5.0
	github.com/ohler55/slip-mongo v1.5.0
	golang.org/x/term v0.42.0
)

require (
	github.com/golang/snappy v0.0.4 // indirect
	github.com/klauspost/compress v1.18.5 // indirect
	github.com/montanaflynn/stats v0.7.1 // indirect
	github.com/nats-io/nats.go v1.52.0 // indirect
	github.com/nats-io/nkeys v0.4.15 // indirect
	github.com/nats-io/nuid v1.0.1 // indirect
	github.com/ohler55/ojg v1.28.1 // indirect
	github.com/uhn/ggql v1.2.14 // indirect
	github.com/xdg-go/pbkdf2 v1.0.0 // indirect
	github.com/xdg-go/scram v1.1.2 // indirect
	github.com/xdg-go/stringprep v1.0.4 // indirect
	github.com/youmark/pkcs8 v0.0.0-20240726163527-a2c0da244d78 // indirect
	go.mongodb.org/mongo-driver v1.17.9 // indirect
	golang.org/x/crypto v0.50.0 // indirect
	golang.org/x/sync v0.20.0 // indirect
	golang.org/x/sys v0.43.0 // indirect
	golang.org/x/text v0.36.0 // indirect
)

replace github.com/ohler55/slip => ../slip

replace github.com/ohler55/slip-fhir => ../slip-fhir

replace github.com/ohler55/slip-jet => ../slip-jet

replace github.com/ohler55/slip-mongo => ../slip-mongo

replace github.com/ohler55/slip-ggql => ../slip-ggql

replace github.com/ohler55/slip-message => ../slip-message

// replace github.com/ohler55/slip-parquet => ../slip-parquet
