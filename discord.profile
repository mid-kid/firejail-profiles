whitelist ~/.local/share/firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

# BetterDiscord
mkdir ~/.config/BetterDiscord
whitelist ~/.config/BetterDiscord

# BetterDiscord installer
#private-bin mktemp,wget,rm,chmod,readlink,dirname

ignore novideo
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/fcitx.inc
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/electron.inc
