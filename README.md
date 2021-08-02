# Prerequisite for this lab
The only thing you need to install is Docker Deskop (MacOS [here](https://docs.docker.com/docker-for-mac/install/))  
Also you need to copy your keytab files in the folder `keytab`:
- client is `muser`
- server is `mdbsvc`
(both defined in the env variable `KRB5_KTNAME`)

# Setup a new subnet
```bash
docker network create --subnet=172.18.0.0/24 mdb_kerberos_net
```

# Setup the mongod server using Kerberos authentication
## Build mdb_kerberos_host image
```bash
docker build -f Dockerfile_server -t mdb_kerberos_host .
```

## Run a new container based on the mdb_kerberos_host image
```bash
docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:52.62.224.95" \
--add-host="mdbsvr.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl01.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl02.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl03.krb5.mongodb-field.com:52.62.224.95" \
--network=mdb_kerberos_net \
--ip 172.18.0.2 \
--name mdb_kerberos_container \
mdb_kerberos_host
```

# Setup the mongo client using Kerberos authentication
## Build mdb_client image
```bash
docker build -f Dockerfile_client -t mdb_client .
```

## Run a new container based on the mdb_client image
```bash
docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:172.18.0.2" \
--network=mdb_kerberos_net \
--name mdb_kerberos_client \
mdb_client
```