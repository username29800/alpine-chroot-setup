#!/bin/sh
mkdir /build
cd /build
echo 'nameserver 9.9.9.9' > /etc/resolv.conf
echo 'nameserver 149.112.112.112' >> /etc/resolv.conf
chmod 1777 /dev/shm
apk update
echo "$1"cmake "$1"make "$1"gcc "$1"g++ "$1"llvm20 "$1"clang20 "$1"gettext 7zip unzip curl zsh git python3 perl "$1"gawk "$1"m4 "$1"autoconf xz sudo vim xterm gcompat dbus dbus-x11 ibus ibus-hangul firefox font-noto-cjk font-noto-emoji sof-firmware alsa-ucm-conf xrandr tigervnc pulseaudio pavucontrol-qt "$1"bash "$1"proot | tr ' ' \\n > list
apk search mate | grep \^mate | cut -d. -f-1 | sed 's,-\d*\?$,,' >> list
apk search eudev | grep \^eudev | cut -d. -f-1 | sed 's,-\d*\?$,,' >> list
apk search libcanberra | grep \^lib | cut -d. -f-1 | sed 's,-\d*\?$,,' >> list
apk search xf86-video | grep \^xf86 | cut -d. -f-1 | sed 's,-\d*\?$,,' | sed 's,^,'"$1"',' >> list
sed -i 's,^,apk add ,' list
sed -i "1i#\!/bin/sh" list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*-doc$,,' list
sed -i 's,^.*-dev$,,' list
sed -i 's,^apk add #.*\?$,,' list
chmod 500 list
./list
echo 'add user: username must be user'
adduser user
echo vncpasswd
su -c vncpasswd user
sed -i "$(cat /etc/sudoers | grep -n '^root ALL' | head -n1 | cut -d: -f-1)"a"user ALL=(ALL:ALL) ALL" /etc/sudoers
cd /home/user
mkdir Downloads Documents Pictures Music Videos Projects
mkdir -p .config/tigervnc
echo 'export GTK_IM_MODULE=ibus' > .bashrc
echo 'export QT_IM_MODULE=ibus' >> .bashrc
echo 'export XMODIFIERS=@im=ibus' >> .bashrc
echo 'export PULSE_SERVER=localhost' >> .bashrc
cp .bashrc .config/tigervnc/xstartup
echo 'xrandr --output VNC-0 --mode 1920x1080' >> .config/tigervnc/xstartup
echo 'mate-session' >> .config/tigervnc/xstartup
ln -sf .config/tigervnc/xstartup
echo '#!/bin/sh' > /bin/safefox
echo 'export MOZ_FAKE_NO_SANDBOX=1' >> /bin/safefox
echo 'firefox $1' >> /bin/safefox
chmod 755 /bin/safefox
chmod 744 .config/tigervnc/xstartup
mkdir /usr/share/xsessions
echo '[Desktop Entry]' > /usr/share/xsessions/custom.desktop
echo 'Name=Custom' >> /usr/share/xsessions/custom.desktop
echo 'Exec=/home/user/xstartup' >> /usr/share/xsessions/custom.desktop
echo 'Type=application' >> /usr/share/xsessions/custom.desktop
sed -i "$(cat /etc/passwd | grep -n ^user: | cut -d: -f-1)"s,'/sh$,/zsh,' /etc/passwd
echo "LD_PRELOAD=/system/lib64/libskcodec.so pulseaudio --load='module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1'" > /sndsrv
sed -i 1i"#\!/bin/sh" /sndsrv
chmod 755 /sndsrv
echo "#\!/bin/sh" > /pinit
echo 'proot -b /dev -b mem:/dev/shm -b /proc -b /sys -r . -0 -l --sysvipc /bin/su -l $1' >> /pinit
chmod 755 /pinit
echo "#\!/bin/sh" > /cinit
echo 'mount --bind /dev dev' >> /cinit
echo 'mount --bind /proc proc' >> /cinit
echo 'mount --bind /sys sys' >> /cinit
echo 'chroot . /bin/su -c "'/initpty \$1 \$2'" root' >> /cinit
echo 'umount dev' >> /cinit
echo 'umount proc' >> /cinit
echo 'umount sys' >> /cinit
chmod 755 /cinit
echo "#\!/bin/sh" > /initpty
echo '"$2"'"mount -t devpts devpts /dev/pts" >> /initpty
echo "chmod 666 /dev/pts/ptmx" >> /initpty
echo "su -l "'"$1"' >> /initpty
echo '"$2"'"umount /dev/pts" >> /initpty
chmod 744 /initpty
echo 'SendPrimary=0' >> /etc/tigervnc/vncserver-config-mandatory
echo "#\!/bin/sh" > /home/user/theme
echo 'safefox https://www.pling.com/p/1267246/ &' >> /home/user/theme
echo 'safefox https://www.pling.com/p/1598493/ &' >> /home/user/theme
chmod 700 /home/user/theme
cd /build
git clone https://github.com/naver/d2codingfont
git clone https://github.com/ohmyzsh/ohmyzsh
mkdir /home/user/.fonts
unzip d2codingfont/D2Coding-Ver1.3.2*.zip
cp D2Coding/*.ttf /home/user/.fonts
fc-cache
chown -R user /home/user
chmod -R 755 /build/ohmyzsh
su -c "sh /build/ohmyzsh/tools/install.sh" user
sed -ir "$(cat /home/user/.zshrc | grep -n ^ZSH_THEME | head -n1 | cut -d: -f-1)"'s,=.*\?$,="agnoster",' /home/user/.zshrc
chown -R user /home/user
exit
