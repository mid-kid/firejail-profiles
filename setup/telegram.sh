#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/telegram}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://updates.tdesktop.com/tlinux/tsetup.1.6.7.tar.xz'
    tar xf 'tsetup.1.6.7.tar.xz'
    mkdir -p "$prefix"
    mv Telegram/* "$prefix"
}

run() {
    cd "$prefix"
    ./Telegram "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Telegram" ]; then
    setup
fi
run "$@"