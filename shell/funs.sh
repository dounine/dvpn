#!/bin/bash
function log()
{
	echo -e "\n=========>>>> \033[31m $1 \033[0m <<<<========\n"
	sleep 2
}
function drm()
{
	filetype="文件"
	if [ -d $1 ];then
		filetype="文件夹"
	fi
	echo -e "\n=========>>>> \033[31m 删除$1:$filetype \033[0m <<<<========\n"
	rm -rf $1
	sleep 2
}
function dmkdir()
{
	echo -e "\n=========>>>> \033[31m 创建文件夹$1 \033[0m <<<<=========\n"
	mkdir -p $1
	sleep 2
}
