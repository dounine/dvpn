#!/usr/bin/expect
set name [lindex $argv 0]
spawn /etc/ovpn/easyrsa/easyrsa gen-req $name nopass
expect "]:"
send "\r"
expect eof
exit
