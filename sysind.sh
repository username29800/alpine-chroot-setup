#!/bin/sh
#prerequisites: unzip, coreutils or busybox, firefox, openbox, rofi, qterminal, xterm, tigervnc, pulseaudio, sudo, vim, git, zsh, user 'user' with home directory
mkdir /build
mkdir /rmem /mem
chmod 0666 /rmem /mem
cd /build
chmod 1777 /dev/shm
mkdir /home
mkdir /home/user
echo 'adduse.r/psw.d/
adduse.r/psw.d/' | passwd user
#echo vncpasswd - enter a new vnc password
echo "adusr.wd
adusr.wd
n" | su -c vncpasswd user
sed -i "$(cat /etc/sudoers | grep -n 'root\s\{1,\}ALL' | head -n1 | cut -d: -f-1)"a"user ALL=(ALL:ALL) ALL" /etc/sudoers
cd /home/user
mkdir Downloads Documents Pictures Music Videos Projects
mkdir -p .config/tigervnc
echo 'export GTK_IM_MODULE=ibus' > .zshrc.1
echo 'export QT_IM_MODULE=ibus' >> .zshrc.1
echo 'export XMODIFIERS=@im=ibus' >> .zshrc.1
echo 'export PULSE_SERVER=localhost' >> .zshrc.1
cp .zshrc.1 .config/tigervnc/xstartup
echo 'xrandr --output VNC-0 --mode 1920x1080' >> .config/tigervnc/xstartup
echo 'openbox' >> .config/tigervnc/xstartup
ln -sf .config/tigervnc/xstartup
echo '#!/bin/sh' > /bin/safefox
echo 'export MOZ_FAKE_NO_SANDBOX=1' >> /bin/safefox
echo 'firefox $1' >> /bin/safefox
chmod 755 /bin/safefox
echo '#!/bin/sh' > /bin/showw
echo 'rofi -show window &' >> /bin/showw
chmod 755 /bin/showw
echo '#!/bin/sh' > /bin/sdclock
echo 'xclock -digital -update 10 &' >> /bin/sdclock
chmod 755 /bin/sdclock
cp /utils/tlch /bin/tlch
cp /utils/tlch /bin/twrapper
cp /utils/tlch /bin/tlaunch
chmod 744 .config/tigervnc/xstartup
mkdir .vnc
cp xstartup .vnc/xstartup
mkdir /usr/share/xsessions
echo '[Desktop Entry]' > /usr/share/xsessions/custom.desktop
echo 'Name=Custom' >> /usr/share/xsessions/custom.desktop
echo 'Exec=/home/user/xstartup' >> /usr/share/xsessions/custom.desktop
echo 'Type=application' >> /usr/share/xsessions/custom.desktop
sed -i "$(cat /etc/passwd | grep -n ^user: | cut -d: -f-1)"s,'/sh$,/zsh,' /etc/passwd
cp /utils/swsh /home/user/swsh
echo "LD_PRELOAD=/system/lib64/libskcodec.so pulseaudio --load='module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1'" > /sndsrv
sed -i 1i"#\!/bin/sh" /sndsrv
chmod 755 /sndsrv
echo "#\!/bin/sh" > /pinit
echo 'proot -b /dev -b mem:/dev/shm -b rmem:/run/shm -b /proc -b /sys -r . -0 -l --sysvipc /bin/su -l $1' >> /pinit
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
cd /build
git clone https://github.com/naver/d2codingfont
git clone https://github.com/ohmyzsh/ohmyzsh
mkdir /home/user/.fonts
unzip d2codingfont/D2Coding-Ver1.3.2*.zip
cp D2Coding/*.ttf /home/user/.fonts
fc-cache
echo 'set nocp number autoindent tabstop=2 shiftwidth=2 expandtab printheader=""' > /home/user/.vimrc
echo 'default password: adduse.r/psw.d/' > /home/user/passinfo
echo 'default vnc password: adusr.wd' >> /home/user/passinfo
echo 'CHANGE default password for security' >> /home/user/passinfo
chown -R user /home/user
chmod -R 755 /build/ohmyzsh
sed -i 's,^.*zsh -l$,#&,' /build/ohmyzsh/tools/install.sh
su -c "sh /build/ohmyzsh/tools/install.sh" user
cat /home/user/.zshrc.1 >> /home/user/.zshrc
sed -ir "$(cat /home/user/.zshrc | grep -n ^ZSH_THEME | head -n1 | cut -d: -f-1)"'s,=.*\?$,="agnoster",' /home/user/.zshrc
chown -R user /home/user
exit
