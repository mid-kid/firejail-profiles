#!/bin/sh
set -e

# This was mostly taken from the osu AUR package

prefix="${prefix:-$HOME/.local/opt/osu}"

export WINEARCH=win32
export WINEPREFIX="$prefix"
export WINEDLLPATH="$prefix/bin64:$prefix/bin32"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'http://m1.ppy.sh/r/osu!install.exe'
    wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks'
    cat > directsound-latency.reg << 'EOF'
REGEDIT4

[HKEY_CURRENT_USER\Software\Wine\DirectSound]
"_HelBuflen"="8192"
"SndQueueMax"="2"
EOF
    chmod +x winetricks

    WINEDLLOVERRIDES='mscoree=' winecfg
    "$tmp/winetricks" dotnet45
    "$tmp/winetricks" ddr=opengl fontsmooth=rgb sound=alsa strictdrawordering=enabled
    regedit "$tmp/directsound-latency.reg"
    vblank_mode=0 __GL_SYNC_TO_VBLANK=0 $exec wine "$tmp/osu!install.exe"
}

run() {
    vblank_mode=0 __GL_SYNC_TO_VBLANK=0 $exec wine "$WINEPREFIX/drive_c/users/$USER/Local Settings/Application Data/osu!/osu!.exe" "$@"
}

# Discord wants a PID higher than 10???
exec=exec
if [ -e $XDG_RUNTIME_DIR/discord-ipc-0 ]; then
    exec=''
    for x in $(seq 1 10); do /bin/true; done
fi

case "$1" in
    setup) shift; setup ;;
    run) shift; run "$@" ;;
esac

if [ ! -d "$prefix/drive_c" ]; then
    setup
else
    run "$@"
fi
