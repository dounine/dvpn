#!/bin/bash
#"清空iptables规则"
systemctl disable iptables.service
systemctl enable iptables.service
iptables -F
#"添加nat网络地扯交换"
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
#启动iptables
systemctl start iptables.service
#启动vpn服务
cd /etc/openvpn && bash /etc/openvpn/vpnstart.sh
