#!/usr/bin/env bash

cd /etc/asterisk/ca

FILE=csr/server.csr.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl req -config confs/server.cnf \
      -key private/server.key.pem \
      -new -sha256 -out $FILE

chmod 444 $FILE
chown asterisk:asterisk $FILE
