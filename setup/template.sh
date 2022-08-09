#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/<>}"

version=<>

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
}

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
}

run() {
    cd "$prefix"
    exec ./<> "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/<>" ]; then
    if [ ! -f "$prefix/<>" ]; then
        fetch
    fi
    setup
else
    run "$@"
fi
