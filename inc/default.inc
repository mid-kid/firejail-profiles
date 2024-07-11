whitelist ~/.Xdefaults
whitelist ~/.config/Trolltech.conf
whitelist ~/.config/gtk-2.0/gtkrc
whitelist ~/.config/gtk-3.0/gtk.css
whitelist ~/.config/gtk-3.0/settings.ini
whitelist ~/.config/qt5ct
whitelist ~/.gtkrc-2.0
whitelist ~/.icons
whitelist ~/.themes
whitelist ~/.asoundrc
read-only ~/.Xdefaults
read-only ~/.config/Trolltech.conf
read-only ~/.config/gtk-2.0/gtkrc
read-only ~/.config/gtk-3.0/gtk.css
read-only ~/.config/gtk-3.0/settings.ini
read-only ~/.config/qt5ct
read-only ~/.gtkrc-2.0
read-only ~/.icons
read-only ~/.themes
read-only ~/.asoundrc

include disable-common.inc
include disable-devel.inc
#include disable-exec.inc
#include disable-interpreters.inc
include disable-proc.inc
include disable-programs.inc
#include disable-shell.inc
include disable-write-mnt.inc
#include disable-X11.inc
include disable-xdg.inc

#apparmor
caps.drop all
ipc-namespace
machine-id
net none
netfilter
no3d
nodvd
#nogroups
noinput
nonewprivs
noroot
nosound
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp
#shell none
#tracelog

disable-mnt
private-cache
private-dev
private-opt none
private-tmp

dbus-user none
dbus-system none

blacklist /boot
blacklist /etc/gentoo-release
blacklist /etc/lsb-release
blacklist /etc/os-release
blacklist /etc/portage
blacklist /usr/lib/os-release
blacklist /usr/local
blacklist /usr/portage
blacklist /usr/src
blacklist /usr/tmp

whitelist /var/run
whitelist /run/firejail
blacklist ${RUNUSER}
