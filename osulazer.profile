whitelist ~/.local/share/firejail/osulazer

mkdir ~/.local/share/osu
whitelist ~/.local/share/osu

# firefox sandbox ecaping (ease of downloading songs)...
noblacklist ~/.mozilla
whitelist ~/.mozilla

ignore net none
ignore no3d
ignore nosound
# TODO: What syscalls?
ignore seccomp
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/default.inc
