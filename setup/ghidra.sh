#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ghidra}"

fetch() {
    tmp=$(mktemp -d -p /var/tmp)  # This package is huge
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0.1_build/ghidra_10.0.1_PUBLIC_20210708.zip'
    unzip 'ghidra_10.0.1_PUBLIC_20210708.zip'
    mkdir -p "$prefix"
    mv ghidra_10.0.1_PUBLIC/* "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/ghidra"
    ln -sf "$XDG_DATA_HOME/ghidra" "$HOME/.ghidra"

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
