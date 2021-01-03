#!/usr/bin/env bash

cd /etc/asterisk/ca
openssl x509 -noout -text -in certs/ca.cert.pem
