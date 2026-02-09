#############################################################################
##         _    _
##    _ __| | _| |
##   | '__| |/ / |   Richard Klein Leugemors
##   | |  |   <| |   https://www.gitlab.com/leugemors/
##   |_|  |_|\_\_|
##
##   My personal Qtile configuration file, enjoy.
##
#############################################################################

import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from libqtile.dgroups import simple_key_binder

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

# ---------------------------------------------------------------------------
#  Set the home dir for the current user, and some environment variables
# ---------------------------------------------------------------------------

home = os.path.expanduser("~")
os.environ["XCURSOR_SIZE"] = "16"

# ---------------------------------------------------------------------------
#  My default applications
# ---------------------------------------------------------------------------

myBrowser = "librewolf"
myCalculator = "qalculate-gtk"
myCalendar = "gnome-calendar"
myChat = "signal-desktop"
myEditor = "zeditor"
myFilemanager = "nautilus"
myMusic = "spotify-launcher %U"
myPowermenu = home + "/.config/qtile/scripts/powermenu.sh"
myPrtScr = "flameshot gui"
myPrtScrFull = "flameshot full -c -p " + home + "/Pictures/"
mySlack = "slack"
mySysMonitor = "stacer"
# myTerminal = "ghostty"
myTerminal = "alacritty"
myTerminal2 = "alacritty"
myWallpaper = "waypaper"
myWeather = "gnome-weather"

# ---------------------------------------------------------------------------
# My application launcher
# ---------------------------------------------------------------------------

myMenu = "rofi -theme rounded-nord-dark -show drun -show-icons"
# myMenu = "rofi -theme launchpad -show drun -show-icons"
# myMenu = "rofi -theme material -show drun -show-icons"
# myMenu = "rofi -theme windows11-list-dark -show drun -show-icons"

# ---------------------------------------------------------------------------
#  My colours
# ---------------------------------------------------------------------------

black = "#21222c"
red = "#ff5555"
green = "#50fa7b"
yellow = "#ffcb6b"
blue = "#6088cc"
magenta = "#c792ea"
cyan = "#88e9fd"
white = "#f8f9f2"

grey = ["#111111", "#222222", "#333333", "#444444", "#555555", "#666666",
        "#777777", "#888888", "#999999", "#AAAAAA", "#BBBBBB", "#CCCCCC"]

# ---------------------------------------------------------------------------
#  Default configuration
# ---------------------------------------------------------------------------

myBarHeight = 24
myBorderColour = cyan
myBorderWith = 3
# myfont = "FiraCode Nerd Font"
# myFont = "Iosevka Nerd Font"
myFont = "JetBrainsMono Nerd Font"
# myfont = "SauceCodePro Nerd Font"
myFontSize = 18
myLayout = "MonadTall"
myMonadMargin = 15
myColumnMargin = [15, 15, 15, 15]  # [top, right, bottom, left]
myBarMargin = [10, 15, 0, 15]  # [top, right, bottom, left]

# ---------------------------------------------------------------------------
#  Keybindings
# ---------------------------------------------------------------------------

