whitelist ~/.local/share/firejail/discord

mkdir ~/.config/discord
noblacklist ~/.config/discord
whitelist ~/.config/discord

# betterdiscord
#mkdir ~/.local/share/betterdiscordctl
#whitelist ~/.local/share/betterdiscordctl
#mkdir ~/.config/BetterDiscord
#whitelist ~/.config/BetterDiscord

ignore novideo
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/fcitx.inc
include ~/.config/firejail/inc/discord-ipc.inc
include ~/.config/firejail/inc/electron.inc
