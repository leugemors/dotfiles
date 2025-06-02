#!/usr/bin/env bash
#############################################################################
##         _    _
##    _ __| | _| |
##   | '__| |/ / |   Richard Klein Leugemors
##   | |  |   <| |   https://www.github.com/leugemors/
##   |_|  |_|\_\_|
##
##   My autostart script for Qtile.
##
#############################################################################

# Lightweight compositor for X11
picom --daemon --config "${HOME}/.config/picom/picom.conf" &

# Set the keyboard layout
setxkbmap us

# Change the keyboard caps lock to escape
setxkbmap -option "caps:escape"

# Applet for the network manager
nm-applet &

#Applet for bluetooth
blueman-applet &

# Notification daemon
dunst &

# Configure my monitors (defaults to home)
mon-home

# Turn on redshift
# redshift &

# Restore the wallpaper
waypaper --restore &

# Star keepassxc
keepassxc &

### eof #####################################################################
