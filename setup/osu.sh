#!/bin/sh
set -e

# This was mostly taken from the osu AUR package

prefix="${prefix:-$HOME/.local/opt/osu}"

# God fucking shit breaking every updatae aaaaaaaaaaaaaaaaa
WINE=wine-staging-7.15

export WINEARCH=win32
export WINEPREFIX="$prefix"
export WINEDLLPATH="$prefix/bin64:$prefix/bin32"

export PULSE_LATENCY_MSEC=22

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

    if ! command -v cabextract > /dev/null 2> /dev/null; then
        echo "WARNING: cabextract not found, necessary for installing..."
    fi

    WINEDLLOVERRIDES='mscoree=' winecfg
    W_TMP="$tmp" WINETRICKS_DONWLOADER=wget ./winetricks -q --force dotnet45
    W_TMP="$tmp" WINETRICKS_DOWNLOADER=wget ./winetricks gdiplus corefonts cjkfonts  # optional
    ./winetricks ddr=opengl fontsmooth=rgb sound=alsa strictdrawordering=enabled
    regedit directsound-latency.reg
    vblank_mode=0 __GL_SYNC_TO_VBLANK=0 $exec $WINE "osu!install.exe"
}

run() {
    vblank_mode=0 __GL_SYNC_TO_VBLANK=0 $exec $WINE "$WINEPREFIX/drive_c/users/$USER/Local Settings/Application Data/osu!/osu!.exe" "$@"
}

# Discord wants a PID higher than 10???
exec=exec
if [ -e $XDG_RUNTIME_DIR/discord-ipc-0 ]; then
    exec=''
    for x in $(seq 1 10); do /bin/true; done
fi

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
