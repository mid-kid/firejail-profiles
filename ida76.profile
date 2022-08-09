whitelist ~/.local/share/firejail/ida76

whitelist ~/Stuff/Workspace/IDA
whitelist ~/Stuff/Workspace/hackthebox

blacklist /usr/share/fonts

allow-debuggers
include ~/.config/firejail/inc/wine.inc
