clean:
	rm -rf cockroach-data certs private

secure-node: clean
	mkdir -p certs private && \
	cockroach cert create-ca --certs-dir=certs --ca-key=private/ca.key && \
	cockroach cert create-node localhost --certs-dir=certs --ca-key=private/ca.key && \
	cockroach cert create-client root --certs-dir=certs --ca-key=private/ca.key && \
	cockroach cert create-client maxroach --certs-dir=certs --ca-key=private/ca.key && \
	cockroach start --certs-dir=certs

insecure-node: clean
	cockroach start --insecure

bank-database-insecure:
	cockroach sql --insecure -e 'CREATE USER IF NOT EXISTS maxroach; CREATE DATABASE IF NOT EXISTS bank; GRANT ALL ON DATABASE bank TO maxroach;'
	cockroach sql --insecure --database bank -e 'CREATE TABLE IF NOT EXISTS accounts (ID SERIAL PRIMARY KEY, balance INT);'

bank-database-secure:
	cockroach sql --certs-dir=certs -e 'CREATE USER IF NOT EXISTS maxroach; CREATE DATABASE IF NOT EXISTS bank; GRANT ALL ON DATABASE bank TO maxroach;'
	cockroach sql --certs-dir=certs --database bank -e 'CREATE TABLE IF NOT EXISTS accounts (ID SERIAL PRIMARY KEY, balance INT);'
