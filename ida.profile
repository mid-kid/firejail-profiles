whitelist ~/.local/share/firejail/ida

whitelist ~/Stuff/Workspace/IDA
whitelist ~/Stuff/Workspace/hackthebox

# IDA seems to hate some fonts
blacklist /usr/share/fonts

include ~/.config/firejail/inc/wine.inc
