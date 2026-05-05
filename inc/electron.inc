# vim:ft=firejail

# Sane set of exposed files for electron
# From /etc/firejail/discord-common.profile
private-bin awk,bash,cut,echo,egrep,electron,electron[0-9],electron[0-9][0-9],env,fish,grep,head,sed,sh,tclsh,tr,which,xdg-mime,xdg-open,zsh
private-etc @tls-ca

seccomp !chroot
ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
