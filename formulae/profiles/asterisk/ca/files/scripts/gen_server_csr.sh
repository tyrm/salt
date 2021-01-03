#!/usr/bin/env bash
set -u
set -e

NAME=server

cd /etc/asterisk/ca

FILE=csr/$NAME.csr.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl req -config confs/$NAME.cnf \
      -key private/$NAME.key.pem \
      -new -sha256 -out $FILE

chmod 444 $FILE
chown asterisk:asterisk $FILE
