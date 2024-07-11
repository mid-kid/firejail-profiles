whitelist ~/.local/share/firejail/steam

mkdir ~/.local/share/Steam
noblacklist ~/.local/share/Steam
whitelist ~/.local/share/Steam
mkdir ~/.steam
noblacklist ~/.steam
whitelist ~/.steam

# Random games that use different folders
whitelist ~/.local/share/Daedalic Entertainment
whitelist ~/.config/unity3d
# Stardew Valley
whitelist ~/.config/StardewValley
# Magicka 2 (link from ~/.bitsquid)
whitelist ~/.config/bitsquid
# Stellaris
whitelist ~/.config/paradox-launcher-v2
whitelist ~/.local/share/Paradox Interactive

# Game controllers...
ignore private-dev

# Steam needs to sandbox itself as well...
#ignore seccomp
seccomp !chroot,!mount,!name_to_handle_at,!pivot_root,!ptrace,!umount2
seccomp.32 !process_vm_readv
noblacklist /proc/sys/kernel/overflowuid
noblacklist /proc/sys/kernel/overflowgid

# It needs /sbin/ldconfig...
noblacklist /sbin

protocol unix,inet,inet6,netlink
ignore net none
ignore no3d
ignore noinput
include ~/.config/firejail/inc/pulse.inc
include ~/.config/firejail/inc/libappindicator.inc
include ~/.config/firejail/inc/default.inc
