#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/signal}"

# curl https://updates.signal.org/desktop/apt/dists/xenial/main/binary-amd64/Packages.gz | zcat | grep '^Version:' | tac
version=7.43.0

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_${version}_amd64.deb"
    ar x "signal-desktop_${version}_amd64.deb"
    tar xf data.tar.xz
    mkdir -p "$prefix"
    mv opt/Signal/* "$prefix"
}

run() {
    cd "$prefix"
    exec ./signal-desktop "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/signal-desktop" ]; then
    fetch
fi
run "$@"
