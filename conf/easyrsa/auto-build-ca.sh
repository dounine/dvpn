#!/usr/bin/expect
set loop 0
spawn /etc/openvpn/easyrsa3/easyrsa build-ca nopass
expect "]:"
send "\r"
expect eof
exit
