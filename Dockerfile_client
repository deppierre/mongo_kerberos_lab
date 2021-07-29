FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV KRB5_KTNAME=/tmp/keytab/muser.keytab
ENV KRB5_CLIENT_KTNAME=/tmp/keytab/muser.keytab
ENV KRB5_TRACE=/var/log/mongo_kerberos.log

#Copy local files to the Docker image
COPY keytab/* /tmp/keytab/
COPY conf/* /tmp/

#Install requierments
RUN apt-get update; apt-get upgrade &&\
    apt-get -y install wget libcurl3 libgssapi-krb5-2 libldap-2.4-2 libwrap0 libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-mit snmp openssl liblzma5 &&\ 
    \
    wget -q -O "/tmp/mdb_client.deb" https://repo.mongodb.com/apt/ubuntu/dists/xenial/mongodb-enterprise/4.4/multiverse/binary-amd64/mongodb-enterprise-shell_4.4.6_amd64.deb &&\
    dpkg -i /tmp/mdb_client.deb &&\
    rm -f /tmp/mdb_client.deb

RUN chmod 600 /tmp/keytab/*.keytab &&\
    mv /tmp/krb5.conf /etc/

CMD mongo --host mdbsvc.krb5.mongodb-field.com -u muser@KRB5.MONGODB-FIELD.COM --authenticationMechanism GSSAPI --authenticationDatabase='$external' --gssapiHostName mdbsvc.krb5.mongodb-field.com --gssapiServiceName mongodb --eval 'db.version'
