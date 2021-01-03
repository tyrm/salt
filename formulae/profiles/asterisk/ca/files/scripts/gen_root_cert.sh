#!/usr/bin/env bash

cd /etc/asterisk/ca

FILE=certs/ca.cert.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out $FILE

chmod 444 $FILE
chown asterisk:asterisk $FILE
