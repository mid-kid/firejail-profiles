#!/bin/sh
set -e

# This was mostly taken from the osu AUR package

prefix="${prefix:-$HOME/.local/opt/osu}"

# God fucking shit breaking every updatae aaaaaaaaaaaaaaaaa
WINE=wine #wine-staging-7.15

export WINEARCH=win32  # Like it or not, osu! is 32-bit only.
export WINEPREFIX="$prefix"
export WINEDLLOVERRIDES='mshtml='
export WINEDLLPATH="$prefix/bin64:$prefix/bin32"

export vblank_mode=0
export __GL_SYNC_TO_VBLANK=0

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks'
    cat > directsound-latency.reg << 'EOF'
REGEDIT4

[HKEY_CURRENT_USER\Software\Wine\DirectSound]
"HelBuflen"="512"
EOF
    chmod +x winetricks

    if ! command -v cabextract > /dev/null 2> /dev/null; then
        echo "WARNING: cabextract not found, necessary for installing..."
    fi

    # Roughly following lutris install script
    # https://lutris.net/games/install/30085/view
    winecfg
    WINETRICKS_DOWNLOADER=wget ./winetricks -q dotnet48
    WINETRICKS_DOWNLOADER=wget ./winetricks gdiplus  # Graphical fixes
    WINETRICKS_DOWNLOADER=wget ./winetricks \
        corefonts vlgothic meiryo cjkfonts  # Optional fonts
    ./winetricks sound=alsa
    $WINE regedit directsound-latency.reg

    # Cleanup unnecessary files
    rm -r "$prefix/drive_c/windows/assembly"
    rm "$prefix/drive_c/windows/Microsoft.NET"/NETFXRepair.*
    rm "$prefix/drive_c/windows/Microsoft.NET"/Framework*/*.exe
    rm "$prefix/drive_c/windows/Microsoft.NET"/Framework*/*.dll
    rm "$prefix/drive_c/windows/Microsoft.NET"/Framework*/*.hkf
    rm -r "$prefix/drive_c/windows/Microsoft.NET"/Framework*/*/WPF
    rm -r "$prefix/drive_c/windows/Microsoft.NET"/Framework*/*/SetupCache

    wget 'http://m1.ppy.sh/r/osu!install.exe'
    $exec $WINE "osu!install.exe"
}

run() {
    $exec $WINE "$WINEPREFIX/drive_c/users/$USER/AppData/Local/osu!/osu!.exe" "$@"
}

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
