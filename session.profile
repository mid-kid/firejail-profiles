whitelist ~/.local/share/firejail/session

mkdir ~/.config/Session
whitelist ~/.config/Session

include ~/.config/firejail/inc/electron.inc
