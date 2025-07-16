# alpine-chroot-setup
A setup and config automation for alpine linux minirootfs. With Bring-Your-Own-Rootfs method.

# Alpine MATE Desktop Setup Script

This is an automated shell script to set up a **full-featured Alpine Linux desktop** environment using the **MATE** desktop and **TigerVNC**, designed for lightweight remote or local use.

It includes theming, fonts, developer tools, and CJK input support via ibus. Perfect for quickly bootstrapping a minimal Alpine system into a usable desktop with one command.

---

## Features

- Installs MATE desktop environment on Alpine Linux  
- TigerVNC server configuration with user xstartup script  
- Dark theme + Faenza/MATE icons compatible  
- IBus + ibus-hangul (Korean input method)  
- Noto fonts (CJK + Emoji)  
- D2Coding font (for developers)  
- Oh-My-Zsh with agnoster theme  
- Firefox with VNC-safe launch wrapper  
- Pulseaudio server for remote audio  
- Development toolchain (gcc, clang, make, cmake, python, perl, etc.)  
- Automatic configuration for environment variables, sudoers, VNC  

---

## Usage

**NOTE:** This is intended for running in both proot and chroot environment.

1. Make sure your Alpine base is installed (e.g. from `alpine-minirootfs`). This can be downloaded from alpine linux official homepage.  
2. Place this script (e.g. `setup.sh`) in your Alpine root filesystem.
3. Make it executable by 'chmod +x setup.sh' or (if you've done chroot) just run it using 'sh setup.sh'.
4. Chroot(or proot) into the new root.
5. Run as root: ./setup.sh

---

## After Install

= User user is created.

- Password needs to be set manually when prompted. (the script prompts for VNC password too, which can be different from user's password)

- To launch VNC server:

```bash
vncserver :[port]
(usually :1, :2, or :5901, :5902, etc.)
```

- Connect with VNC viewer to see the desktop.

- To login as 'user' to start using the desktop experience, press Ctrl-d to exit, then
```bash
$ ./pinit [user]
for proot

\# ./cinit [user]
for chroot (with root previleges)

$ ./sndsrv
make sure to run this before chroot/prrot for better sound experiences
```

---

## File Structure

- /home/user/.config/tigervnc/xstartup: Custom xstartup launching MATE session

- /bin/safefox: Wrapper to launch Firefox with no sandbox errors on termux + proot environment.

- /home/user/theme: Opens theme download pages in Firefox

- /sndsrv: Pulseaudio TCP server launcher

- /pinit, /cinit: Proot/chroot helper scripts

---

## Customization

- Easy to add or remove packages in the script (apk add lines).

- Theme links can be edited in /home/user/theme to suit your taste.

- Fonts installed in /home/user/.fonts (including D2Coding).

- Oh-My-Zsh with agnoster theme enabled for user shell.

---

## Notes

- Pulseaudio is set to allow local TCP connections. (without authorization)

- Firefox runs with MOZ_FAKE_NO_SANDBOX=1 to work under proot or other nonroot environment. (This can be done conveniently using /bin/safefox)

- Script disables installation of -dev, -doc, and -lang subpackages to save space.

- Works well in Proot/Termux and chroot.

---

Screenshot Example

- Will be added someday.

---

License

Feel free to copy, modify, and share. No warranty.
