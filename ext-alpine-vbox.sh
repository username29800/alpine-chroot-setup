#!/bin/sh
mkdir /build
cd /build
#install required packages - generate batch installer
apk update
apk search virtualbox-guest-additions | grep \^virtualbox | sed 's,[-_]\d.*,,' | sed 's,^,'"$1"',' >> list
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
#batch install packages
./list
#enable vboxadditions by default
rc-update virtualbox-guest-additions boot
rc-update virtualbox-drm-client default
VBoxClient --clipboard
#workaround - fix ac97 sound compression bug
echo 'options snd-intel8x0 ac97_clock=48000' > /etc/modprobe.d/sound.conf
