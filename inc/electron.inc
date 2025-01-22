# vim:ft=firejail

# Sane set of exposed files for electron
# From /etc/firejail/discord-common.profile
private-bin bash,cut,echo,egrep,fish,grep,head,sed,sh,tclsh,tr,xdg-mime,xdg-open,zsh
private-etc alternatives,ca-certificates,crypto-policies,fonts,group,ld.so.cache,localtime,login.defs,machine-id,password,pki,pulse,resolv.conf,ssl

seccomp !chroot
ignore no3d
ignore net none
protocol unix,inet,inet6,netlink
include ~/.config/firejail/inc/default.inc
