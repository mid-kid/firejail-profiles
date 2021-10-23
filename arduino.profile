whitelist ~/.local/share/firejail/arduino

mkdir ~/.local/share/arduino
noblacklist ~/.local/share/arduino
whitelist ~/.local/share/arduino

whitelist ~/Stuff/Workspace/Arduino

ignore noroot
ignore private-dev
ignore net none
include ~/.config/firejail/inc/default.inc
