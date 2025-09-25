#!/bin/sh
mkdir /build
cd /build
echo 'nameserver 1.1.1.2' > /etc/resolv.conf
echo 'nameserver 1.0.0.2' >> /etc/resolv.conf
chmod 1777 /dev/shm
apk update
echo openssh openbox xfe qterminal rofi mousepad 7zip unzip curl zsh git python3 perl gawk xz sudo vim xterm gcompat dbus dbus-x11 ibus ibus-hangul firefox font-noto-cjk font-noto-emoji sof-firmware alsa-ucm-conf xrandr tigervnc pulseaudio pavucontrol-qt | tr ' ' \\n > list
apk search eudev | grep \^eudev | sed 's,[-_]\d.*,,' >> list
apk search xf86-video | grep \^xf86 | sed 's,[-_]\d.*,,' | sed 's,^,'"$1"',' >> list
apk search libcanberra | grep \^lib | sed 's,[-_]\d.*,,' | sed 's,^,'"$1"',' >> list
apk search zsh | grep \^zsh | sed 's,[-_]\d.*,,' | sed 's,^,'"$1"',' >> list
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
