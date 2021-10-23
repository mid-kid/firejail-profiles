#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/arduino}"

version=1.8.16

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://downloads.arduino.cc/arduino-$version-linux64.tar.xz"
    tar xf "arduino-$version-linux64.tar.xz"
    mkdir -p "$prefix"
    mv -T "arduino-$version" "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/arduino"
    ln -sf "$XDG_DATA_HOME/arduino" "$HOME/.arduino15"
    mkdir -p "$XDG_DATA_HOME/arduino/jssc"
    ln -sf "$XDG_DATA_HOME/arduino/jssc" "$HOME/.jssc"

    cd "$prefix"
    exec ./arduino "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/arduino" ]; then
    fetch
fi
run "$@"
