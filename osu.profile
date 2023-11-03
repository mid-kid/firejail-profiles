whitelist ~/.local/share/firejail/osu

# Useful for setup
ignore private-cache
noblacklist ~/.cache/winetricks
whitelist ~/.cache/winetricks

ignore net none
ignore no3d
ignore nosound
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/firefox-escape.inc
include ~/.config/firejail/inc/wine.inc
