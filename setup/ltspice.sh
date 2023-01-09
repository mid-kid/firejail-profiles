#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ltspice}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://ltspice.analog.com/software/LTspice64.exe'
    winecfg
    exec wine "$tmp/LTspice64.exe"
}

run() {
    exec wine "C:\\windows\\command\\start.exe" /Unix "$WINEPREFIX/dosdevices/c:/users/$USER/AppData/Roaming/Microsoft/Windows/Start Menu/LTspice XVII.lnk" "$@"
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
