#!/bin/bash
echo "download mproxy..."
mproxy=tmp_mproxy
mkdir $mproxy && cd $mproxy
wget https://github.com/dounine/mproxy/raw/master/mproxy.c > /dev/null 
wget https://github.com/dounine/mproxy/raw/master/Makefile > /dev/null
echo "download mproxy finish"
echo "compile mproxy finish"
make
echo "compile mproxy finish"
