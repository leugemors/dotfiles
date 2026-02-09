#!/usr/bin/env bash
#############################################################################
##         _    _
##    _ __| | _| |
##   | '__| |/ / |   Richard Klein Leugemors
##   | |  |   <| |   https://www.github.com/leugemors/
##   |_|  |_|\_\_|
##
##   Configure my fancy monitor at my home office
##
#############################################################################

laptop="eDP"
home1="DisplayPort-9"
office1="DisplayPort-1"
office2="DisplayPort-0"

# ---------------------------------------------------------------------------
#  Configure monitors in a single xrandr command
# ---------------------------------------------------------------------------

configure_office() {
    echo " * Office monitor detected: $office1"

    xrandr --fb 7600x3840 \
           --output "$laptop" \
           --mode 2880x1920 \
           --rate 120.00 \
           --scale 0.7x0.7 \
           --pos 0x0 \
           --output "$office1" \
           --primary \
           --mode 2560x1440 \
           --rate 120.00 \
           --scale 1.0x1.0 \
           --pos 2016x0 \
           --output "$office2" \
           --mode 3840x2160 \
           --rate 30.00 \
           --scale 0.7x0.7 \
           --pos 4576x0 \
           --rotate right
}

configure_home() {
    echo " * Home monitor detected: $home1"
    xrandr --fb 8192x4096 \
           --output "$home1" \
           --primary \
           --mode 3840x2160 \
           --rate 95.03 \
           --scale 0.8x0.8 \
           --pos 0x0 \
           --output "$laptop" \
           --mode 2880x1920 \
           --rate 120.00 \
           --scale 0.7x0.7 \
           --pos 0x2700
}

configure_laptop_only() {
    echo " * Laptop only configuration"
    xrandr --fb 2880x1920 \
           --output "$laptop" \
           --mode 2880x1920 \
           --rate 120.00 \
           --scale 0.7x0.7 \
           --pos 0x0
}

# ---------------------------------------------------------------------------
#  Main script
# ---------------------------------------------------------------------------

if xrandr | grep "$office1 connected"; then
    configure_office
elif xrandr | grep "$home1 connected"; then
    configure_home
elif xrandr | grep "$laptop connected"; then
    configure_laptop_only
fi

# Restore the wallpaper
waypaper --restore 2>&1 >/dev/null

### eof #####################################################################
