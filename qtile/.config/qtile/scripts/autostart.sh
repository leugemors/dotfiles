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
/usr/local/bin/monitor

# Applet for the network manager
iwgtk -i &

#Applet for bluetooth
blueman-applet &

# Lightweight compositor for X11
picom --daemon --config "${HOME}/.config/picom/picom.conf" &

# Notification daemon
# dunst -config "${HOME}/.config/dunst/dunstrc" &
dunst &

# Turn on redshift
redshift &

# Restore the wallpaper
waypaper --restore &

# Start keepassxc
keepassxc &

# Start flameshot for screenshots
flameshot &

# STart the screen saver after 5 minutes of inactivity
xss-lock -- i3lock-color -n -i /data/wallpaper/richard/dark-abstract.png &
xset s 300 300   # 5 minutes

# Standby, suspend, off
xset dpms 900 1200 3600

# Make sure to sue a dark theme for gnome applications
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'

### eof #####################################################################
