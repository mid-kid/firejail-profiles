#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/jetbrains}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

version_clion=2022.3
downdir_clion=cpp
archive_clion="CLion-$version_clion"
dirname_clion="clion-$version_clion"
version_pycharm=2022.3
downdir_pycharm=python
archive_pycharm="pycharm-professional-$version_pycharm"
dirname_pycharm="pycharm-$version_pycharm"
version_pycharm_community=2022.3
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

# Set to whatever you've set your user's -Djava.util.prefs.userRoot to...
JAVA_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/java"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget "https://download-cdn.jetbrains.com/$downdir/$archive.tar.gz"
    tar xf "$archive.tar.gz" -C "$prefix"
}

setup() {
    :
}

run() {
    test -d "$prefix_app" || fetch

    mkdir -p "$XDG_DATA_HOME/JetBrains/java_prefs" "$JAVA_CONFIG/.java"
    ln -sf "$XDG_DATA_HOME/JetBrains/java_prefs" "$JAVA_CONFIG/.java/.userPrefs"

    cd "$prefix_app"
    exec "./bin/$name.sh" "$@"
}

case "$cmd" in
    fetch) fetch; exit ;;
    setup) setup; exit ;;
    run) run "$@"; exit ;;
esac
