whitelist ~/.local/share/firejail/jetbrains

mkdir ~/.local/share/JetBrains
noblacklist ~/.local/share/JetBrains
whitelist ~/.local/share/JetBrains

mkdir ~/.config/JetBrains
noblacklist ~/.config/JetBrains/CLion*
whitelist ~/.config/JetBrains

mkdir ~/.cache/JetBrains
noblacklist ~/.cache/JetBrains/CLion*
whitelist ~/.cache/JetBrains

noblacklist ~/.config/Google
whitelist ~/.cache/Google
whitelist ~/.config/Google
whitelist ~/.local/share/Google

whitelist ~/.config/ideavim

whitelist ~/Stuff/Workspace/JetBrains

ignore net none
ignore private-cache
ignore include disable-devel.inc
ignore include disable-interpreters.inc
include ~/.config/firejail/inc/libappindicator.inc
include ~/.config/firejail/inc/default.inc
