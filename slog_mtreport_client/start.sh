#!/bin/bash

rm _manual_stop_ > /dev/null 2>&1

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./libmtreport
Count=`pgrep -f slog_mtreport_client -l |grep slog_mtreport|wc -l`
if [ $Count -gt 0 ]; then
	echo "already start"
	exit 0
fi

proc=slog_mtreport_client
./$proc
pid=`ps -ef |grep $proc|grep -v tail|grep -v grep|awk '{print $2;}'`
if [ -z "$pid" ]; then
	echo "start failed !"
	exit
fi
echo "start ok pid: "
echo "$pid"

