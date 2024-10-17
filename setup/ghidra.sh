#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ghidra}"

version=11.2
version_full="${version}_PUBLIC_20240926"

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
