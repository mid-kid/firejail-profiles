#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/teams}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.7556_amd64.deb'
    ar x 'teams_1.4.00.7556_amd64.deb'
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
