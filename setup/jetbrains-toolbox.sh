#!/bin/sh
# appimage=~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox
set -e

prefix="${prefix:-$HOME/.local/opt/jetbrains}"

version=1.25.12569

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://download.jetbrains.com/toolbox/jetbrains-toolbox-$version.tar.gz"
    tar xf "jetbrains-toolbox-$version.tar.gz"

    mkdir -p "$XDG_DATA_HOME/JetBrains/Toolbox/bin"
    mv "jetbrains-toolbox-$version/jetbrains-toolbox" "$XDG_DATA_HOME/JetBrains/Toolbox/bin/jetbrains-toolbox"

    toolboxrc="$XDG_CONFIG_HOME/JetBrains/Toolbox/toolboxrc"
    if [ ! -f "$toolboxrc" ]; then
        mkdir -p "$(dirname "$toolboxrc")"
cat > "$toolboxrc" << 'EOF'
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Set to whatever you've set your user's -Djava.util.prefs.userRoot to...
JAVA_ROOT="$XDG_CONFIG_HOME/java"

mkdir -p "$XDG_DATA_HOME/JetBrains/java_prefs" "$JAVA_ROOT/.java/.userPrefs"
ln -sf "$XDG_DATA_HOME/JetBrains/java_prefs" "$JAVA_ROOT/.java/.userPrefs/jetbrains"

eval $(dbus-launch)
export DBUS_SESSION_BUS_ADDRESS
./$app "$@"
kill $DBUS_SESSION_BUS_PID
exit
EOF
    fi
}

# NOTE: the "appimage=" line at the top of the file overrides everything else here...

setup() {
    # Inside sandbox
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    "$XDG_DATA_HOME/JetBrains/Toolbox/bin/jetbrains-toolbox" --appimage-extract
    mkdir -p "$prefix"
    rm -rf "$prefix"/*
    mv squashfs-root/* "$prefix"
}

run() {
    cd "$prefix"
    export APPDIR="$PWD"
    export APPIMAGE="$XDG_DATA_HOME/JetBrains/Toolbox/bin/jetbrains-toolbox"
    unset DBUS_SESSION_BUS_ADDRESS
    ./AppRun "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$XDG_DATA_HOME/JetBrains/Toolbox/bin/jetbrains-toolbox" ]; then
    fetch
fi
if [ ! -f "$prefix/jetbrains-toolbox" ]; then
    setup
fi
run "$@"
