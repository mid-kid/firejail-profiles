#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/teams}"

version=1.5.00.10453

# Libsecret install:
# git clone -b 0.20.5 --depth=1 https://gitlab.gnome.org/GNOME/libsecret libsecret-src
# meson -Dvapi=false -Dgtk_doc=false _build

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_${version}_amd64.deb"
    ar x "teams_${version}_amd64.deb"
    tar xf data.tar.xz
    mkdir -p "$prefix"
    mv usr "$prefix"
}

run() {
    cd "$prefix"
    LD_LIBRARY_PATH="$PWD/libsecret:$LD_LIBRARY_PATH" exec sh -x ./usr/bin/teams "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/usr/bin/teams" ]; then
    fetch
fi
run "$@"
