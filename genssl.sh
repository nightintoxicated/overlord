#!/bin/bash
hostname=$(hostname)
echo "important field is common name, make sure this is set to $hostname"
echo "the challenge password can be ignored"
sleep 3
mkdir ./ssl/
openssl req -newkey rsa:2048 -nodes -keyout ./ssl/overlord.key -out ./ssl/overlord.csr

openssl x509 -signkey ./ssl/overlord.key -in ./ssl/overlord.csr -req -days 365 -out ./ssl/overlord.crt

rm -f overlord.csr
#overlord.key = private key
#overlord.crt = self signed certificate
