#!/bin/bash
source $(dirname "$0")/config.sh
IFS=$'\n'
begin="{\"data\":["

controllers=`$_smcli_patch $1 $2 -R $_login -p $_password -S -quick -c "show allControllers summary;"| egrep 'RAID Controller Module in Enclosure'`

data=$(for contr in $controllers
do
    dig=`echo $contr|sed 's/[^0-9]*//g'`
    name=`echo $contr|sed 's/^[ \t]*//'`
    echo "{\"{#CONTNAME}\":\"$name\",\"{#CONTSHORTNAME}\":\"$dig\"},"
done | sed '$s/,$//')

final="]}"
echo $begin$data$final | python -mjson.tool
