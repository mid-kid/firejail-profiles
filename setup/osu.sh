#!/bin/sh
set -e

export WINEARCH=win32
export WINEPREFIX="$prefix"

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

    "$tmp/winetricks" dotnet45
    "$tmp/winetricks" ddr=opengl fontsmooth=rgb sound=alsa strictdrawordering=enabled
    regedit "$tmp/directsound-latency.reg"
    wine "$tmp/osu!install.exe"
}

run() {
    vblank_mode=0 __GL_SYNC_TO_VBLANK=0 exec wine "$WINEPREFIX/drive_c/users/$USER/Local Settings/Application Data/osu!/osu!.exe" $@
}

case "$1" in
    setup) setup ;;
    run) run ;;
esac
