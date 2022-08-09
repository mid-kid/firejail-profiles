# TODO: Make seccomp more specific
ignore seccomp
include allow-java.inc
noblacklist ${PATH}/javac
include ~/.config/firejail/inc/default.inc
