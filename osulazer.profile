whitelist ~/.local/share/firejail/osulazer

mkdir ~/.local/share/osu
whitelist ~/.local/share/osu

ignore net none
ignore no3d
ignore nosound
# TODO: What syscalls?
ignore seccomp
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/firefox-escape.inc
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/default.inc
