#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ghidra}"

version=10.2.2
version_full="${version}_PUBLIC_20221115"

fetch() {
    tmp=$(mktemp -d -p /var/tmp)  # This package is huge
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${version}_build/ghidra_$version_full.zip"
    unzip "ghidra_$version_full.zip"
    mkdir -p "$prefix"
    mv -T "ghidra_${version}_PUBLIC" "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/ghidra"
    ln -sfT "$XDG_DATA_HOME/ghidra" "$HOME/.ghidra"

    cd "$prefix"
    exec ./ghidraRun "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -e "$prefix/ghidraRun" ]; then
    fetch
fi
run "$@"
