Alpine Chroot Setup Kit – Manual

1. Introduction

What is this?

The Alpine Chroot Setup Kit is a collection of shell scripts and utilities designed to simplify and automatize the process of setting up lightweight Linux containers using proot or chroot.
Instead of requiring manual unpacking, configuration, and tuning of an Alpine Linux root filesystem, this setup kit provides ready-made installation and initialization scripts that streamline the entire process.

Its design philosophy is system independence: the same scripts work across multiple environments, whether you are on Android (via Termux), inside an existing Linux terminal, or experimenting on bare-metal.

<Capabilities and Features>

Automated installation: prepare an Alpine Linux rootfs with minimal user interaction. You can build, copy, and produce your chroot/proot container as many as you want.

Unified environment setup: Configure users, passwords, fonts, shells, and startup scripts automatically with sysind.sh.

Init wrappers: Start a container with root (./pinit) or with a user account (./pinit user).

Utility collection: Tools for proxy configuration (shocks), changing login shell (swsh), symlink repair (rewire), and more.

Extensible architecture: Support for additional scripts (pkg-*.sh for base package sets, ext-*.sh for extended environments).

Multi-purpose use cases: Build anything from a minimal Alpine rootfs to a development workstation with editors and compilers.


<What can I do with this?>

The kit enables a wide variety of scenarios, such as:

Linux-on-Android: Run a (virtually) full Alpine Linux environment inside Termux without root. Workarounds are provided to deal with android limitations.

Bare-metal chroot: Repurpose the scripts on desktop or server systems to bootstrap experimental environments.

Container playground: Use proot containers as crude, lightweight sandboxes for testing software.

Remote desktop: Install VNC and configure X11 forwarding for graphical sessions.

Hobbyist exploration: Try creative scripting, or building nested containers just for fun. 
NOTE: Do NOT try dangerous scripts or malware, which can break into the host system.


<Limitations>

Only Alpine Linux is supported (other distributions might be added after a long time.)

While proot provides flexibility, performance may not match native chroot or Docker setups. Furthermore, Dockerfile is currently deprecated and won't work until it gets some updates.

SSH, VNC, and graphical setups require extra configuration and may vary depending on host environment.
>> VNC configuratuon is automated.



---

2. Manual

<Prerequisites>

Before starting, ensure you have:

Host environment: Termux (Android), Linux terminal, or equivalent.

Network access: Stable internet connection.

Storage: At least 1.5 GiB free space.

Installed tools:

git (to clone this repository)

proot (for unprivileged containers)


<System checks>

Verify that LD_PRELOAD is unset (the output of echo $LD_PRELOAD should be empty).

Rootfs: Download a recent Alpine minirootfs tarball beforehand.

Optional: VNC/SSH clients, proxy software, and familiarity with shell scripting.


<Getting Started>

1. Clone the repository:

git clone <repo-url> alpine-chroot-setup
cd alpine-chroot-setup (if this is too long, consider naming it 'alps'.)

The repository root becomes the container root directory.


2. Unpack an Alpine minirootfs tarball inside this directory.


3. Run the base installation script:

./pkg-alpine-base.sh


4. Initialize the system with sysind.sh:

./sysind.sh

This sets up:

-User account user (with password)

-Default shell configuration (zsh + oh-my-zsh)

-Fonts (D2Coding)

-VNC/X11 startup defaults

-Utility scripts in /bin


All installation files are stored under /build/ for later inspection.


5. Enter the container:

As root: ./pinit

As user: ./pinit user


6. For bare-minimum use (e.g., only extracting other rootfs archives), you may skip sysind.sh.



Utilities and Extensions
The repository provides two main categories:

Package scripts (pkg-*.sh)
pkg-alpine-base.sh: Installs base packages and dependencies.
pkg-alpine-min.sh: Minimal package set for lightweight setups.
pkg-alpine-cqgw.sh: Gateway/communication-oriented package set.


Extension scripts (ext-*.sh)
ext-alpine-devel.sh: Adds development toolchains (gcc, clang, cmake, etc.).
ext-alpine-editors.sh: Installs text editors (vim, nano, neovim, code-oss, uemacs, mg, etc.). Some are built from source.


Init and management utilities
pinit: chroot into the container via proot. Root previlege NOT required (./pinit [root or user]).
cinit: Alternative init wrapper. Recommended for bare-metal usage, root previlege required for mounting needed volumes and calling chroot.
initpty: Pseudo-terminal support for chroot(with su/sudo) environment.


Tools (tools/ and utils/)

rewire: Repair broken symlinks (useful when migrating containers).

shocks / dshocks: Automate SOCKS5 proxy setup and teardown.

swsh: Change default shell (chsh equivalent). usage: path/to/swsh [user] [current shell] [new shell]
>> check /etc/passwd before running.

tlch, trc, tzsh: Miscellaneous shell helpers. (tlch: launches tor according to the config file /utils/trc)


Troubleshooting

Script errors: Ensure you are inside the correct directory (the cloned repo root).

Broken symlinks after migration: Use rewire to fix path issues. usage: path/to/rewire [previous chroot directory name] ('name' refers to the deepest directory of the path)

Password/user creation issues: sysind.sh will override and set new passwords; you do not need to create them manually.

Missing commands: Verify you ran pkg-alpine-base.sh before sysind.sh.

VNC/X11 not working: Check that your host supports X11 forwarding or that you installed a VNC server and configured it correctly.

Proot failing with LD_PRELOAD errors: Clear the variable:

unset LD_PRELOAD


Further Development

This project is designed for extension. You can:

Write new pkg-*.sh scripts for custom package bundles.

Add ext-*.sh scripts for specialized environments (e.g., machine learning, web server stacks).

Contribute utilities for smoother integration with SSH, VNC, or Docker.

Experiment with system-independent wrappers (sysind) and distribution-specific tweaks (xfwd-alpine, xfwd-void, etc.).
