#!/usr/bin/env bash
#############################################################################
##         _    _
##    _ __| | _| |
##   | '__| |/ / |   Richard Klein Leugemors
##   | |  |   <| |   https://www.github.com/leugemors/
##   |_|  |_|\_\_|
##
##   My autostart script for Qtile
##
#############################################################################

# Set the keyboard layout
setxkbmap us

# Change the keyboard caps lock to escape
setxkbmap -option "caps:escape"

# Configure my monitors
${HOME}/.config/qtile/scripts/monitors.sh &

# Restore the wallpaper
waypaper --restore &

# Applet for bluetooth
blueman-applet &

# Applet for network
nm-applet &

# Lightweight compositor for X11
picom --daemon --config "${HOME}/.config/picom/picom.conf" &

# Notification daemon
# dunst -config "${HOME}/.config/dunst/dunstrc" &
dunst &

# Turn on redshift
redshift &

# Start keepassxc
keepassxc &

# Start flameshot for screenshots
flameshot &

# Make sure to sue a dark theme for gnome applications
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'

# Start the screen saver after 5 minutes of inactivity
xss-lock -- i3lock-color -n -i /data/wallpaper/richard/dark-abstract.png &
xset s 300 300

# Standby, suspend, off
xset dpms 900 1200 3600

### eof #####################################################################
