whitelist ~/.local/share/firejail/jetbrains

noblacklist ~/.local/share/JetBrains
noblacklist ~/.config/JetBrains/CLion*
noblacklist ~/.config/JetBrains/PyCharm*
noblacklist ~/.cache/JetBrains/CLion*
noblacklist ~/.cache/JetBrains/PyCharm*

mkdir ~/.local/share/JetBrains
whitelist ~/.local/share/JetBrains

mkdir ~/.config/JetBrains
whitelist ~/.config/JetBrains

mkdir ~/.cache/JetBrains
whitelist ~/.cache/JetBrains

whitelist ~/.config/ideavim

whitelist ~/Stuff/Workspace/JetBrains/*

ignore private-cache
seccomp !chroot
noblacklist /etc/lsb-release
noblacklist /etc/os-release
noblacklist /usr/lib/os-release
noblacklist /proc/sys/fs
noblacklist /proc/sys/*/*
include ~/.config/firejail/inc/default.inc
