#!/usr/bin/env bash
set -u
set -e

NAME=$1

cd /etc/asterisk/ca

openssl ca -config confs/$NAME.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in csr/$NAME.csr.pem \
      -out certs/$NAME.cert.pem

chmod 444 certs/$NAME.cert.pem
chown asterisk:asterisk certs/$NAME.cert.pem
