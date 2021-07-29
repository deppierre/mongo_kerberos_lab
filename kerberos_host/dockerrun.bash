docker network create --subnet=172.18.0.0/24 mdb_kerberos_net

#SERVER
##BUILD in kerberos_server/
docker build . -t mdb_kerberos_host

##RUN
docker rm -f mdb_kerberos_container \ 
docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:52.62.224.95" \
--add-host="mdbsvr.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl01.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl02.krb5.mongodb-field.com:52.62.224.95" \
--add-host="repl03.krb5.mongodb-field.com:52.62.224.95" \
-d \
-h kerberoshost \
--network=mdb_kerberos_net \
--ip 172.18.0.2 \
--name mdb_kerberos_container mdb_kerberos_host

docker exec -ti mdb_kerberos_container \
mongo \
-u muser@KRB5.MONGODB-FIELD.COM \
-p RE3xm453Kym4KdjA \
--authenticationMechanism GSSAPI \
--authenticationDatabase='$external' \
--gssapiHostName mdbsvc.krb5.mongodb-field.com

#CLIENT
##BUILD in kerberos_client/
docker build . -t mdb_client

docker run --rm \
--add-host="mdbsvc.krb5.mongodb-field.com:172.18.0.2" \
--network=mdb_kerberos_net \
--name mdb_kerberos_client \
mdb_client