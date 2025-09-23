#!/bin/sh
mkdir /build
cd /build
echo 'nameserver 1.1.1.2' > /etc/resolv.conf
echo 'nameserver 1.0.0.2' >> /etc/resolv.conf
chmod 1777 /dev/shm
apk update
echo cmake make gcc "$1"g++ "$1"llvm20 "$1"clang20 "$1"gettext 7zip unzip curl zsh git python3 perl "$1"gawk "$1"m4 "$1"autoconf xz sudo vim gcompat dbus dbus-x11 "$1"bash "$1"proot | tr ' ' \\n > list
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
