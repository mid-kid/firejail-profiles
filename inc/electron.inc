# vim:ft=firejail

# Sane set of exposed files for electron
# From /etc/firejail/discord-common.profile
private-bin awk,bash,cut,echo,egrep,electron,electron[0-9],electron[0-9][0-9],fish,grep,head,sed,sh,tclsh,tr,which,xdg-mime,xdg-open,zsh
private-etc alternatives,ca-certificates,crypto-policies,fonts,group,ld.so.cache,ld.so.preload,localtime,login.defs,machine-id,password,pki,pulse,resolv.conf,ssl

seccomp !chroot
ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
