#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"
config="${XDG_CONFIG_HOME:-$HOME/.config}/discord"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget -O discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
    tar xf discord.tar.gz
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/discord"

    # I use this to send images
    mkdir -p "$prefix/send"
}

asar() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar'
    for x in "$config"/app-*; do
        cp app.asar "$x/resources/app.asar"
    done
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
        exec apulse ./discord "$@"
    else
        exec ./discord "$@"
    fi
}

case "$1" in
    fetch) shift; fetch; exit ;;
    asar) shift; asar "$@"; exit ;;
    better) shift; better "$@"; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/discord" ]; then
    fetch
fi
run "$@"
