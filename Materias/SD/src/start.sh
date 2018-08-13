#!/bin/bash

if [[ "$1" != "merge" && "$1" != "sort" ]]
then
	echo "usage: $0 <merge | sort>"
	exit 1
fi

killall $1
cat hosts_$1.txt |cut -f2 -d" "|while read port;do (./$1 $port &); done
