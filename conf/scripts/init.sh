#!/bin/bash
echo "=======>>source to vars<<======"
source ./vars.example
echo "==========>>生成-pki<<=========="
/etc/openvpn/easyrsa3/easyrsa init-pki
echo "==========>>生成证书文件<<=========="
expect build-ca.sh
echo "==========>>生成服务证书文件并注册<<========"
expect build-cs.sh server
expect sign-req.sh server server
echo "==========>>生成客户端证书并注册<<========"
expect build-cs.sh client
expect sign-req.sh client client
echo "==========>>生成交换密钥<<========"
bash build-dh.sh
