#!/usr/bin/env bash
set -u
set -e

NAME=$1

cd /etc/asterisk/ca

openssl x509 -noout -text -in certs/$NAME.cert.pem
