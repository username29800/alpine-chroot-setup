#!/bin/sh
cd /build
apk search mate | grep \^mate | grep -v ^materia | sed 's,[-_]\d.*,,' > list
sed -i 's,^.*$,apk add &,' list
sed -i 's,^.*-lang$,,' list
sed -i 's,^.*-doc$,,' list
sed -i 's,^.*-dev$,,' list
chmod 755 list
./list
echo "#\!/bin/sh" > /build/mate-config
echo "vncserver :100 /dev/null 2>&1 &" >> /build/mate-config
echo "export DISPLAY=:100" >> /build/mate-config
echo "gsettings set org.mate.interface font-name 'Noto Sans CJK KR 11'" >> /build/mate-config
echo "gsettings set org.mate.interface document-font-name 'Noto Sans CJK KR 11'" >> /build/mate-config
echo "gsettings set org.mate.interface monospace-font-name 'D2Coding 12'" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/font \"'D2Coding 12'\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/use-system-font \"false\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/use-theme-colors \"false\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/foreground-color \"'#FFFFFFFFFFFF'\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/background-color \"'#000000000000'\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/background-type \"'transparent'\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/background-darkness \"0.66\"" >> /build/mate-config
echo dconf write "/org/mate/terminal/profiles/default/palette \"'#000000000000:#CCCC00000000:#4E4D9A9A0605:#C4C3A0A00000:#34346564A4A3:#7575504F7B7B:#060598979A9A:#D3D3D7D6CFCF:#555457565352:#EFEF29282928:#8A89E2E23434:#FCFBE9E84F4F:#72729F9ECFCF:#ADAC7F7EA8A8:#3434E2E2E2E2:#EEEDEEEDECEB'\"" >> /build/mate-config
echo "gsettings set org.mate.Marco.general theme 'Menta'" >> /build/mate-config
echo "gsettings set org.mate.Marco.general titlebar-uses-system-font 'false'" >> /build/mate-config
echo "gsettings set org.mate.Marco.general titlebar-font 'Noto Sans CJK KR 11'" >> /build/mate-config
echo "kill %1" >> /build/mate-config
chmod 755 /build/mate-config
su -lc 'dbus-launch sh /build/mate-config' user
echo "#\!/bin/sh" > /home/user/theme
echo 'safefox https://www.pling.com/p/1267246/ &' >> /home/user/theme
echo 'safefox https://www.pling.com/p/1598493/ &' >> /home/user/theme
sed -i 's,^openbox \?.*\?,mate-session,' /home/user/.config/tigervnc/xstartup