mod = "mod4" # Super key

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc = "Move focus to left"),
    Key([mod], "j", lazy.layout.down(), desc = "Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc = "Move focus up"),
    Key([mod], "l", lazy.layout.right(), desc = "Move focus to right"),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc = "Move window to the left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc = "Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc = "Move window up"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc = "Move window to the right"),

    # Grow windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc = "Grow window to the left"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc = "Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc = "Grow window up"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc = "Grow window to the right"),

    # Some special functions
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc = "Toggle focused window to fullscreen"),
    Key([mod], "n", lazy.layout.normalize(), desc = "Normalize all window sizes"),
    Key([mod], "t", lazy.window.toggle_floating(), desc = "Toggle focused window to floating"),
    Key([mod], "q", lazy.window.kill(), desc = "Quit focused window"),
    Key([mod], "r", lazy.spawncmd(), desc = "Run a command using a prompt widget"),
    Key([mod], "w", lazy.window.kill(), desc = "Quit focused window"),

    # Swap windows for the column layout
    Key([mod], "u", lazy.layout.swap_column_right(), desc = "Swap columns right"),
    Key([mod], "y", lazy.layout.swap_column_left(), desc = "Swap columns left"),

    # Misc settings
    Key([mod, "control"], "b", lazy.hide_show_bar(position='all'), desc="Toggles the bar to show/hide"),
    Key([mod, "control"], "r", lazy.reload_config(), desc = "Reload the config"),
    Key([mod, "control"], "q", lazy.spawn(myPowermenu), desc = "Open power menu"),
    Key([mod, "control"], "w", lazy.spawn(myWallpaper), desc = "Change wallpaper"),
    Key([mod, "control"], "x", lazy.shutdown(), desc = "Shutdown qtile"),

    Key([mod], "comma", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "period", lazy.prev_screen(), desc='Move focus to prev monitor'),

    # Switching between layouts
    Key([mod], "Tab", lazy.next_layout(), desc = "Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.previous_layout(), desc = "Toggle backwards between layouts"),

    # Screenshot functions
    Key([], "Print", lazy.spawn(myPrtScr), desc='Screenshot'),
    Key(["control"], "Print", lazy.spawn(myPrtScrFull), desc = "Full Screenshot"),

    # Start applications
    Key([mod, "control"], "Return", lazy.spawn(myMenu), desc = "Show rofi menu"),
    Key([mod], "Return", lazy.spawn(myTerminal), desc = "Launch terminal"),
    Key([mod], "space", lazy.spawn(myMenu), desc = "Show rofi menu"),
    Key([mod], "escape", lazy.spawn(myPowermenu), desc = "Show the power menu"),

    # The letters H, J, K and L cannot be uses here
    Key([mod, "shift"], "b", lazy.spawn(myBrowser), desc = "Open internet browser"),
    Key([mod, "shift"], "c", lazy.spawn(myCalculator), desc = "Open a simple calculator"),
    Key([mod, "shift"], "f", lazy.spawn(myFilemanager), desc = "Open file manager"),
    Key([mod, "shift"], "g", lazy.spawn(myChat), desc = "Open chat program"),
    Key([mod, "shift"], "s", lazy.spawn(mySlack), desc = "Open Slack"),
    Key([mod, "shift"], "w", lazy.spawn("waypaper --restore"), desc = "Restore wallpaper"),
    Key([mod, "shift"], "z", lazy.spawn(myEditor), desc = "Open a code editor"),

    # Special function keys for sound an brightness
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc = "Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc = "Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc = "Mute volume"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc = "Player on pause"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc = "Skip to previous song"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc = "Skip to next song"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -q s 10%+"), desc = "Brightness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -q s 10%-"), desc = "Brightness down"),
]

# ---------------------------------------------------------------------------
#  Workspaces (groups)
# ---------------------------------------------------------------------------

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
# group_labels = [" ", " ", "󰨞 ", " ", " ", "󰊻 ", " ", "󰭹 ", "󰏆 ", "󰓇 "]

for i in range(len(group_names)):
    groups.append(Group(
        name = group_names[i],
        label = group_labels[i],
        layout = myLayout.lower(),
    ))

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc = "Switch to group {}".format(i.name)),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group = False),
            desc = "Move focused window to group {}".format(i.name)),
    ])

# ---------------------------------------------------------------------------
#  Append ScratchPad to group list
# ---------------------------------------------------------------------------

groups.append(ScratchPad("scratchpad", [
    DropDown("terminal1", myTerminal2, opacity = 0.9, height = 0.8, width = 0.75, x = 0.125, y = 0.01, on_focus_lost_hide = True),
    DropDown("terminal2", myTerminal2, opacity = 0.9, height = 0.8, width = 0.75, x = 0.125, y = 0.01, on_focus_lost_hide = True),
    DropDown("volume", "pavucontrol", opacity = 0.9, height = 0.6, width = 0.5, x = 0.25, y = 0.01, on_focus_lost_hide = False),
    DropDown("music", myMusic, opacity = 0.9, height = 0.95, width = 0.95, x = 0.025, y = 0.01, on_focus_lost_hide = True),
]))

keys.extend([
    Key([mod], "F9", lazy.group["scratchpad"].dropdown_toggle("terminal1")),
    Key([mod], "F10", lazy.group["scratchpad"].dropdown_toggle("terminal2")),
    Key([mod], "F11", lazy.group["scratchpad"].dropdown_toggle("volume")),
    Key([mod], "F12", lazy.group["scratchpad"].dropdown_toggle("music")),
])

# ---------------------------------------------------------------------------
#  Layouts
# ---------------------------------------------------------------------------

layout_theme = {
    "border_width": myBorderWith,
    "margin": myColumnMargin,
    "border_focus": myBorderColour,
    "border_normal": grey[5],
}

# MonadTall specific settings - use integer margin instead of list
monad_theme = {
    "border_width": myBorderWith,
    "margin": myMonadMargin,  # MonadTall requires integer, not list
    "border_focus": myBorderColour,
    "border_normal": grey[5],
    "single_border_width": myBorderWith,
    "single_margin": myMonadMargin,
}

