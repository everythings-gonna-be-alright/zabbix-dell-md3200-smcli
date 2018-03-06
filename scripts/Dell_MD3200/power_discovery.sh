#!/bin/bash
source $(dirname "$0")/config.sh
IFS=$'\n'
begin="{\"data\":["

powers=`$_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show storagearray powerinfo;" | egrep -A 30 'Enclosure power input details:'| egrep 'Watts'`

data=$(for power in $powers
do
    dig=`echo $power|awk '{print $1$2}'`
    echo "{\"{#POWERNAME}\":\"$dig\",\"{#POWERSHORTNAME}\":\"$dig\"},"
done | sed '$s/,$//')

final="]}"
echo $begin$data$final | python -mjson.tool
