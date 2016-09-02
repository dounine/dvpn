#!/bin/bash
ip=$(curl -o /tmp/ip.tmp http://1212.ip138.com/ic.asp && awk -F "\r" 'NR==6{print $1}' /tmp/ip.tmp | awk -F "[" '{print $2}' | awk -F "]" '{print $1}')
echo $ip
