whitelist ~/.local/share/firejail/listenmoe

mkdir ~/.config/listen.moe-desktop-app
whitelist ~/.config/listen.moe-desktop-app

# TODO: Allow only MPRIS socket
ignore dbus-user none
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/electron.inc
