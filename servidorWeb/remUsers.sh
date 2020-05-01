#!/bin/bash
userid=15003
INPUT=4tESO.csv
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read password nom
do
    sh -c "ftpasswd --passwd --delete-user --name=$nom --file=/etc/proftpd/ftpd.passwd"
    rm -fr /var/www/html/$nom
    userid=$(($userid+1))
done < $INPUT
IFS=$OLDIFS

