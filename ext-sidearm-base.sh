#!/bin/sh
#prerequisites:
#user 'sidearmconnect'(without password)
#add password customization for additional security
#usage: [script path] [password extension] [hostkey(private)]
mkdir /home/sidearmconnect
chmod -R 755 /home/sidearmconnect
rm /sacsshhkey/key
rm /sacsshpkey/key
echo 'GoPythonFlutter/%025%'"$1"'
GoPythonFlutter/%025%'"$1" | passwd sidearmconnect
mkdir /sacsshhkey /sacsshpkey /sacfwdkey /home/sidearmconnect/sacsshckey /home/sidearmconnect/rcvdest /home/sidearmconnect/.ssh
chmod 0666 /sacfwdkey
ln -sf "$(pwd | sed s,/$,,)"/"$2" /sacsshhkey/key
ln -sf "$(pwd | sed s,/$,,)"/"$2".pub /sacsshpkey/key
ln -sf /utils/sasshsvl /home/sidearmconnect/listen
ln -sf /utils/sasshsvl /bin/saclisten
chown -R sidearmconnect /home/sidearmconnect
chown sidearmconnect /bin/saclisten
chmod 744 /bin/saclisten
sed -i "$(cat /etc/sudoers | grep -n 'root\s\{1,\}ALL' | head -n1 | cut -d: -f-1)"a"sidearmconnect ALL=(ALL:ALL) ALL" /etc/sudoers
