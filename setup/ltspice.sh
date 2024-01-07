#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ltspice}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://ltspice.analog.com/software/LTspice64.msi'
    winecfg
    exec wine "$tmp/LTspice64.msi"
}

run() {
    exec wine "C:\\users\\mid-kid\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\LTspice\\LTspice.lnk" "$@"
}

case "$1" in
    fetch) exit ;;  # Installation requires download
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/drive_c" ]; then
    setup
else
    run "$@"
fi
