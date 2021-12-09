whitelist ~/.icons
whitelist ~/.themes
whitelist ~/.gtkrc-2.0
whitelist ~/.config/gtk-2.0/gtkrc
whitelist ~/.config/gtk-3.0/gtk.css
whitelist ~/.config/gtk-3.0/settings.ini
whitelist ~/.config/Trolltech.conf
whitelist ~/.config/qt5ct
read-only ~/.icons
read-only ~/.themes
read-only ~/.gtkrc-2.0
read-only ~/.config/gtk-2.0/gtkrc
read-only ~/.config/gtk-3.0/gtk.css
read-only ~/.config/gtk-3.0/settings.ini
read-only ~/.config/Trolltech.conf
read-only ~/.config/qt5ct

#apparmor
caps.drop all
ipc-namespace
#machine-id
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
blacklist /usr/local
blacklist /usr/portage
blacklist /usr/src
blacklist /usr/tmp
blacklist /var/cache/edb
blacklist /var/cache/eix
blacklist /var/db
blacklist /var/lib/bluetooth
blacklist /var/lib/dhcpcd
blacklist /var/lib/gentoo
blacklist /var/lib/misc
blacklist /var/lib/portage
blacklist /var/lib/sddm
blacklist ${RUNUSER}

include disable-common.inc
include disable-devel.inc
#include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
#include disable-shell.inc
include disable-write-mnt.inc
include disable-xdg.inc
