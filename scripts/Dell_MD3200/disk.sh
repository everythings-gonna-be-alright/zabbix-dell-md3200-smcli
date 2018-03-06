#!/bin/bash
source $(dirname "$0")/config.sh
CACHE_FILE="/tmp/zabbix.3200.disk.$1.$2.cache"
Enclosure=${3:0:1}
Slot=${3:1:1}

if [ "$4" = "Get_Data" ]; then
      $_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show allPhysicalDisks;" > "$CACHE_FILE.new"
      mv "$CACHE_FILE.new" $CACHE_FILE
      echo 'OK'
fi

if [ "$4" = "Status" ]; then
cat $CACHE_FILE | egrep -A 10 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Status'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Data_rate" ]; then
cat $CACHE_FILE | egrep -A 35 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Current data rate'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Product_ID" ]; then
cat $CACHE_FILE | egrep -A 45 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Product ID'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Speed" ]; then
cat $CACHE_FILE | egrep -A 45 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Speed'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Mode" ]; then
cat $CACHE_FILE | egrep -A 10 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Mode'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Manufacturer" ]; then
cat $CACHE_FILE | egrep -A 45 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Manufacturer'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Raw_capacity" ]; then
cat $CACHE_FILE | egrep -A 10 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Raw capacity'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "Usable_capacity" ]; then
cat $CACHE_FILE | egrep -A 10 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Usable capacity'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
elif [ "$4" = "RW" ]; then
cat $CACHE_FILE | egrep -A 45 "Physical Disk at Enclosure $Enclosure, Slot $Slot$" | egrep -v '^$'| grep 'Read/write accessible'| cut -d ":" -f "2"| sed 's/^[ \t]*//'
fi

