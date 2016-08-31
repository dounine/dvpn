#!/bin/bash
opdir=$1
source $opdir/easyrsa3/funs.sh
log "生效var.example"
source ./vars.example
log "生成pki"
rm -rf $opdir/easyrsa3/pki
$opdir/easyrsa3/easyrsa init-pki
log "生成证书文"
expect build-ca.sh
log "生成服务证书文件并注"
expect build-cs.sh server
expect sign-req.sh server server
log "生成客户端证书并�"
expect build-cs.sh client
expect sign-req.sh client client
log "生成交换密钥"
bash build-dh.sh
