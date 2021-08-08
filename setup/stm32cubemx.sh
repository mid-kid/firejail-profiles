#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/stm32cubemx}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://sw-center.st.com/packs/resource/library/stm32cube_mx_v621-lin.zip'
    unzip 'stm32cube_mx_v621-lin.zip'
    mkdir -p "$prefix"
    mv -T MX "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/stm32cubemx"
    ln -sf "$XDG_DATA_HOME/stm32cubemx" "$HOME/.stm32cubemx"
    mkdir -p "$XDG_DATA_HOME/stm32cubemx/java_prefs" "$HOME/.java/.userPrefs/com"
    ln -sf "$XDG_DATA_HOME/stm32cubemx/java_prefs" "$HOME/.java/.userPrefs/com/st"

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
