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
office1="DP-1"

# ---------------------------------------------------------------------------
#  Configure monitors in a single xrandr command
# ---------------------------------------------------------------------------

configure_office() {
    echo " * Office monitor detected: $office1"

    # Calculate framebuffer: office (3840x2160) left-of laptop (4114x2743)
    local fb_w=7954
    local fb_h=2743

    xrandr \
        --fb "${fb_w}x${fb_h}" \
        --output "$office1" \
        --primary \
        --mode 3840x2160 \
        --rate 60.00 \
        --scale 1.0x1.0 \
        --pos 0x0 \
        --output "$laptop" \
        --mode 2880x1920 \
        --rate 120.00 \
        --scale 0.7x0.7 \
        --pos 3840x0
}

configure_home() {
    echo " * Home monitor detected: $home1"

    # Calculate framebuffer: home (4800x2700) above laptop (4114x2743)
    local fb_w=4800
    local fb_h=5443

    xrandr \
        --fb "${fb_w}x${fb_h}" \
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

    # Calculate framebuffer: laptop only (4114x2743)
    local fb_w=4114
    local fb_h=2743

    xrandr \
        --fb "${fb_w}x${fb_h}" \
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

### eof #####################################################################
