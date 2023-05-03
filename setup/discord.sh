#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"

version=0.0.27

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget "https://dl.discordapp.net/apps/linux/$version/discord-$version.tar.gz"
    tar xf "discord-$version.tar.gz"
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/Discord"

    # I use this to send images
    mkdir -p "$prefix/send"
}

asar() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar'
    mv app.asar "$prefix/resources/app.asar"
}

better() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage'
    chmod +x BetterDiscord-Linux.AppImage
    ./BetterDiscord-Linux.AppImage --appimage-extract
    "$PWD/squashfs-root/AppRun" "$@"
}

run() {
    cd "$prefix"
    if command -v apulse > /dev/null 2> /dev/null; then
        exec apulse ./Discord "$@"
    else
        exec ./Discord "$@"
    fi
}

case "$1" in
    fetch) shift; fetch; exit ;;
    asar) shift; asar "$@"; exit ;;
    better) shift; better "$@"; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Discord" ]; then
    fetch
fi
run "$@"
