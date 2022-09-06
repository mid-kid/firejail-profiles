#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"

version=0.0.18

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget "https://dl.discordapp.net/apps/linux/$version/discord-$version.tar.gz"
    tar xf "discord-$version.tar.gz"
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/Discord"
}

better() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl'
    chmod +x 'betterdiscordctl'
    ./betterdiscordctl -d "$prefix" -m "${XDG_CONFIG_HOME:-$HOME/.config}/discord/$version/modules/" "$@"
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
    better) shift; better "$@"; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Discord" ]; then
    fetch
fi
run "$@"
