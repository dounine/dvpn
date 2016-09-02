#/usr/bin/expect
set type [lindex $argv 0]
set name [lindex $argv 1]
spawn /etc/ovpn/easyrsa/easyrsa sign-req $type $name
expect "details:"
send "yes\r"
expect eof
exit
