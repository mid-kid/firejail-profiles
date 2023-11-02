#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/arduino}"

version=2.1.1

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://downloads.arduino.cc/arduino-ide/arduino-ide_${version}_Linux_64bit.zip"
    mkdir -p "$prefix"
    unzip -d "$prefix" "arduino-ide_${version}_Linux_64bit.zip"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/arduino-ide"
    ln -sf "$XDG_DATA_HOME/arduino-ide" "$HOME/.arduino15"

    cd "$prefix"
    export LD_LIBRARY_PATH="$PWD/libsecret:$LD_LIBRARY_PATH"
    exec ./arduino-ide "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/arduino-ide" ]; then
    fetch
fi
run "$@"
