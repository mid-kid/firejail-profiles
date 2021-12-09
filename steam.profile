whitelist ~/.local/share/firejail/steam

mkdir ~/.local/share/Steam
noblacklist ~/.local/share/Steam
whitelist ~/.local/share/Steam
mkdir ~/.steam
noblacklist ~/.steam
whitelist ~/.steam

# Random games that use different folders
whitelist ~/.local/share/Daedalic Entertainment
whitelist ~/.config/unity3d
# Stardew Valley
whitelist ~/.config/StardewValley
# Magicka 2 (link from ~/.bitsquid)
whitelist ~/.config/bitsquid

# Needs /sbin/ldconfig...
noblacklist /sbin

# Game controllers...
ignore private-dev

protocol unix,inet,inet6,netlink
ignore net none
ignore no3d
ignore seccomp
ignore noinput
include allow-python3.inc
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/libappindicator.inc
include ~/.config/firejail/inc/default.inc
