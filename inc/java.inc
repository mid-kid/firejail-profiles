# vim:ft=firejail

seccomp !chroot
include allow-java.inc
noblacklist ${PATH}/javac
include ~/.config/firejail/inc/default.inc
