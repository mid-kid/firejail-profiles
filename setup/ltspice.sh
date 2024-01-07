#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ltspice}"

export WINEARCH=win64
export WINEPREFIX="$prefix"
export WINEDLLOVERRIDES='mscoree,mshtml='

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://ltspice.analog.com/software/LTspice64.msi'
    winecfg
    wine "$tmp/LTspice64.msi"

    # Cleanup unnecessary files
    rm -r "$prefix/drive_c/windows/Installer"
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
