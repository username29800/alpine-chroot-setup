#!/bin/sh
mkdir /build
cd /build
apk update
echo cmake make gcc "$1"g++ "$1"llvm20 "$1"clang20 "$1"gettext lzip 7zip unzip curl wget git python3 perl "$1"gawk "$1"m4 "$1"autoconf automake xz "$1"bash "$1"proot | tr ' ' \\n > list
echo vim nano libreoffice-writer mc micro neovim code-oss | tr ' ' \\n >> list
echo ncurses-dev | tr ' ' \\n >> list
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
./list

git clone https://github.com/troglobit/mg
cd mg
./autogen.sh
./configure
make
make install
cd ..

git clone https://github.com/torvalds/uemacs
cd uemacs
make
make install
cd ..

edver='ed-1.22'
curl -o $edver.tar.lz http://ftp.gnu.org/gnu/ed/$edver.tar.lz
lzip -d $edver.tar.lz
tar -xf $edver.tar
cd $edver
./configure
make
make install
cd ..