layouts = [
    layout.Columns(**layout_theme),
    layout.MonadTall(**monad_theme),
    layout.MonadWide(**monad_theme),
    layout.MonadThreeCol(**monad_theme),
    layout.Tile(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Floating(),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Spiral(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.Zoomy(**layout_theme),
    # layout.Stack(num_stacks=2),
]

# ---------------------------------------------------------------------------
#  Setup bar decorations
# ---------------------------------------------------------------------------

decor_left = {
    "decorations": [PowerLineDecoration(
        path = "arrow_left"
        # path = "rounded_left"
        # path = "forward_slash"
        # path = "back_slash"
    )],
}

decor_right = {
    "decorations": [PowerLineDecoration(
        path = "arrow_right"
        # path = "rounded_right"
        # path = "forward_slash"
        # path = "back_slash"
    )],
}

# ---------------------------------------------------------------------------
#  Run widget scripts
# ----------------------------------------------------------------------------

def open_browser():
    qtile.cmd_spawn(myBrowser)

def open_calendar():
    qtile.cmd_spawn(myCalendar)

def open_feestdagen():
    qtile.cmd_spawn(myTerminal2 + " --hold -e feestdagen.sh")

def open_filemanager():
    qtile.cmd_spawn(myFilemanager)

def open_stacer():
    qtile.cmd_spawn(mySysMonitor)

def open_launcher():
    qtile.cmd_spawn(myMenu)

def open_powermenu():
    qtile.cmd_spawn(myPowermenu)

def open_wallpaper():
    qtile.cmd_spawn(myWallpaper)

def open_weather():
    qtile.cmd_spawn(myWeather)

def open_network():
    qtile.cmd_spawn(myTerminal + " -e iwctl")

# ---------------------------------------------------------------------------
#  Setup widget style defaults
# ---------------------------------------------------------------------------

widget_defaults = dict(
    font = myFont,
    fontsize = myFontSize,
    padding = 3,
)

extension_defaults = widget_defaults.copy()

# ---------------------------------------------------------------------------
#  Define my widget list
# ---------------------------------------------------------------------------

def init_widgets_list():
    widgets_list = [

        widget.TextBox(
            **decor_left,
            foreground = white,
            background = magenta,
            fontsize = myFontSize + 8,
            margin = 10,
            text = " 󰣇 ",
            mouse_callbacks = {"Button1": open_launcher},
        ),

        widget.Spacer(background = blue, length = 5,),

        widget.GroupBox(
            **decor_left,
            foreground = white,
            background = blue,
            fontsize = myFontSize,
            padding = 0,
            highlight_method = "block",
            active = white,
            block_border = blue,
            block_highlight_text_color = blue,
            highlight = blue,
            highlight_color = [white, white],
            this_current_screen_border = white,
            disable_drag = True,
            rounded = True,
        ),

       widget.GenPollCommand(
            **decor_left,
            foreground = white,
            background = grey[2],
            fmt = "  {} ",
            cmd = "waybar_dominidi",
            shell = True,
            mouse_callbacks = {"Button1": open_feestdagen},
        ),

       widget.GenPollCommand(
            **decor_left,
            foreground = white,
            background = grey[4],
            fmt = "  {} ",
            cmd = "waybar_maya",
            shell = True,
            mouse_callbacks = {"Button1": open_feestdagen},
        ),

      widget.Wttr(
            **decor_left,
            foreground = white,
            background = grey[5],
            location = {"Arnhem": "Arnhem"},   # city or lat,long
            format = " %c %t ",                # condition + temperature
            units = "m",                       # 'm' metric, 'u' US, 'M' old metric style
            update_interval = 900,             # seconds (15 min)
            timeout = 10,                      # seconds per request
            wttr_inversion = False,
            show_wind = True,
            show_humidity = True,
            mouse_callbacks = {'Button1': open_weather},
        ),

        widget.CurrentLayoutIcon(
            **decor_left,
            background = grey[6],
            padding = 0,
            scale = 0.7,
        ),

        widget.CurrentLayout(
            **decor_left,
            background = grey[6],
        ),

        widget.Prompt(
            **decor_left,
            foreground = white,
            background = black,
        ),

        widget.WindowName(
            **decor_left,
            background = black,
            format = "{}",
            # format = " {name} ",
            # empty_group_string = " Desktop ",
        ),

        widget.TextBox(
            **decor_right,
            background = black,
        ),

        widget.ThermalSensor(
            **decor_right,
            foreground = white,
            background = grey[6],
            update_interval = 2,
            format = "  {temp:.0f}{unit} ",
            mouse_callbacks = {'Button1': open_stacer},
        ),

        widget.CheckUpdates(
            **decor_right,
            foreground = white,
            background = grey[5],
            distro = "Arch_checkupdates",
            update_interval = 60,
            colour_have_updates = red,
            colour_no_updates = green,
            display_format = " Upd: {updates} ",
            no_update_string = " Upd: 0 ",
        ),

        widget.Backlight(
            **decor_right,
            foreground = white,
            background = grey[4],
            backlight_name="amdgpu_bl1",
            step=5,
            format="   {percent:.0%} ",
            update_interval=0.5,
        ),

        widget.Battery(
            **decor_right,
            foreground = white,
            background = grey[3],
            battery = 'BAT1',
            charge_char = "▲",
            discharge_char = "▼",
            empty_char = "○",
            full_char = "●",
            not_charging_char = "",
            unknown_char = "?",
            format = "🔋{char} {percent:2.0%} ",
        ),

        widget.Volume(
            **decor_right,
            foreground = white,
            background = grey[2],
            emoji_list = ["🔇", "🔈", "🔉", "🔊"],
            emoji = False,
            fmt = " 󰕾 {} ",
        ),

        widget.Clock(
            **decor_right,
            foreground = white,
            background = grey[1],
            format = "%a %d, %H:%M ",
            mouse_callbacks = {'Button1': open_calendar},
            # mouse_callbacks={ 'Button1': lambda: os.system('notify-send -a qtile "$(date "+%Y-%m-%d %H:%M")" "$(cal)"') },
        ),

        widget.Spacer(background = blue, length = 5,),

        widget.Systray(
            **decor_right,
            foreground = white,
            background = blue,
        ),

        widget.Spacer(**decor_right, background = blue, length = 5,),

        widget.TextBox(
            foreground = white,
            background = magenta,
            fontsize = myFontSize + 2,
            text = " ⏻  ",
            mouse_callbacks = {'Button1': open_powermenu},
        ),
    ]
    return widgets_list

# ---------------------------------------------------------------------------
#  Show my widget bar on all screens
# ---------------------------------------------------------------------------

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    # Remove the systray widget from the list, it craches when shown on multiple monitors
    del widgets_screen2[17:19]
    return widgets_screen2

def init_widgets_screen3():
    widgets_screen3 = init_widgets_list()
    # Remove the systray widget from the list, it craches when shown on multiple monitors
    del widgets_screen3[17:19]
    return widgets_screen3

def init_screens():
    # Bar margin=(top,right,bottom,left)
    return [Screen(top = bar.Bar(widgets = init_widgets_screen1(), margin = myBarMargin, size = myBarHeight)),
            Screen(top = bar.Bar(widgets = init_widgets_screen2(), margin = myBarMargin, size = myBarHeight)),
            Screen(top = bar.Bar(widgets = init_widgets_screen3(), margin = myBarMargin, size = myBarHeight))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()
    widgets_screen3 = init_widgets_screen3()

# ---------------------------------------------------------------------------
#  Floating layouts
# ---------------------------------------------------------------------------

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start = lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

floating_layout = layout.Floating(
	border_focus = blue,
	border_normal = white,
	border_width = 3,
    float_rules = [
        # Run the utility `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class = "confirmreset"),  # gitk
        Match(wm_class = "makebranch"),    # gitk
        Match(wm_class = "maketag"),       # gitk
        Match(wm_class = "waypaper"),
        Match(wm_class = "gnome-calendar"),
        Match(wm_class = "org.gnome.Weather"),
        Match(wm_class = "ssh-askpass"),
        Match(wm_class = "stacer"),
        Match(title = "branchdialog"),     # gitk
        Match(title = "pinentry"),         # GPG key password entry
        Match(title = "Qalculate!"),
    ]
)

# ---------------------------------------------------------------------------
#  General settings
# ---------------------------------------------------------------------------

dgroup_key_binder = None
auto_fullscreen = True
auto_minimize = True
bring_front_click = False
cursor_warp = True
floats_kept_above = True
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True

# ---------------------------------------------------------------------------
#  Hook to autostart script
# ---------------------------------------------------------------------------

@hook.subscribe.startup_once
def autostart():
    autostartscript = home + "/.config/qtile/scripts/autostart.sh"
    subprocess.call([autostartscript])

# ---------------------------------------------------------------------------
#  Window manager name
# ---------------------------------------------------------------------------

wmname = "qtile"

## eof #####################################################################
