#!/bin/sh
#This version of script is intended for an archive extractor container, used for unpacking rootfs other than alpine without permission issues, in termux
mkdir /build
cd /build
echo 'nameserver 1.1.1.2' > /etc/resolv.conf
echo 'nameserver 1.0.0.2' >> /etc/resolv.conf
chmod 1777 /dev/shm
apk update
echo openssh 7zip unzip gzip curl git python3 perl gawk xz sudo vim gcompat dbus dbus-x11 | tr ' ' \\n > list
sed -i '2s,^.*$,&\n&,' /etc/apk/repositories
sed -i '3s,alpine/.*$,alpine/edge/testing,' /etc/apk/repositories
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*-doc$,,' list
sed -i 's,^.*-dev$,,' list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
./list
echo 'add user manually: username must be user'
echo '(command may differ by distribution)'
#echo "adduse.r/psw.d/
#adduse.r/psw.d/" | adduser user
