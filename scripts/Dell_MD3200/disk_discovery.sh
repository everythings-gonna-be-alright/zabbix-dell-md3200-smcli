#!/bin/bash
source $(dirname "$0")/config.sh
IFS=$'\n'
begin="{\"data\":["

disks=`$_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show allPhysicalDisks;" | egrep 'Physical Disk at Enclosure'`

data=$(for disk in $disks
do
    dig=`echo $disk|sed 's/[^0-9]*//g'`
    name=`echo $disk|sed 's/^[ \t]*//'`
    echo "{\"{#DISKNAME}\":\"$name\",\"{#DISKSHORTNAME}\":\"$dig\"},"
done | sed '$s/,$//')

final="]}"
echo $begin$data$final | python -mjson.tool
