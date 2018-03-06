#!/bin/bash
source $(dirname "$0")/config.sh
CACHE_FILE="/tmp/zabbix.3200.power.$1.$2.cache"
Enclosure=${3:0:1}
Slot=${3:1:1}

if [ "$4" = "Get_Data" ]; then
      $_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show storagearray powerinfo;" > "$CACHE_FILE.new"
      mv "$CACHE_FILE.new" $CACHE_FILE
      echo 'OK'
fi

if [ "$4" = "Status" ]; then
cat $CACHE_FILE | egrep "$Enclosure             $Slot" | egrep -v '^$'| awk '{print $3}'| sed 's/^[ \t]*//'
fi
