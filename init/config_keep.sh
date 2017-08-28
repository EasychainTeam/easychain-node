#!/bin/bash
#auth:lumpo
#date:2016-07-15

readonly INIT_DIR=$(readlink -m $(dirname $0))

function add_cron() {
	cnt=`cat /etc/crontab | grep 'keepalive' | grep -v '#' | wc -l`
	if [ $cnt -eq 0 ];then
		echo "*/1 * * * * root $INIT_DIR/keepalive.sh" >> /etc/crontab
		if [ $? -ne 0 ];then
			echo "Add keepalive crontab err, please add it manually!" && exit 2
		fi
	fi
}

function main() {
	add_cron
	echo "Configure keepalive crontab done."
}

main
