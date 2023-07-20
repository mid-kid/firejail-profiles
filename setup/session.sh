#!/bin/sh
# appimage=session-desktop.AppImage
set -e

prefix="${prefix:-$HOME/.local/opt/session}"

version=1.11.0

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://github.com/oxen-io/session-desktop/releases/download/v$version/session-desktop-linux-x86_64-$version.AppImage"

    mkdir -p "$prefix"
    mv -T "session-desktop-linux-x86_64-$version.AppImage" "$prefix/session-desktop.AppImage"
    chmod +x "$prefix/session-desktop.AppImage"
}

run() {
    cd "$prefix"
    exec ./session-desktop.AppImage "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -x "$prefix/session-desktop.AppImage" ]; then
    fetch
fi
run "$@"
