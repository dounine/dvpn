#!/bin/bash
workdir=$1
cd $workdir/soft
tar -zxf lzo-2.06.tar.gz && cd lzo-2.06
./configure && make && make install
