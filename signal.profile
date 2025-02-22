whitelist ~/.local/share/firejail/signal

noblacklist ~/.config/Signal
mkdir ~/.config/Signal
whitelist ~/.config/Signal

include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/electron.inc
