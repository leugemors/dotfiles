# https://github.com/qtile/qtile/discussions/3763
#
# Figured I'd share in case someone else has questions in the future. This
# is how I set up multiple monitor workspaces. Essentially I give each monitor
# an ID, and then each monitor gets 9 workspaces and I can use keycharms to
# swap between them. So if I want to swap to workspace 3 on monitor 2, I would
# press [mod]+2, 3. I've been using it a week or two now and it works well for
# me so far.

from libqtile.config import Group, Key, KeyChord, Match
from libqtile.command import lazy
from libqtile import qtile
from .keys import keys, mod

class screenGenInfo:
    def __init__(self, groupScreen, groups):
        self.groupScreen = groupScreen
        self.groups = groups

class groupGenInfo:
    def __init__(self, spawn=[], matches=[]):
        self.spawn = spawn
        self.matches = matches

screenGens = [
    screenGenInfo(groupScreen=2, groups=[
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
    ]),
    screenGenInfo(groupScreen=3, groups=[
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
    ]),
    screenGenInfo(groupScreen=1, groups=[
        groupGenInfo(spawn=["google-chrome-stable"]),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
    ]),
    screenGenInfo(groupScreen=4, groups=[
        groupGenInfo(spawn=["bluecherry-client"]),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
        groupGenInfo(),
    ]),
]

startScreen = 0

def focus_group(qtile, screen, group):
    qtile.focus_screen(screen)
    qtile.groups_map[group].cmd_toscreen()

def move_window(qtile, screen, group):
    qtile.focus_screen(screen)
    qtile.groups_map[group].cmd_toscreen()
    qtile.window.togroup(group)

groups = []

# Create first set of groups (this ensures the initial groups are placed on the correct monitors)
for screenGen in screenGens:
    group = "{screen}:{group}".format(screen=screenGen.groupScreen, group=1)
    groups.append(Group(
        name=group,
        persist=True,
        spawn=screenGen.groups[0].spawn,
        matches=screenGen.groups[0].matches))

# Create remaining groups
# (the rest of the groups aren't created until they get used, so don't need to be created in any special order)
for screenIndex, screenGen in enumerate(screenGens):
    for groupIndex in range(1, len(screenGen.groups)):
        groupGen = screenGen.groups[groupIndex]
        group = "{screen}:{group}".format(
            screen=screenGen.groupScreen,
            group=groupIndex+1)
        groups.append(Group(
            name=group,
            persist=True,
            spawn=groupGen.spawn,
            matches=groupGen.matches))

# Create key bindings
for screenIndex, screenGen in enumerate(screenGens):
    screen = screenIndex
    groupKeys = []

    for groupIndex in range(0, len(screenGen.groups)):
        group = "{screen}:{group}".format(
            screen=screenGen.groupScreen,
            group=groupIndex+1)
        
        groupKeys.extend([
            Key([], "{group}".format(group=groupIndex+1),
                lazy.function(focus_group, screen, group),
                desc="Switch to group {group}".format(group=group)),

            Key(["shift"], "{group}".format(group=groupIndex+1),
                lazy.window.togroup(group),
                desc="Move focused window to group {group}".format(group=group)),
        ])

    keys.append(KeyChord([mod], "{screen}".format(screen=screenGen.groupScreen), groupKeys))

# Ensure the preferred screen is focused on startup
lazy.function(focus_group, startScreen, "{screen}:{group}".format(screen=screenGens[startScreen].groupScreen, group=1))

