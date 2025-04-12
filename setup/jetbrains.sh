#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/jetbrains}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

version_all=2024.3.5

version_clion="$version_all"
downdir_clion=cpp
archive_clion="CLion-$version_clion"
dirname_clion="clion-$version_clion"

version_pycharm="$version_all"
downdir_pycharm=python
archive_pycharm="pycharm-professional-$version_pycharm"
dirname_pycharm="pycharm-$version_pycharm"

version_pycharm_community="$version_pycharm"
downdir_pycharm_community=python
archive_pycharm_community="pycharm-community-$version_pycharm_community"
dirname_pycharm_community="$archive_pycharm_community"

cmd="$1"; shift
name="$1"; shift

if [ -z "$name" ]; then
    echo "Please specify the jetbrains program to run"
    exit 1
fi
eval "version=\${version_$name}"
eval "downdir=\${downdir_$name}"
eval "archive=\${archive_$name}"
eval "dirname=\${dirname_$name}"
if [ -z "$version" ]; then
    echo "Invalid program: $name"
    exit 1
fi

prefix_app="$prefix/$dirname"

# jetbrains complains about this variable...
unset _JAVA_OPTIONS

fetch() {
    mkdir -p "$prefix"
    cd "$prefix"
    wget -c "https://download-cdn.jetbrains.com/$downdir/$archive.tar.gz"
    tar xf "$archive.tar.gz"
    rm "$archive.tar.gz"
}

setup() {
    :
}

run() {
    test -d "$prefix_app" || fetch

    mkdir -p "$XDG_DATA_HOME/JetBrains/java_prefs" "$HOME/.java"
    ln -sf "$XDG_DATA_HOME/JetBrains/java_prefs" "$HOME/.java/.userPrefs"

    cd "$prefix_app"
    exec "./bin/$name" "$@"
}

case "$cmd" in
    fetch) fetch; exit ;;
    setup) setup; exit ;;
    run) run "$@"; exit ;;
esac
