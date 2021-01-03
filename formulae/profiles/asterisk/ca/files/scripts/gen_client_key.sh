#!/usr/bin/env bash
set -u
set -e

NAME=$1

cd /etc/asterisk/ca

FILE=private/$NAME.key.pem
if test -f "$FILE"; then
    echo "$FILE exists."
    exit 1
fi

openssl genrsa -out $FILE 4096

chmod 400 $FILE
chown asterisk:asterisk $FILE
