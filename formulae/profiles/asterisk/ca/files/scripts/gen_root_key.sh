#!/usr/bin/env bash

cd /etc/asterisk/ca
openssl genrsa -aes256 -out private/ca.key.pem 4096

chmod 400 private/ca.key.pem
chown asterisk:asterisk private/ca.key.pem
