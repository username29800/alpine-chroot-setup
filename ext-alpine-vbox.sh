#!/bin/sh
mkdir /build
cd /build
apk update
apk search virtualbox-guest-additions | grep \^virtualbox | sed 's,[-_]\d.*,,' | sed 's,^,'"$1"',' >> list
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
./list
