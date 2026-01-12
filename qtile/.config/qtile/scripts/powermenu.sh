#!/usr/bin/env bash
#############################################################################
##         _    _
##    _ __| | _| |
##   | '__| |/ / |   Richard Klein Leugemors
##   | |  |   <| |   https://www.github.com/leugemors/
##   |_|  |_|\_\_|
##
##   Powermenu, to lock, reboot or shutdown the computer.
##
#############################################################################

lockapp="/usr/local/bin/lockscreen.sh"

theme="material"

# theme="nord"

# theme="rounded-blue-dark"
# theme="rounded-green-dark"
# theme="rounded-nord-dark"
# theme="rounded-purple-dark"

# theme="squared-everforest"
# theme="squared-material-red"
# theme="squared-nord"

# theme="windows11-list-dark"

# ---------------------------------------------------------------------------
#  Build the menu
# ---------------------------------------------------------------------------

option1="  - Lock"
option2="  - Logout"
option3="  - Reboot"
option4="  - Power Off"

options="${option1}\n${option2}\n${option3}\n${option4}"

# ---------------------------------------------------------------------------
#  Show the menu and ask the user to make a choise
# ---------------------------------------------------------------------------

choice=$(echo -e "$options" | rofi -dmenu -replace -theme ${theme} -i -l 4 -p "Powermenu") 

case ${choice} in
	"${option1}")
		${lockapp} ;;
	"${option2}")
		qtile cmd-obj -o cmd -f shutdown ;;
	"${option3}")
		systemctl reboot ;;
	"${option4}")
		systemctl poweroff ;;
esac

### eof #####################################################################
