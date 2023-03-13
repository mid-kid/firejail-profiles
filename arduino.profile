whitelist ~/.local/share/firejail/arduino

mkdir ~/.local/share/arduino-ide
whitelist ~/.local/share/arduino-ide
mkdir ~/.config/arduino-ide
whitelist ~/.config/arduino-ide

whitelist ~/Stuff/Workspace/Arduino/*

ignore noroot
ignore private-dev
ignore private-bin
ignore private-etc
include ~/.config/firejail/inc/electron.inc
