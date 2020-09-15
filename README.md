# upper/db + CockroachDB example

## Run the insecure node example

Create and run an insecure node:

```
make insecure-node
```

Open a second terminal and create the bank database:

```
make bank-database-insecure
```

Run the `main.go` example:

```
go run main.go
```

## Run the secure node example

Create and run a secure node:

```
make secure-node
```

Open a second terminal and create the bank database:

```
make bank-database-secure
```

Edit the `main.go` file and add options for secure connection:

```go
var settings = cockroachdb.ConnectionURL{
	Host:     "localhost",
	Database: "bank",
	User:     "maxroach",
	Options: map[string]string{
		// Insecure node.
		// "sslmode": "disable",
		// Secure node.
		"sslrootcert": "certs/ca.crt",
		"sslkey":      "certs/client.maxroach.key",
		"sslcert":     "certs/client.maxroach.crt",
	},
}
```

Run the `main.go` example:

```
go run main.go
```
