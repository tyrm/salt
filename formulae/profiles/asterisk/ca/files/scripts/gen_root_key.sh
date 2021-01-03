#!/usr/bin/env bash

cd /etc/asterisk/ca

FILE=private/ca.key.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl genrsa -aes256 -out $FILE 4096

chmod 400 $FILE
chown asterisk:asterisk $FILE
