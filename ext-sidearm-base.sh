#!/bin/sh
#prerequisites:
#user 'sidearmconnect'(without password)
#add password customization for additional security
#usage: [script path] [password extension] [hostkey(private)]
echo 'GoPythonFlutter/%025%'"$1"'
GoPythonFlutter/%025%'"$1" | passwd sidearmconnect
mkdir /sacsshhkey /sacsshpkey
ln -sf "$2" /sacsshhkey/key
ln -sf "$2".pub /sacsshpkey/key
ln -sf /utils/sasshsvl /home/sidearmconnect/listen
ln -sf /utils/sasshsvl /bin/saclisten
chown -R sidearmconnect /home/sidearmconnect
chown sidearmconnect /bin/saclisten
chmod 744 /bin/saclisten
sed -i "$(cat /etc/sudoers | grep -n 'root\s\{1,\}ALL' | head -n1 | cut -d: -f-1)"a"sidearmconnect ALL=(ALL:ALL) ALL" /etc/sudoers
