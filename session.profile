whitelist ~/.local/share/firejail/session

mkdir ~/.config/Session
whitelist ~/.config/Session

ignore novideo
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/libappindicator.inc
include ~/.config/firejail/inc/electron.inc
