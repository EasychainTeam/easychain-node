#!/bin/bash
readonly PROG_DIR=$(readlink -m $(dirname $0))
easychaind=$PROG_DIR/../easychaind
log=$PROG_DIR/../logs/easychian_node.log

function auto_restart(){
	status=`$easychaind status`
	if [ "$status" == "Easychain server is not running" ];then
		$easychaind restart
		echo "`date +%F' '%H:%M:%S`[error]	Easychain server is not running and restarted" >> $log
	else
		echo "`date +%F' '%H:%M:%S`[info]	Easychain server is running" >> $log
	fi	
	/etc/init.d/ntp stop
	sleep 2
	ntpdate pool.ntp.org >> $log
	/etc/init.d/ntp start
}

auto_restart
