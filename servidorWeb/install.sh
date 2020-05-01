#!/bin/bash
apt install -y lighttpd proftpd-basic
touch /etc/proftpd/ftpd.passwd
chown proftpd: /etc/proftpd/ftpd.passwd
cp protpd.conf  /etc/proftpd/proftpd.conf
cp virtual_users.conf /etc/proftpd/conf.d/virtual_users.conf
chmod ug=r,o-r /etc/proftpd/ftpd.passwd
#Crear els usuaris
userid=15003
INPUT=4tESO.csv
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read pw nom 
do
    sh -c  "echo '$pw' | ftpasswd --stdin --passwd --file=/etc/proftpd/ftpd.passwd --name=$nom --uid=$userid --gid=$userid --home=/var/www/html/$nom $
    mkdir -m 700 -p /var/www/html/$nom
    chown $userid /var/www/html/$nom
    chmod a+x /var/www/html/$nom
    #touch /var/www/html/$nom/index.html
    userid=$(($userid+1))
done < $INPUT
IFS=$OLDIFS


