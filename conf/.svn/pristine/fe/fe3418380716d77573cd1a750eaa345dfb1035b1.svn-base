#!/bin/bash
dip=`bash getip.sh`
echo -n "please input you vpnserver ip address[$dip]:"
read ip
if [ -z "$ip" ];then
	ip=$dip
fi
echo -n "please input you vpnserver port [replace_port]:"
read port
if [ -z "$port" ];then
	port=replace_port
fi
echo -n "please input client name [client]:"
read client
if [ -z "$client" ];then
	client="client"
fi
echo -n "please input create ovpn filename [client]:"
read filename
if [ -z "$filename" ];then
	filename="client.ovpn"
else
	filename=$filename".ovpn"
fi
str="client
dev tun
proto tcp
remote $ip $port
resolv-retry infinite
nobind
auth-user-pass
persist-key
persist-tun
comp-lzo
verb 3
<ca>
$(cat easyrsa/pki/ca.crt)
</ca>
<cert>
$(cat easyrsa/pki/issued/client.crt)
</cert>
<key>
$(cat easyrsa/pki/private/client.key)
</key>
<tls-auth>
$(cat easyrsa/pki/ta.key)
</tls-auth>
"
echo -e "$str" > $filename
echo "build Successfuled."
