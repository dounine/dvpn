#!/bin/bash
source shell/funs.sh
#project download address：https://github.com/dounine/dvpn
#project author:huanghuanlai
#project version:1.0.0
#project create time:2016-09-02 13:11:00

#openvpn port
openvpn_port=5550
mproxy_port=5551
squid_port=5552


#获取dvpn所在工作目录
workdir=$(cd `dirname $0`;pwd)
opdir=/etc/openvpn
log "还原项目"
cd $workdir
git checkout *
git reset 
git clean -df
log "环境清理中"
drm $opdir
drm /usr/bin/vpn
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
dmkdir $mpdir && cd $mpdir/
#下载github中的单个文件
mpgithub=https://github.com/dounine/mproxy/raw/master
wget $mpgithub/mproxy.c 
wget $mpgithub/Makefile
log "mproxy c代码编译中..."
cd $workdir/$mpdir && make
sed -i 's/8080/$mproxy_port/g' $workdir/$mpdir/mproxy.c
sed -i 's/3330/$openvpn_port/g' $workdir/$mpdir/mproxy.c
log "mproxy复制"
cp $workdir/.mproxy/mproxy /usr/bin/
log "openvpn2.3.12 安装编译"
cd $workdir/soft && tar -zxf openvpn-2.3.12.tar.gz
cd $workdir/soft/openvpn-2.3.12 && ./configure --prefix=$opdir && make && make install
cd $workdir/soft
drm easyrsa3
log "easyrsa3 下载中..."
svn checkout https://github.com/dounine/easy-rsa/trunk/easyrsa3
log "easyrsa3 复制==>>"$opdi
cp -rf $workdir/soft/easyrsa3/ $opdir/
log "编译安装完成"
log "复制证书生成脚本"
cp -rf $workdir/conf/scripts/* $opdir/easyrsa3/
cp -rf $workdir/shell/funs.sh $opdir/easyrsa3/
log "生成ca证书"
cd $opdir/easyrsa3 && ./init.sh $opdir/
log "生成防攻击ta.key"
$opdir/sbin/openvpn --genkey --secret $opdir/easyrsa3/pki/ta.key
log "复制openvpn所需脚本"
cp -rf $workdir/conf/openvpn/* $opdir/
log "vpn启动脚本复制"
cp -rf $workdir/conf/openvpn/vpn /usr/bin/
log "openvpn服务器脚本复制"
cp -rf $workdir/conf/openvpn/server.conf $opdir/
log "端口替换"
sed -i 's/__port__/$openvpn_port/g' /usr/bin/vpn
sed -i 's/__port__/$openvpn_port/g' $opdir/createovpn.sh
sed -i 's/__port__/$openvpn_port/g' $opdir/server.conf
