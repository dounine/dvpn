#!/usr/bin/expect
set loop 0
spawn /etc/ovpn/easyrsa/easyrsa build-ca nopass
expect "]:"
send "\r"
expect eof
exit
