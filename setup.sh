#!/bin/bash
set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

extra_args=()

while true; do
    case "$1" in
        --)
            break
            ;;
        --*)
            extra_args+=( "$1" )
            shift
            ;;
        *)
            break
            ;;
    esac
done

prog="$1"; shift
setup="$(realpath "$(dirname "$0")/setup")"
export prefix="$XDG_DATA_HOME/firejail/$prog"

if [ "$1" = shell ]; then
    shift
    exec firejail "${extra_args[@]}" --ignore='shell none' --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" "$@"
fi

if [ "$1" = fetch ]; then
    exec "$setup/$prog.sh" fetch
fi

if [ ! -d "$prefix" ]; then
    "$setup/$prog.sh" fetch
fi
mkdir -p "$prefix"

if [ -z "$1" ]; then
    appimage="$(sed -n -e 's/^# appimage=//p' "$setup/$prog.sh")"
    if [ ! -z "$appimage" ]; then
        case "$appimage" in
            '~/'*) appimage="$HOME/$(echo "$appimage" | cut -c 3-)" ;;
            *) appimage="$prefix/$appimage"
        esac
        echo appimage="$appimage"
        exec firejail "${extra_args[@]}" --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --appimage --join-or-start="$prog" "$appimage" "$@"
    fi
fi

tmp="${TMPDIR:-/tmp}/firejail-$UID/$prog"
mkdir -p "$tmp"
trap "rm -rf '$tmp'/*" EXIT

cp "$setup/$prog.sh" "$tmp"
firejail "${extra_args[@]}" --whitelist="$tmp" --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" sh "$tmp/$prog.sh" "$@"
#firejail "${extra_args[@]}" sh "$tmp/$prog.sh" "$@"
