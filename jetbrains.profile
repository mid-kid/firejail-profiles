whitelist ~/.local/share/firejail/jetbrains

mkdir ~/.local/share/JetBrains
noblacklist ~/.local/share/JetBrains
whitelist ~/.local/share/JetBrains

mkdir ~/.config/JetBrains
noblacklist ~/.config/JetBrains/CLion*
whitelist ~/.config/JetBrains

mkdir ~/.cache/JetBrains
noblacklist ~/.cache/JetBrains/CLion*
whitelist ~/.cache/JetBrains

whitelist ~/.config/ideavim

whitelist ~/Stuff/Workspace/JetBrains/*

#ignore net none
ignore private-cache
ignore include disable-devel.inc
ignore include disable-interpreters.inc
noblacklist /proc/sys/fs
noblacklist /proc/sys/*/*
include ~/.config/firejail/inc/default.inc
