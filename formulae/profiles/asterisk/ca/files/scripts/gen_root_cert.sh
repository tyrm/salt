#!/usr/bin/env bash

cd /etc/asterisk/ca
openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem
chown asterisk:asterisk certs/ca.cert.pem
