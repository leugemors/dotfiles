#!/bin/bash

# ~/scripts/qtile-keys.sh

# Extract keybindings from QTile config
config_file="$HOME/.config/qtile/config.py"

# Parse Key() definitions and format for Rofi
grep -E "Key\(|KeyChord\(" "$config_file" | \
    sed -E 's/.*\[(.*)\].*"(.*)".*/\1 → \2/' | \
    # rofi -dmenu -i -p "QTile Keybindings" -theme-str 'window {width: 50%;}' \
    rofi -dmenu -i -replace -theme "material" -i -l 16 -p "QTile Keybindings" \
         -no-custom
