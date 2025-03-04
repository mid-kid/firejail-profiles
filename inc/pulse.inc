# vim:ft=firejail

ignore nosound
noblacklist ${RUNUSER}
whitelist ${RUNUSER}/pulse/native
whitelist ${RUNUSER}/pipewire-?
