#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/steam}"

# To launch in offline mode:
# Set "WantsOfflineMode" "1" in ~/.steam/steam/config/loginusers.vdf

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://repo.steampowered.com/steam/archive/precise/steam_latest.tar.gz'
    tar xf 'steam_latest.tar.gz'
    mkdir -p "$prefix"
    mv steam-launcher/* "$prefix"
}

run() {
    cd "$prefix"
    export PROTON_USE_WINED3D=1
    exec ./steam "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -e "$prefix/steam" ]; then
    fetch
fi
run "$@"
