#!/usr/bin/env bash
set -u
set -e

NAME=$1

cd /etc/asterisk/ca

FILE=certs/$NAME.cert.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl ca -config confs/$NAME.cnf \
      -extensions usr_cert -days 375 -notext -md sha256 \
      -in csr/$NAME.csr.pem \
      -out $FILE

chmod 444 $FILE
chown asterisk:asterisk $FILE
