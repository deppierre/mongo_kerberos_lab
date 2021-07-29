# Setup the network
```bash
docker network create --subnet=172.18.0.0/24 mdb_kerberos_net
```

# Setup the mongod server using Kerberos authentication
## Build in directory kerberos_server/
```bash
docker build kerberos_server/ -t mdb_kerberos_host
```

## Run a new container based on the image build previously
```bash
docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:52.62.224.95" \
--add-host="mdbsvr.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl01.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl02.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl03.krb5.mongodb-field.com:52.62.224.95" \
-h kerberoshost \
--network=mdb_kerberos_net \
--ip 172.18.0.2 \
--name mdb_kerberos_container mdb_kerberos_host
```

# Setup the mongo client using Kerberos authentication
## Build in directory kerberos_client/
```bash
docker build kerberos_client/ -t mdb_client
```

## Run a new container that connect to the server using Kerberos authentication
```bash
docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:172.18.0.2" \
--network=mdb_kerberos_net \
--name mdb_kerberos_client \
mdb_client
```