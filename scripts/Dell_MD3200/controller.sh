#!/bin/bash
source $(dirname "$0")/config.sh
CACHE_FILE="/tmp/zabbix.3200.controller.$1.$2.cache"
Enclosure=${3:0:1}
Slot=${3:1:1}

if [ "$4" = "Get_Data" ]; then
      $_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show allControllers summary;" > "$CACHE_FILE.new"
      mv "$CACHE_FILE.new" $CACHE_FILE
      echo 'OK'
fi

if [ "$4" = "Status" ]; then
cat $CACHE_FILE | egrep -A 10 "RAID Controller Module in Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| egrep 'Status'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Interface_Status" ]; then
cat $CACHE_FILE | egrep -A 60 "RAID Controller Module in Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| egrep -A 3 'Host Interface Board'| egrep 'Status'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Cache_Backup_Device_Status" ]; then
cat $CACHE_FILE | egrep -A 60 "RAID Controller Module in Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| egrep -A 3 'Cache Backup Device'| egrep 'Status'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
fi
