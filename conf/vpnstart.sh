#!/bin/bash
pkill openvpn
/etc/openvpn/sbin/openvpn --daemon --config /etc/openvpn/server.conf
