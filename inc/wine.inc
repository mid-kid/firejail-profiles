# No idea why literally any "seccomp" option works...
seccomp !chroot
ignore ipc-namespace  # prevents "X Error of failed request:  BadValue (integer parameter out of range for operation)"
include ~/.config/firejail/inc/default.inc
