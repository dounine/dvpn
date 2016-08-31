#!/bin/bash
source shell/funs.sh
#project download address：https://github.com/dounine/dvpn
#project author:huanghuanlai
#project version:1.0.0
#project create time:2016-09-02 13:11:00

#获取dvpn所在工作目录
workdir=$(cd `dirname $0`;pwd)
opdir=/etc/openvpn
#安装环境所依赖的软件
log "安装软件所依赖的环境"
$workdir/shell/readhat/yum-install.sh
log "安装lzo必要组件"
$workdir/shell/readhat/install-lzo.sh $workdir
log "mproxy 转接代理下载中..."
#定义mprox除y下载编译的所在目录
mpdir=.mproxy
if [ -d $mpdir ];then
	drm $mpdir
fi
dmkdir $mpdir && cd $mpdir
#下载github中的单个文件
mpgithub=https://github.com/dounine/mproxy/raw/master
wget $mpgithub/mproxy.c 
wget $mpgithub/Makefile
log "mproxy c代码编译中..."
make
cd $workdir/soft
drm easyrsa3
log "easyrsa3 下载中..."
svn checkout https://github.com/dounine/easy-rsa/trunk/easyrsa3
log "easyrsa3 复制==>>"$opdir
cp -rf $workdir/soft/easyrsa3 $opdir
log "openvpn2.3.12 安装编译"
cd $workdir/soft && tar -zxf openvpn-2.3.12.tar.gz
cd $workdir/soft/openvpn-2.3.12 && ./configure --prefix=/etc/openvpn && make && make install
log "编译安装完成"
log "复制证书生成脚本"
cp -rf $workdir/conf/scripts/* $opdir/easyrsa3
log "生成ca证书"
log "openvpn 证书相关操作"
cd $opdir/easyrsa3 && ./init.sh

