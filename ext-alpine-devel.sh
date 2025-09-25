#!/bin/sh
mkdir /build
cd /build
apk update
echo cmake make gcc "$1"g++ "$1"llvm20 "$1"clang20 "$1"gettext 7zip unzip curl zsh git python3 perl "$1"gawk "$1"m4 "$1"autoconf automake xz sudo vim gcompat dbus dbus-x11 "$1"bash "$1"proot | tr ' ' \\n > list
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
./list
