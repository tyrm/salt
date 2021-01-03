#!/usr/bin/env bash
set -u
set -e

NAME=server

cd /etc/asterisk/ca

FILE=certs/$NAME.cert.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl ca -config confs/$NAME.cnf \
      -extensions server_cert -days 3650 -notext -md sha256 \
      -in csr/$NAME.csr.pem \
      -out $FILE

chmod 444 $FILE
chown asterisk:asterisk $FILE

cat $FILE > keys/server.pem
cat private/$NAME.key.pem >> keys/server.pem

chmod 400 keys/server.pem
chown asterisk:asterisk keys/server.pem
