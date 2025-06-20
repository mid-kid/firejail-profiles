#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/signal}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    version_url="https://updates.signal.org/desktop/apt/dists/xenial/main/binary-amd64/Packages.gz"
    version=$(curl "$version_url" | zcat | sed -n '/~beta/d;s/^Version: //p' | head -n1)

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
