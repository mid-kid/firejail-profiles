#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ida76}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

version_python=3.10.0

download() {
    url="$1"
    fname="${2:-$(basename "$url")}"
    if [ ! -e "$fname" ]; then
        wget -O "$fname" "$url"
    fi
}

fetch() {
    mkdir -p "$prefix"
    cd "$prefix"

    download "https://www.python.org/ftp/python/$version_python/python-$version_python-amd64.exe"
}

setup() {
    if [ ! -f "$prefix/ida76sp1.7z" ]; then
        echo "ERROR: Please copy the IDA archive to '$prefix/ida76sp1.7z' and run this again"
        exit 1
    fi
    cd "$prefix"

    winecfg

    winecfg -v win10
    wine "python-$version_python-amd64.exe" /passive InstallAllUsers=1 PrependPath=1
    rm "python-$version_python-amd64.exe"

    7z x ida76sp1.7z
    rm ida76sp1.7z
    mkdir -p "$WINEPREFIX/drive_c/Program Files"
    mv -v ida76sp1 "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.6"

    wine "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.6/idapyswitch.exe" -a
    wine cmd /c reg delete 'HKCU\Software\Hex-Rays\IDA' /v Python3TargetDLL /f
}

run() {
    cd "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.6"
    exec wine "ida${1:-}.exe"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/drive_c/Program Files/IDA Pro 7.6" ]; then
    fetch
    setup
fi
run "$@"
