#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/stm32cubemx}"

version=661

# Set to whatever you've set your user's -Djava.util.prefs.userRoot to...
JAVA_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/java"

fetch() {
    tmp=$(mktemp -d -p /var/tmp)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://sw-center.st.com/packs/resource/library/stm32cube_mx_v$version-lin.zip"
    unzip "stm32cube_mx_v$version-lin.zip"
    mkdir -p "$prefix"
    mv -T MX "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/stm32cubemx"
    ln -sf "$XDG_DATA_HOME/stm32cubemx" "$HOME/.stm32cubemx"
    mkdir -p "$XDG_DATA_HOME/stm32cubemx/data"
    ln -sf "$XDG_DATA_HOME/stm32cubemx/data" "$HOME/STM32Cube"
    mkdir -p "$XDG_DATA_HOME/stm32cubemx/java_prefs" "$JAVA_ROOT/.java"
    ln -sf "$XDG_DATA_HOME/stm32cubemx/java_prefs" "$JAVA_ROOT/.java/.userPrefs"

    cd "$prefix"
    exec java -jar STM32CubeMX "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/STM32CubeMX" ]; then
    fetch
fi
run "$@"
