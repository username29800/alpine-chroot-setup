#!/bin/sh
#run inside chroot/proot as root
echo installing base packages
sleep .5
/pkg-alpine-cqgw.sh
echo .
echo adding default users
sleep .5
adduser -D user
adduser -D sidearmconnect
echo .
echo configuring system
sleep .5
/sysind.sh
echo .
echo installing and configuring linux-sidearm extension
sleep .5
mkdir /root/.ssh
ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa
/ext-sidearm-base.sh '' /root/.ssh/id_rsa
echo .
echo installing recommended editors
sleep .5
/ext-alpine-editors.sh
echo .
echo installing mate desktop environment
sleep .5
/ext-alpine-mate-desktop.sh
echo .
echo Congratulations. Installation complete!
echo Now you can explore your brand new alpine-chroot environment
echo .
echo --quick guide/getting started--
echo Features provided out-of-the-box:
echo '1. You can quickly log in as a specific user using "./pinit [username]" . If you want to use chroot, use ./cinit [username].'
echo NOTE: It is currently unable to make any proot container work in chroot environment, due to link2symlink limitations. Proot is recommended for portable environment.
echo '2. Recommended editors are preinstalled - vim(with a little configuration), ed, microemacs(em), MicroGnuEmacs(mg), micro, midnight commander(which provides its own editor), libreoffice writer'
echo '3. Development-Ready: gcc and other compilers are installed by default, as well as some basic build tools like autoconf, automake, aclocal(m4). * Cmake not included.'
echo '3. There are lots of automation/workaround scripts for convenience.'
echo '  - scripts in path(/bin):'
echo '    showw: shows the list of currently open windows (uses rofi)'
echo '    sdclock: shows xclock, digital (xclock should be installed manually)'
echo '    safefox: firefox with sandbox workaround (works great with termux/proot environment)'
echo '    tlch (or tlaunch/twrapper): launches tor with provided configuration file /afconf/trc'
echo '  '
echo '  - scripts elsewhere:'
echo '    /utils: contains utility and sidearm-connect scripts'
echo '      netcon [interface]: automatically connects to wired networks. Wireless ones need extra configuration using either [wpa-supplicant] or [iwd].'
echo '      swsh [user] [old shell path] [new shell path]: chsh replacement (since chsh is not available)'
echo '      shocks [user] [port] / dshocks [user]: enables/disables socks5 proxy configured for [port]. Use with tlch. Zsh and Bash is supported. (sh not supported)'
echo '        NOTE: This configures a shell-only proxy, thus other softwares(e.g. firefox) still needs to be configured to use socks5 proxy.'
echo '      sidearm-connect scripts(sac): type /utils/[script filename] to execute'
echo '        sacrunsshd [port]: launches sshd on port with hostkey /sacsshhkey/key . /bin/saclisten [port] is also available.'
echo '        sacsendkey [host] [port] [key identifier(any int)]: transfers public key(/sacsshpkey/key) to local or remote host via scp. Password for user "sidearmconnect" required. receiver must have user "sidearmconnect" and sidearm-connect extension installed(this can be installed on any ssh/passwd/adduser capable linux/unix environment.) See /ext-sidearm-base.sh to find the default password for sidearmconnect.'
echo '        sacsendf [host] [port] [local source] [filename]: sends a file to local/remote host via scp. Password not required if pubkey authentication is working. received file is saved in /home/sidearmconnect/rcvdest/[filename] .'
echo '        sacregkey [key identifier]: adds a key from /home/sidearmconnect/sacsshckey/key[key identifier] to /home/sidearmconnect/.ssh/authorized_keys .'
echo '        sacunregkey [key identifier]: deletes a key from authorized_keys .'
echo '        sacsshcon [host] [port]: connects to local/remote host as user sidearmconnect. Use sudo -u [user] to switch user.'
echo '    /tools: management/rescue scripts'
echo '      fixsudo: no argument required. fixes permission of usr/bin/sudo to make it work again. migrating/copying a container using "cp -r" would break permissions, making sudo broken. This can be fixed by fixsudo(this) or libacl.'
echo '      rewire-(rc | ng | n2) [prefix] [old root] [new root]: corrects the symlink directions associated with link2symlink(l2s) extension. l2s is essential for proot environment, but mostly breaks when the path to root(chroot directory) changes. rewire-n2(latest) is recommended to fix this.'
echo ''
echo '  - other modifications:'
echo '    ibus is preconfigured as default input method. this is configured in .zshrc for user "user".'
echo '    pulseaudio is preconfigured to use workaround. you can run sndsrv outside of your proot environment (in your termux env), then the sound will be available. this is available for user "user".'
echo '    xstartup and desktop session "custom" is preconfigured to launch openbox, and set the screen resolution to 1920x1080.'
echo '    sudo is enabled for user "user" by default.'
echo '    zsh and oh-my-zsh with extensions installed are available by default.'
