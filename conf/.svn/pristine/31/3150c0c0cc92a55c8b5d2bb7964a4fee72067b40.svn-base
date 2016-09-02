#!/bin/bash
echo "=======>>source to vars<<======"
source ./vars.example
echo "==========>>init-pki<<=========="
/etc/ovpn/easyrsa/easyrsa init-pki
echo "==========>>build ca.crt,ca.key<<=========="
expect auto-build-ca.sh
echo "==========>>build server.crt,server.key<<========"
expect auto-build-cs.sh server
expect auto-sign-req.sh server server
echo "==========>>build client.crt,client.key<<========"
expect auto-build-cs.sh client
expect auto-sign-req.sh client client
echo "==========>>build dh <<========"
bash auto-build-dh.sh
echo "==========>>>finish<<<========"
